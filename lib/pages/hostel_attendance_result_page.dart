import 'package:flutter/material.dart';

class HostelAttendanceResultPage extends StatefulWidget {
  const HostelAttendanceResultPage({super.key});

  @override
  State<HostelAttendanceResultPage> createState() =>
      _HostelAttendanceResultPageState();
}

class _HostelAttendanceResultPageState
    extends State<HostelAttendanceResultPage> {
  String _query = "";

  // Filters
  String _attendanceFilter = "All";
  String _selectedFloor = "All";
  String? _selectedRoom;
  String? _selectedIncharge;

  // Neon Theme Colors
  static const Color neonCyan = Color(0xFF00FFF5);
  static const Color darkNavy = Color(0xFF1a1a2e);
  static const Color darkBlue = Color(0xFF16213e);
  static const Color midBlue = Color(0xFF0f3460);
  static const Color purpleDark = Color(0xFF533483);

  final List<List<String>> _rows = [
    ['1', 'C-201', '2ND FLOOR C & D BLOCKS', 'GOSU ABHISHEK SAGAR', '7', '0'],
    ['2', 'C-202', '2ND FLOOR C & D BLOCKS', 'GOSU ABHISHEK SAGAR', '7', '0'],
    ['3', 'C-203', '2ND FLOOR C & D BLOCKS', 'GOSU ABHISHEK SAGAR', '8', '0'],
    ['4', 'C-204', '2ND FLOOR C & D BLOCKS', 'GOSU ABHISHEK SAGAR', '9', '0'],
  ];

  // Floor extraction logic
  String _floorFromRoom(String room) {
    final match = RegExp(r'\d+').firstMatch(room);
    if (match == null) return 'Unknown';

    final num = match.group(0)!;

    switch (num[0]) {
      case '0':
      case '1':
        return '1st Floor';
      case '2':
        return '2nd Floor';
      case '3':
        return '3rd Floor';
      default:
        return '${num[0]}th Floor';
    }
  }

  // ---------------------- FILTER BOTTOM SHEET ----------------------
  void _openFilters() {
    String tempAttendance = _attendanceFilter;
    String tempFloor = _selectedFloor;
    String? tempRoom = _selectedRoom;
    String? tempIncharge = _selectedIncharge;

    final floors = <String>{};
    final rooms = <String>{};
    final incharges = <String>{};

    for (var row in _rows) {
      floors.add(_floorFromRoom(row[1]));
      rooms.add(row[1]);
      incharges.add(row[3]);
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF16213e), Color(0xFF0f3460)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
          ),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: StatefulBuilder(
            builder: (context, setModal) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Filters",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white70),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    _sectionTitle("Attendance"),

                    _radio("All", tempAttendance, (v) {
                      setModal(() => tempAttendance = v!);
                    }),
                    _radio("Present", tempAttendance, (v) {
                      setModal(() => tempAttendance = v!);
                    }),
                    _radio("Absent", tempAttendance, (v) {
                      setModal(() => tempAttendance = v!);
                    }),

                    const SizedBox(height: 12),
                    _sectionTitle("Floor Wise"),

                    Wrap(
                      spacing: 8,
                      children: [
                        _chip("All", tempFloor == "All", () {
                          setModal(() => tempFloor = "All");
                        }),
                        ...floors.map(
                          (f) => _chip(f, tempFloor == f, () {
                            setModal(() => tempFloor = f);
                          }),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    _sectionTitle("Room Wise"),

                    Wrap(
                      spacing: 8,
                      children: [
                        _chip("All", tempRoom == null, () {
                          setModal(() => tempRoom = null);
                        }),
                        ...rooms.map(
                          (r) => _chip(r, tempRoom == r, () {
                            setModal(() => tempRoom = r);
                          }),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    _sectionTitle("Incharge Wise"),

                    Wrap(
                      spacing: 8,
                      children: [
                        _chip("All", tempIncharge == null, () {
                          setModal(() => tempIncharge = null);
                        }),
                        ...incharges.map(
                          (i) => _chip(i, tempIncharge == i, () {
                            setModal(() => tempIncharge = i);
                          }),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: neonCyan,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _attendanceFilter = tempAttendance;
                            _selectedFloor = tempFloor;
                            _selectedRoom = tempRoom;
                            _selectedIncharge = tempIncharge;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Apply Filters",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  // ---------------- UI ELEMENTS -----------------

  Widget _radio(String title, String group, Function(String?) onChanged) {
    return RadioListTile<String>(
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFB5C7E8),
          fontWeight: FontWeight.w600,
        ),
      ),
      value: title,
      groupValue: group,
      activeColor: neonCyan,
      fillColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.selected)
            ? neonCyan
            : const Color(0xFFB5C7E8),
      ),
      onChanged: onChanged,
    );
  }

  Widget _sectionTitle(String txt) {
    return Text(
      txt,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Color(0xFF9BB0D3),
      ),
    );
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return ChoiceChip(
      selected: selected,
      label: Text(label),
      labelStyle: TextStyle(
        color: selected ? Colors.black : const Color(0xFFB5C7E8),
        fontWeight: FontWeight.w600,
      ),
      selectedColor: neonCyan,
      backgroundColor: const Color(0xFF2b3350),
      elevation: selected ? 3 : 0,
      shadowColor: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: selected ? neonCyan : Colors.white24,
          width: 1.2,
        ),
      ),
      onSelected: (_) => onTap(),
    );
  }

  // ------------------------------ MAIN UI ------------------------------
  @override
  Widget build(BuildContext context) {
    final filtered = _rows.where((row) {
      final sno = row[0];
      final room = row[1];
      final floor = row[2];
      final incharge = row[3];
      final total = int.parse(row[4]);
      final present = int.parse(row[5]);
      final absent = total - present;

      if (_attendanceFilter == "Present" && present == 0) return false;
      if (_attendanceFilter == "Absent" && absent == 0) return false;

      if (_selectedFloor != "All" && _floorFromRoom(room) != _selectedFloor)
        return false;

      if (_selectedRoom != null && room != _selectedRoom) return false;

      if (_selectedIncharge != null && incharge != _selectedIncharge)
        return false;

      if (_query.isNotEmpty) {
        if (!(room.toLowerCase().contains(_query.toLowerCase()) ||
            floor.toLowerCase().contains(_query.toLowerCase()) ||
            incharge.toLowerCase().contains(_query.toLowerCase()) ||
            sno.contains(_query)))
          return false;
      }

      return true;
    }).toList();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [darkNavy, darkBlue, midBlue, purpleDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Hostel Attendance",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            TextButton.icon(
              onPressed: _openFilters,
              icon: const Icon(Icons.filter_list, color: neonCyan),
              label: const Text("Filters", style: TextStyle(color: neonCyan)),
            ),
          ],
        ),

        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 110, 16, 16),
          child: Column(
            children: [
              // SEARCH BAR
              Container(
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white24),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.white70),
                    hintText: "Search by room / floor / incharge / S.No",
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                  ),
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    return _neonCard(filtered[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------ NEON CARD ------------------
  Widget _neonCard(List<String> row) {
    final sno = row[0];
    final room = row[1];
    final floor = row[2];
    final incharge = row[3];
    final total = row[4];
    final present = row[5];
    final absent = int.parse(total) - int.parse(present);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [midBlue.withOpacity(0.55), purpleDark.withOpacity(0.55)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: neonCyan.withOpacity(0.35), width: 1.4),
        boxShadow: [
          BoxShadow(
            color: neonCyan.withOpacity(0.25),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ROW 1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "S.No: $sno",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: neonCyan,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  room,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text("Floor: $floor", style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 6),
          Text(
            "Incharge: $incharge",
            style: const TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 15),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _badge(Icons.people, "Total: $total", neonCyan),
              _badge(
                Icons.check_circle,
                "Present: $present",
                Colors.greenAccent,
              ),
              _badge(Icons.cancel, "Absent: $absent", Colors.redAccent),
            ],
          ),
        ],
      ),
    );
  }

  // Badge UI
  Widget _badge(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color, width: 1.3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
