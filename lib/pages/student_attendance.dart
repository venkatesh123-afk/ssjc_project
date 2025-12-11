import 'package:flutter/material.dart';

class StudentAttendancePage extends StatefulWidget {
  const StudentAttendancePage({super.key});

  @override
  State<StudentAttendancePage> createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage> {
  String? branch, group, course, batch, exam, subject;

  final List<String> branches = ["SSJC–ADARSA", "SSJC–SSG"];
  final List<String> groups = ["MPC", "BiPC", "MEC", "CEC"];
  final List<String> courses = ["MAINS", "EAMCET", "IPE", "NEET", "ADVANCE"];
  final List<String> batches = ["2023–25", "2024–26", "2025–27"];
  final List<String> exams = [
    "Unit Test–1",
    "Unit Test–2",
    "Quarterly",
    "Half-Yearly",
    "Pre-Final",
    "Final Exam",
  ];
  final List<String> subjects = [
    "Mathematics",
    "Physics",
    "Chemistry",
    "Biology",
    "English",
  ];

  static const Color neon = Color(0xFF00FFF5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Student Attendance",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
              Color(0xFF0f3460),
              Color(0xFF533483),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 120, 16, 40),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: Colors.white24),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF0f3460).withOpacity(0.30),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select filters to view student attendance records",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 22),

                    _filterBox(
                      label: "Select Branch",
                      icon: Icons.school,
                      iconColor: Colors.cyanAccent,
                      value: branch,
                      items: branches,
                      onChanged: (v) => setState(() => branch = v),
                    ),

                    _filterBox(
                      label: "Select Group",
                      icon: Icons.groups,
                      iconColor: Colors.pinkAccent,
                      value: group,
                      items: groups,
                      onChanged: (v) => setState(() => group = v),
                    ),

                    _filterBox(
                      label: "Select Course",
                      icon: Icons.menu_book,
                      iconColor: Colors.blueAccent,
                      value: course,
                      items: courses,
                      onChanged: (v) => setState(() => course = v),
                    ),

                    _filterBox(
                      label: "Select Batch",
                      icon: Icons.calendar_today,
                      iconColor: Colors.orangeAccent,
                      value: batch,
                      items: batches,
                      onChanged: (v) => setState(() => batch = v),
                    ),

                    _filterBox(
                      label: "Select Exam",
                      icon: Icons.assignment,
                      iconColor: Colors.lightGreenAccent,
                      value: exam,
                      items: exams,
                      onChanged: (v) => setState(() => exam = v),
                    ),

                    _filterBox(
                      label: "Select Subject",
                      icon: Icons.bookmark,
                      iconColor: Colors.pinkAccent,
                      value: subject,
                      items: subjects,
                      onChanged: (v) => setState(() => subject = v),
                    ),

                    const SizedBox(height: 25),

                    Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF00E5FF),
                            Color(0xFF2979FF),
                            Color(0xFF7C4DFF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.4),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Fetching Students..."),
                            ),
                          );
                        },
                        child: const Center(
                          child: Text(
                            "Get Students",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    const Center(
                      child: Text(
                        "2025 © SSJC.",
                        style: TextStyle(color: Colors.white60, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterBox({
    required String label,
    required IconData icon,
    required Color iconColor,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1a1a2e),
            Color(0xFF16213e),
            Color(0xFF0f3460),
            Color(0xFF533483),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white24),
        boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 15)],
      ),

      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 16),

          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                dropdownColor: const Color(0xFF1a1a2e),

                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: neon,
                  size: 26,
                ),

                hint: Text(
                  label,
                  style: const TextStyle(color: Colors.white70, fontSize: 15),
                ),

                style: const TextStyle(color: Colors.white, fontSize: 16),

                items: items
                    .map(
                      (item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                    .toList(),

                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
