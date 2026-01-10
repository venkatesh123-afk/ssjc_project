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
  // ================= CONTROLLERS =================
  final BranchController branchCtrl = Get.put(BranchController());
  final GroupController groupCtrl = Get.put(GroupController());
  final CourseController courseCtrl = Get.put(CourseController());

  // ================= SELECTED VALUES =================
  String? branch;
  String? group;
  String? course;
  String? batch;
  String? exam;
  String? subject;

  int? selectedCourseId;

  // ================= STATIC DATA =================
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

    branchCtrl.loadBranches();

    ever(branchCtrl.branches, (_) {
      if (branchCtrl.branches.isNotEmpty && branch == null) {
        final b = branchCtrl.branches.first;
        branch = b.branchName;
        groupCtrl.loadGroups(b.id);
        setState(() {});
      }
    });

    ever(groupCtrl.groups, (_) {
      if (groupCtrl.groups.isNotEmpty && group == null) {
        final g = groupCtrl.groups.first;
        group = g.name;
        courseCtrl.loadCourses(g.id);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Student Attendance",
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // ================= BODY =================
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? const LinearGradient(
                  colors: [
                    Color(0xFF0b132b),
                    Color(0xFF1c2541),
                    Color(0xFF3a0ca3),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : const LinearGradient(
                  colors: [
                    Color(0xFFF5F6FA),
                    Color(0xFFE8ECF4),
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
              color: isDark ? Colors.transparent : Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: isDark
                  ? Border.all(color: Colors.white.withOpacity(0.25))
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select filters to view student attendance records",
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 28),

                // ================= FILTERS =================
                Obx(() => _filterBox(
                      context: context,
                      label: "Select Branch",
                      icon: Icons.school,
                      iconColor: Colors.cyanAccent,
                      value: branch,
                      items:
                          branchCtrl.branches.map((b) => b.branchName).toList(),
                      onChanged: (v) {
                        final b = branchCtrl.branches
                            .firstWhere((e) => e.branchName == v);
                        setState(() {
                          branch = v;
                          group = null;
                          course = null;
                        });
                        groupCtrl.clear();
                        courseCtrl.clear();
                        groupCtrl.loadGroups(b.id);
                      },
                    )),

                Obx(() => _filterBox(
                      context: context,
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
                              final g = groupCtrl.groups
                                  .firstWhere((e) => e.name == v);
                              setState(() {
                                group = v;
                                course = null;
                              });
                              courseCtrl.clear();
                              courseCtrl.loadCourses(g.id);
                            },
                    )),

                Obx(() => _filterBox(
                      context: context,
                      label: courseCtrl.courses.isEmpty
                          ? "Select Group First"
                          : "Select Course",
                      icon: Icons.menu_book,
                      iconColor: Colors.blueAccent,
                      value: course,
                      items:
                          courseCtrl.courses.map((c) => c.courseName).toList(),
                      onChanged: courseCtrl.courses.isEmpty
                          ? null
                          : (v) {
                              final c = courseCtrl.courses
                                  .firstWhere((e) => e.courseName == v);
                              setState(() {
                                course = v;
                                selectedCourseId = c.id;
                              });
                            },
                    )),

                _filterBox(
                  context: context,
                  label: "Select Batch",
                  icon: Icons.calendar_today,
                  iconColor: Colors.orangeAccent,
                  value: batch,
                  items: batches,
                  onChanged: (v) => setState(() => batch = v),
                ),

                _filterBox(
                  context: context,
                  label: "Select Exam",
                  icon: Icons.assignment,
                  iconColor: Colors.lightGreenAccent,
                  value: exam,
                  items: exams,
                  onChanged: (v) => setState(() => exam = v),
                ),

                _filterBox(
                  context: context,
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                Center(
                  child: Text(
                    "2025 © SSJC.",
                    style: TextStyle(
                      color: isDark ? Colors.white60 : Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= FILTER BOX =================
  Widget _filterBox({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color iconColor,
    required String? value,
    required List<String> items,
    required Function(String?)? onChanged,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        gradient: isDark
            ? const LinearGradient(
                colors: [
                  Color(0xFF0b132b),
                  Color(0xFF1c3faa),
                  Color(0xFF6a2dbf),
                ],
              )
            : null,
        color: isDark ? null : Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.35)
              : Theme.of(context).dividerColor,
        ),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                )
              ]
            : [],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 16),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                hint: Text(label,
                    style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black54)),
                isExpanded: true,
                dropdownColor: isDark ? const Color(0xFF0b132b) : Colors.white,
                icon: Icon(Icons.keyboard_arrow_down,
                    color: isDark ? neon : Colors.black54),
                style: TextStyle(color: isDark ? Colors.white : Colors.black),
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
