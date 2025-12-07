import 'package:flutter/material.dart';
import '../widgets/search_field.dart';
import '../widgets/ssjc_appbar.dart'; // <-- ADD THIS IMPORT

class StaffListPage extends StatefulWidget {
  const StaffListPage({super.key});

  @override
  State<StaffListPage> createState() => _StaffListPageState();
}

class _StaffListPageState extends State<StaffListPage> {
  // ---------------- THEME COLORS ----------------
  static const Color dark1 = Color(0xFF1a1a2e);
  static const Color dark2 = Color(0xFF16213e);
  static const Color dark3 = Color(0xFF0f3460);
  static const Color purpleDark = Color(0xFF533483);
  static const Color neon = Color(0xFF00FFF5);

  // ---------------- SSJC APPBAR FIELDS ----------------
  String selectedYear = "2025-2026";
  final List<String> years = [
    "2023-2024",
    "2024-2025",
    "2025-2026",
    "2026-2027",
  ];

  // ---------------- STAFF DATA ----------------
  final List<Map<String, String>> _allStaff = [
    {'name': 'SRI SARASWATHI GROUPS', 'empId': '666667'},
    {'name': 'AV RAMANA REDDY', 'empId': '666668'},
    {'name': 'NV SURESH', 'empId': '666669'},
    {'name': 'A GANESH REDDY', 'empId': '666670'},
    {'name': 'A G SANKAR REDDY', 'empId': '666671'},
    {'name': 'V VEERA REDDY', 'empId': '666672'},
  ];

  String _query = "";

  void _addStaff() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Add Staff (Demo Action)")));
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _allStaff.where((s) {
      return s['name']!.toLowerCase().contains(_query.toLowerCase()) ||
          s['empId']!.contains(_query);
    }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,

      // ⭐ SSJC APP BAR ADDED ⭐
      appBar: SSJCAppBar(
        title: "Staff List",
        showSearch: false,
        selectedYear: selectedYear,
        years: years,
        onGridMenu: () {},
        onYearChanged: (value) => setState(() => selectedYear = value),
      ),

      // ---------------- BODY ----------------
      body: Stack(
        children: [
          // ---------------- BACKGROUND ----------------
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [dark1, dark2, dark3, purpleDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // ---------------- MAIN CONTENT ----------------
          Column(
            children: [
              const SizedBox(height: 95), // PERFECT SPACE BELOW APPBAR
              // SEARCH BAR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: SearchField(
                    hint: "Search by name / employee ID",
                    hintStyle: const TextStyle(color: Color(0xFFB5C7E8)),
                    textColor: Colors.white,
                    iconColor: neon,
                    onChanged: (v) => setState(() => _query = v),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ---------------- STAFF CARDS ----------------
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtered.length,
                  itemBuilder: (context, i) {
                    final s = filtered[i];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            dark3.withOpacity(0.55),
                            purpleDark.withOpacity(0.55),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
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
                          // LEFT SIDE DETAILS
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s['name']!,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Emp ID: ${s['empId']}",
                                style: const TextStyle(
                                  color: Color(0xFFB5C7E8),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),

                          // SERIAL NUMBER BADGE
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 14,
                            ),
                            decoration: BoxDecoration(
                              color: neon,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "${i + 1}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
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

          // ---------------- BOTTOM ADD BUTTON ----------------
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton.icon(
                onPressed: _addStaff,
                icon: const Icon(Icons.add, color: Colors.black),
                label: const Text(
                  "Add Staff",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: neon,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 22,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
