import 'package:flutter/material.dart';
import 'package:ssjc_p/model/model2.dart';
import 'package:ssjc_p/pages/verify_outing_page.dart';

class OutingPendingListPage extends StatefulWidget {
  const OutingPendingListPage({super.key});

  @override
  State<OutingPendingListPage> createState() => _OutingPendingListPageState();
}

class _OutingPendingListPageState extends State<OutingPendingListPage> {
  final List<StudentModel> students = [
    StudentModel(
      id: "240379",
      name: "MUPPANENI VENKATA MANI CHARAN",
      permissionBy: "RAKINDI HARI RAMA JOGAIAH",
      image: "assets/girl.jpg",
    ),
    StudentModel(
      id: "251388",
      name: "KUNCHALA ARAVIND BABU",
      permissionBy: "RAKINDI HARI RAMA JOGAIAH",
      image: "assets/girl.jpg",
    ),
    StudentModel(
      id: "242380",
      name: "MADDISANI SAI SUSHANTH",
      permissionBy: "GURUPUTTI VENKAT REDDY",
      image: "assets/girl.jpg",
    ),
  ];

  late List<StudentModel> filteredStudents;

  @override
  void initState() {
    super.initState();
    filteredStudents = List.from(students);
  }

  void searchStudent(String value) {
    setState(() {
      filteredStudents = students
          .where(
            (s) =>
                s.name.toLowerCase().contains(value.toLowerCase()) ||
                s.id.contains(value),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: isDark
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1a1a2e),
                    Color(0xFF16213e),
                    Color(0xFF0f3460),
                    Color(0xFF533483),
                  ],
                  stops: [0.0, 0.3, 0.6, 1.0],
                )
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).scaffoldBackgroundColor,
                    Theme.of(context).colorScheme.surface,
                  ],
                ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppTitle(context, isDark),
                const SizedBox(height: 20),
                _buildMainCard(context, isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= TITLE =================
  Widget _buildAppTitle(BuildContext context, bool isDark) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Row(
        children: [
          Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          const SizedBox(width: 8),
          Text(
            "Outing Pending",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // ================= MAIN CARD =================
  Widget _buildMainCard(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Theme.of(context).dividerColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 20,
            spreadRadius: 4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // ================= SEARCH =================
              TextField(
                onChanged: searchStudent,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: "Search Student",
                  hintStyle: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                  filled: true,
                  fillColor: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Theme.of(context).colorScheme.surface,
                  prefixIcon: Icon(Icons.search,
                      color: isDark ? Colors.white : Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // ================= STUDENT LIST =================
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  final s = filteredStudents[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => VerifyOutingPage(
                            adm: s.id,
                            name: s.name,
                            status: "Pending",
                            time: "10:30",
                            type: "Hospital",
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 18),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withOpacity(0.08)
                            : Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(0.2)
                              : Theme.of(context).dividerColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          // IMAGE
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(s.image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),

                          // DETAILS
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  s.id,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: isDark ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  s.name,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color:
                                        isDark ? Colors.white : Colors.black87,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "Permission By : ${s.permissionBy}",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
