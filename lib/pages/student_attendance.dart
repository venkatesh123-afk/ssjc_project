import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/branch_controller.dart';
import '../controllers/group_controller.dart';
import '../controllers/course_controller.dart';

class StudentAttendancePage extends StatefulWidget {
  const StudentAttendancePage({super.key});

  @override
  State<StudentAttendancePage> createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage> {
  // ---------------- CONTROLLERS ----------------
  final BranchController branchCtrl = Get.put(BranchController());
  final GroupController groupCtrl = Get.put(GroupController());
  final CourseController courseCtrl = Get.put(CourseController());

  // ---------------- SELECTED VALUES ----------------
  String? branch;
  String? group;
  String? course;
  String? batch;
  String? exam;
  String? subject;

  int? selectedBranchId;
  int? selectedGroupId;
  int? selectedCourseId;

  // ---------------- STATIC DATA ----------------
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
  void initState() {
    super.initState();

    // 🔥 Load branches
    branchCtrl.loadBranches();

    // 🔥 Auto-select first branch
    ever(branchCtrl.branches, (_) {
      if (branchCtrl.branches.isNotEmpty && branch == null) {
        final b = branchCtrl.branches.first;
        branch = b.branchName;
        selectedBranchId = b.id;

        groupCtrl.clear();
        courseCtrl.clear();
        groupCtrl.loadGroups(b.id);

        setState(() {});
      }
    });

    // 🔥 Auto-select first group
    ever(groupCtrl.groups, (_) {
      if (groupCtrl.groups.isNotEmpty && group == null) {
        final g = groupCtrl.groups.first;
        group = g.name;
        selectedGroupId = g.id;

        courseCtrl.clear();
        courseCtrl.loadCourses(g.id);

        setState(() {});
      }
    });
  }

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
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: Colors.white24),
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

                // ---------------- BRANCH ----------------
                Obx(
                  () => _filterBox(
                    label: "Select Branch",
                    icon: Icons.school,
                    iconColor: Colors.cyanAccent,
                    value: branch,
                    items: branchCtrl.branches
                        .map((b) => b.branchName)
                        .toList(),
                    onChanged: (v) {
                      final b = branchCtrl.branches.firstWhere(
                        (e) => e.branchName == v,
                      );

                      setState(() {
                        branch = v;
                        group = null;
                        course = null;
                      });

                      groupCtrl.clear();
                      courseCtrl.clear();
                      groupCtrl.loadGroups(b.id);
                    },
                  ),
                ),

                // ---------------- GROUP ----------------
                Obx(
                  () => _filterBox(
                    label: groupCtrl.groups.isEmpty
                        ? "Select Branch First"
                        : "Select Group",
                    icon: Icons.groups,
                    iconColor: Colors.pinkAccent,
                    value: group,
                    items: groupCtrl.groups.map((g) => g.name).toList(),
                    onChanged: groupCtrl.groups.isEmpty
                        ? null
                        : (v) {
                            final g = groupCtrl.groups.firstWhere(
                              (e) => e.name == v,
                            );

                            setState(() {
                              group = v;
                              course = null;
                            });

                            courseCtrl.clear();
                            courseCtrl.loadCourses(g.id);
                          },
                  ),
                ),

                // ---------------- COURSE (API) ----------------
                Obx(
                  () => _filterBox(
                    label: courseCtrl.courses.isEmpty
                        ? "Select Group First"
                        : "Select Course",
                    icon: Icons.menu_book,
                    iconColor: Colors.blueAccent,
                    value: course,
                    items: courseCtrl.courses.map((c) => c.courseName).toList(),
                    onChanged: courseCtrl.courses.isEmpty
                        ? null
                        : (v) {
                            final c = courseCtrl.courses.firstWhere(
                              (e) => e.courseName == v,
                            );

                            setState(() {
                              course = v;
                              selectedCourseId = c.id;
                            });
                          },
                  ),
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

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: neon,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      Get.snackbar("Success", "Fetching students...");
                    },
                    child: const Text(
                      "Get Students",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }

  // ---------------- FILTER BOX ----------------
  Widget _filterBox({
    required String label,
    required IconData icon,
    required Color iconColor,
    required String? value,
    required List<String> items,
    required Function(String?)? onChanged,
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
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                hint: Text(
                  label,
                  style: const TextStyle(color: Colors.white70),
                ),
                isExpanded: true,
                dropdownColor: const Color(0xFF1a1a2e),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: neon,
                  size: 26,
                ),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                items: items
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
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
