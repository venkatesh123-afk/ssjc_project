import 'package:flutter/material.dart';
import '../widgets/search_field.dart';

class HostelAttendanceResultPage extends StatefulWidget {
  const HostelAttendanceResultPage({super.key});

  @override
  State<HostelAttendanceResultPage> createState() =>
      _HostelAttendanceResultPageState();
}

class _HostelAttendanceResultPageState
    extends State<HostelAttendanceResultPage> {
  String _query = "";

  String _attendanceFilter = "All";
  String _selectedFloor = "All";
  String? _selectedRoom;
  String? _selectedIncharge;

  static const Color neon = Color(0xFF00FFF5);
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

  // FLOOR PARSING
  String _floorFromRoom(String room) {
    final match = RegExp(r'\d+').firstMatch(room);
    if (match == null) return 'Unknown';

    final num = match.group(0)!;
    switch (num[0]) {
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

  // MAIN UI
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

      if (_selectedFloor != "All" && _floorFromRoom(room) != _selectedFloor) {
        return false;
      }

      if (_selectedRoom != null && room != _selectedRoom) return false;
      if (_selectedIncharge != null && incharge != _selectedIncharge) {
        return false;
      }

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
        extendBodyBehindAppBar: false,
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
        ),

        body: Column(
          children: [
            const SizedBox(height: 12),

            //  WHITE SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: SearchField(
                  hint: 'Search floor / hostel',
                  hintStyle: const TextStyle(color: Colors.black54),
                  textColor: Colors.black,
                  iconColor: Colors.black87,
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
            ),

            const SizedBox(height: 16),

            //  LIST DATA
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
    );
  }

  Widget _neonCard(List<String> row) {
    final sno = row[0];
    final room = row[1];
    final floor = row[2];
    final incharge = row[3];
    final total = row[4];
    final present = row[5];
    final absent = int.parse(total) - int.parse(present);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [midBlue.withOpacity(0.55), purpleDark.withOpacity(0.55)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: neon.withOpacity(0.35), width: 1.4),
        boxShadow: [
          BoxShadow(
            color: neon.withOpacity(0.25),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TOP ROW
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
                  color: neon,
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
              _badge(Icons.people, "Total: $total", neon),
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
