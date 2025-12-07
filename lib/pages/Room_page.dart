import 'package:flutter/material.dart';
import '../widgets/search_field.dart';
import '../widgets/ssjc_appbar.dart'; // <-- SSJC APPBAR IMPORT

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  String _query = '';
  String _viewBy = 'Floor Wise';

  // NEON THEME COLORS
  static const Color dark1 = Color(0xFF1a1a2e);
  static const Color dark2 = Color(0xFF16213e);
  static const Color dark3 = Color(0xFF0f3460);
  static const Color purpleDark = Color(0xFF533483);
  static const Color neon = Color(0xFF00FFF5);

  // SSJC APPBAR REQUIRED
  String selectedYear = "2025-2026";
  final List<String> years = [
    "2023-2024",
    "2024-2025",
    "2025-2026",
    "2026-2027",
  ];

  // ROOM DATA
  final List<Map<String, String>> _rooms = [
    {'room': '101', 'floor': 'Ground Floor', 'hostel': 'SSG EAMCET CAMPUS'},
    {'room': '102', 'floor': 'Ground Floor', 'hostel': 'SSG EAMCET CAMPUS'},
    {'room': '201', 'floor': 'First Floor', 'hostel': 'SSG EAMCET CAMPUS'},
    {'room': '202', 'floor': 'First Floor', 'hostel': 'SSG EAMCET CAMPUS'},
    {'room': '301', 'floor': 'Second Floor', 'hostel': 'SSG NEET & MAINS'},
  ];

  // VIEW BY FILTER BOTTOM SHEET --------------------
  void _chooseViewBy() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        final options = ['Floor Wise', 'Hostel Wise', 'Room Wise'];

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [dark2, dark3],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: options
                .map(
                  (o) => RadioListTile<String>(
                    title: Text(
                      o,
                      style: const TextStyle(
                        color: Color(0xFFB5C7E8),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    activeColor: neon,
                    value: o,
                    groupValue: _viewBy,
                    onChanged: (v) {
                      setState(() => _viewBy = v!);
                      Navigator.pop(context);
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _rooms.where((r) {
      return r['room']!.contains(_query) ||
          r['floor']!.toLowerCase().contains(_query.toLowerCase()) ||
          r['hostel']!.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,

      // ⭐ SSJC APPBAR ADDED ⭐
      appBar: SSJCAppBar(
        title: "Room Management",
        showSearch: false,
        selectedYear: selectedYear,
        years: years,

        // Grid menu (if needed)
        onGridMenu: () {},

        onYearChanged: (value) {
          setState(() => selectedYear = value);
        },
      ),

      // BACKGROUND ---------------------------
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [dark1, dark2, dark3, purpleDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Column(
          children: [
            const SizedBox(height: 95),

            // ⭐ FILTER BUTTON RIGHT SIDE ⭐
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: _chooseViewBy,
                  icon: const Icon(Icons.filter_list, color: neon),
                  label: Text(
                    _viewBy,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: neon,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5),

            // SEARCH FIELD ---------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white24),
                ),
                child: SearchField(
                  hint: 'Search room / floor / hostel',
                  hintStyle: const TextStyle(color: Color(0xFFB5C7E8)),
                  textColor: Colors.white,
                  iconColor: neon,
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ROOMS LIST ---------------------------
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  final r = filtered[i];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          dark3.withOpacity(0.45),
                          purpleDark.withOpacity(0.45),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: neon.withOpacity(0.35),
                        width: 1.3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: neon.withOpacity(0.22),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // LEFT DETAILS
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Room: ${r['room']}",
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Floor: ${r['floor']}",
                              style: const TextStyle(
                                color: Color(0xFFB5C7E8),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Hostel: ${r['hostel']}",
                              style: const TextStyle(
                                color: Color(0xFFB5C7E8),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        // ROOM BADGE
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: neon,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            r['room']!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // ADD ROOM BUTTON ---------------------------
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: neon,
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text(
          "Add Room",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 12,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Add Room (Dummy Action)")),
          );
        },
      ),
    );
  }
}
