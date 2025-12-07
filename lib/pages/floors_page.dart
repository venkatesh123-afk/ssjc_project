import 'package:flutter/material.dart';
import '../widgets/search_field.dart';
import '../widgets/ssjc_appbar.dart'; // <-- IMPORT SSJC APPBAR

class FloorsPage extends StatefulWidget {
  const FloorsPage({super.key});

  @override
  State<FloorsPage> createState() => _FloorsPageState();
}

class _FloorsPageState extends State<FloorsPage> {
  String _query = '';

  static const Color dark1 = Color(0xFF1a1a2e);
  static const Color dark2 = Color(0xFF16213e);
  static const Color dark3 = Color(0xFF0f3460);
  static const Color purpleDark = Color(0xFF533483);
  static const Color neon = Color(0xFF00FFF5);

  final List<Map<String, String>> _floors = [
    {
      'floor': 'GROUND FLOOR',
      'hostel': 'SSG EAMCET CAMPUS',
      'branch': 'SSJC-SSG EAMCET CAMPUS',
    },
    {
      'floor': 'FIRST FLOOR',
      'hostel': 'SSG EAMCET CAMPUS',
      'branch': 'SSJC-SSG EAMCET CAMPUS',
    },
    {
      'floor': 'SECOND FLOOR',
      'hostel': 'SSG NEET & MAINS',
      'branch': 'SSJC-SSG NEET & MAINS',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _floors.where((f) {
      return f['floor']!.toLowerCase().contains(_query.toLowerCase()) ||
          f['hostel']!.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,

      // ⭐ SSJC APP BAR HERE ⭐
      appBar: SSJCAppBar(
        title: "Floors Management",
        showSearch: false,
        onGridMenu: () {},
        body: Container(),
        years: [],
        selectedYear: '',
      ),

      // ---------------- BACKGROUND ----------------
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
            // SPACE BELOW SSJC APP BAR
            const SizedBox(height: 95),

            // ---------------- SEARCH BOX ----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white24, width: 1),
                ),
                child: SearchField(
                  hint: 'Search floor / hostel',
                  hintStyle: const TextStyle(color: Color(0xFFB5C7E8)),
                  textColor: Colors.white,
                  iconColor: neon,
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ---------------- FLOOR CARDS ----------------
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  final item = filtered[i];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
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
                        color: neon.withOpacity(0.32),
                        width: 1.3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: neon.withOpacity(0.18),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['floor']!,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),

                        Text(
                          "Hostel: ${item['hostel']}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFB5C7E8),
                          ),
                        ),
                        const SizedBox(height: 2),

                        Text(
                          "Branch: ${item['branch']}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFB5C7E8),
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

      // ---------------- ADD FLOOR BUTTON ----------------
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: neon,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text("Add Floor", style: TextStyle(color: Colors.black)),
        elevation: 12,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Add Floor (Dummy Action)")),
          );
        },
      ),
    );
  }
}
