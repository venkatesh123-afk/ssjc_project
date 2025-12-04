import 'package:flutter/material.dart';

class StaffAttendancePage extends StatefulWidget {
  const StaffAttendancePage({super.key});

  @override
  State<StaffAttendancePage> createState() => _StaffAttendancePageState();
}

class _StaffAttendancePageState extends State<StaffAttendancePage> {
  // THEME COLORS
  static const Color dark1 = Color(0xFF1a1a2e);
  static const Color dark2 = Color(0xFF16213e);
  static const Color dark3 = Color(0xFF0f3460);
  static const Color purpleDark = Color(0xFF533483);
  static const Color neon = Color(0xFF00FFF5);

  String query = "";

  // SAMPLE DATA
  final List<Map<String, dynamic>> attendance = [
    {
      "id": "666980",
      "name": "A ANJANEYULU",
      "days": ["A", "A", "A", "A", "A", "A", "A"],
    },
    {
      "id": "667290",
      "name": "A ARUN KUMAR",
      "days": ["A", "A", "A", "A", "A", "A", "A"],
    },
    {
      "id": "666865",
      "name": "A BALARAM",
      "days": ["A", "A", "A", "A", "A", "A", "A"],
    },
    {
      "id": "666870",
      "name": "A G SANKAR REDDY",
      "days": ["A", "A", "A", "A", "A", "A", "A"],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = attendance.where((s) {
      return s["name"]!.toLowerCase().contains(query.toLowerCase()) ||
          s["id"]!.contains(query);
    }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Staff Attendance",
          style: TextStyle(
            color: neon,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: neon),
      ),

      body: Stack(
        children: [
          // BACKGROUND --------------------------
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [dark1, dark2, dark3, purpleDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          Column(
            children: [
              const SizedBox(height: 100),

              // ⭐ SEARCH BAR (Exactly like Staff List Page) ⭐
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // White background
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Color(0xFFE0E0E0)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      // White circular search icon
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.search,
                          color:
                              Colors.black, // Black icon (same as staff list)
                          size: 22,
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Input field
                      Expanded(
                        child: TextField(
                          onChanged: (v) => setState(() => query = v),
                          style: const TextStyle(
                            color: Colors.black, // black text
                            fontSize: 16,
                          ),
                          decoration: const InputDecoration(
                            hintText: "Search by name / user ID",
                            hintStyle: TextStyle(
                              color: Colors.grey, // soft grey hint
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Staff Month Wise - November 2025",
                  style: TextStyle(
                    color: neon,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ⭐ CARD LIST ⭐
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final staff = filtered[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
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
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: neon.withOpacity(0.35)),
                        boxShadow: [
                          BoxShadow(
                            color: neon.withOpacity(0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            staff["name"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "User ID: ${staff["id"]}",
                            style: const TextStyle(
                              color: Color(0xFFB5C7E8),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // ⭐ DAYS ROW ⭐
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (int i = 0; i < staff["days"].length; i++)
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.redAccent,
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${i + 1}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          staff["days"][i],
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 90),
            ],
          ),

          // ⭐ Bottom Buttons ⭐
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "View Staff Biometric Logs",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Take Staff Attendance",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
