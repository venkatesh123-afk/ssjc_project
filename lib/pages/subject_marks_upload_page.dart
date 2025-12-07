import 'package:flutter/material.dart';
import '../widgets/ssjc_appbar.dart'; // <-- SSJC APPBAR IMPORT

// REUSABLE BACKGROUND WIDGET
class SSJCBackground extends StatelessWidget {
  final Widget child;

  const SSJCBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: child,
    );
  }
}

class SubjectMarksUploadPage extends StatefulWidget {
  const SubjectMarksUploadPage({super.key});

  @override
  State<SubjectMarksUploadPage> createState() => _SubjectMarksUploadPageState();
}

class _SubjectMarksUploadPageState extends State<SubjectMarksUploadPage> {
  static const Color neon = Color(0xFF00FFF5);

  // FORM FIELDS
  String? branch, group, course, batch, exam, subject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      // ⭐ SSJC APP BAR ADDED ⭐
      appBar: SSJCAppBar(
        title: "Subject Level Marks Upload",
        showSearch: false,
        onGridMenu: () {},
        selectedYear: '',
        years: [],
        body: Container(),
      ),

      body: SSJCBackground(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 120, 18, 160),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF1a1a2e),
                          Color(0xFF16213e),
                          Color(0xFF0f3460),
                          Color(0xFF533483),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      border: Border.all(color: Color(0xFF0f3460), width: 1.3),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF0f3460).withOpacity(0.30),
                          blurRadius: 20,
                        ),
                      ],
                    ),

                    child: Column(
                      children: [
                        buildField(
                          label: "Select Branch",
                          icon: Icons.school,
                          iconColor: Colors.cyanAccent,
                          value: branch,
                          items: ["SSJC–ADARSA", "SSJC–SSG"],
                          onChanged: (v) => setState(() => branch = v),
                        ),

                        buildField(
                          label: "Select Group",
                          icon: Icons.group,
                          iconColor: Colors.purpleAccent,
                          value: group,
                          items: ["MPC", "BiPC", "MEC", "CEC"],
                          onChanged: (v) => setState(() => group = v),
                        ),

                        buildField(
                          label: "Select Course",
                          icon: Icons.menu_book,
                          iconColor: Colors.blueAccent,
                          value: course,
                          items: ["MAINS", "EAMCET", "IPE", "NEET", "ADVANCE"],
                          onChanged: (v) => setState(() => course = v),
                        ),

                        buildField(
                          label: "Select Batch",
                          icon: Icons.date_range,
                          iconColor: Colors.orangeAccent,
                          value: batch,
                          items: ["2023–25", "2024–26", "2025–27"],
                          onChanged: (v) => setState(() => batch = v),
                        ),

                        buildField(
                          label: "Select Exam",
                          icon: Icons.assignment,
                          iconColor: Colors.lightGreenAccent,
                          value: exam,
                          items: [
                            "Unit Test–1",
                            "Unit Test–2",
                            "Quarterly",
                            "Half-Yearly",
                            "Pre-Final",
                            "Final Exam",
                          ],
                          onChanged: (v) => setState(() => exam = v),
                        ),

                        buildField(
                          label: "Select Subject",
                          icon: Icons.book,
                          iconColor: Colors.pinkAccent,
                          value: subject,
                          items: [
                            "Mathematics",
                            "Physics",
                            "Chemistry",
                            "Biology",
                            "English",
                          ],
                          onChanged: (v) => setState(() => subject = v),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // GET STUDENTS BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.groups, color: Colors.black),
                      label: const Text(
                        "Get Students",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: neon,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "2025 © SSJC",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),

            // FIXED BOTTOM BUTTON ROW
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.download, color: Colors.white),
                        label: const Text("Download Format"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.cloud_upload,
                          color: Colors.white,
                        ),
                        label: const Text("Marks Bulk Upload"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
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
      ),
    );
  }

  // ========================= FIELD BUILDER =========================
  Widget buildField({
    required String label,
    required IconData icon,
    required Color iconColor,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 12),

          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: value,
                dropdownColor: const Color(0xFF0f1d3a),
                icon: const Icon(Icons.arrow_drop_down, color: neon),
                hint: Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFFB5C7E8),
                    fontSize: 16,
                  ),
                ),
                items: items
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
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
