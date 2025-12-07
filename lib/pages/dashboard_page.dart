import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool showSearch = false;
  String selectedYear = "2025-2026";

  final List<String> years = [
    "2023-2024",
    "2024-2025",
    "2025-2026",
    "2026-2027",
  ];

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
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: _buildDrawer(),

        // -------------------- APP BAR --------------------
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage("assets/ssjc.jpg"),
              ),

              const SizedBox(width: 12),

              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),

              IconButton(
                icon: const Icon(Icons.grid_view_rounded, color: Colors.white),
                onPressed: () => _openGridMenu(),
              ),

              const SizedBox(width: 10),

              showSearch
                  ? Expanded(
                      child: Container(
                        height: 38,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: "Search…",
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.close, size: 16),
                              onPressed: () {
                                setState(() => showSearch = false);
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  : IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () => setState(() => showSearch = true),
                    ),

              const SizedBox(width: 10),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedYear,
                    icon: const Icon(Icons.arrow_drop_down),
                    items: years
                        .map((y) => DropdownMenuItem(value: y, child: Text(y)))
                        .toList(),
                    onChanged: (value) {
                      setState(() => selectedYear = value!);
                    },
                  ),
                ),
              ),

              const Spacer(),

              const CircleAvatar(
                radius: 20,
                child: Icon(Icons.person, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------
  //           GRID MENU (OPEN BELOW APP BAR)
  // -------------------------------------------------------
  void _openGridMenu() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.only(top: kToolbarHeight + 10),

              height: MediaQuery.of(context).size.height * 0.73,
              width: MediaQuery.of(context).size.width,

              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
              ),
              padding: const EdgeInsets.all(16),

              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _menuCard(
                    color: const Color(0xFF2196F3),
                    icon: Icons.groups_rounded,
                    title: "Class Attendance",
                    onTap: () {},
                  ),
                  _menuCard(
                    color: const Color(0xFFFFC107),
                    icon: Icons.fact_check_rounded,
                    title: "Hostel Attendance",
                    onTap: () => Get.toNamed('/hostelAttendanceFilter'),
                  ),
                  _menuCard(
                    color: const Color(0xFF4CAF50),
                    icon: Icons.hiking,
                    title: "Issue Outing",
                    onTap: () => Get.toNamed('/outingList'),
                  ),
                  _menuCard(
                    color: const Color(0xFFE53935),
                    icon: Icons.verified_user_rounded,
                    title: "Verify Outing",
                    onTap: () => Get.toNamed('/outingPending'),
                  ),
                ],
              ),
            ),
          ),
        );
      },

      // Smooth Slide Animation
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(anim),
          child: child,
        );
      },
    );
  }

  // -------------------------------------------------------
  //                    MENU CARD WIDGET
  // -------------------------------------------------------
  static Widget _menuCard({
    required Color color,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 45),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------
  //                      DRAWER
  // -------------------------------------------------------
  Widget _buildDrawer() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      child: Drawer(
        backgroundColor: const Color(0xFF1a1a2e),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0f3460), Color(0xFF533483)],
                ),
              ),
              child: const Center(
                child: Text(
                  "Menu",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            _drawerItem(
              icon: Icons.chat_bubble_outline,
              title: "Chat",
              iconColor: Colors.cyanAccent,
              onTap: () {},
            ),

            _drawerExpandable(
              icon: Icons.calendar_today,
              iconColor: Colors.blueAccent,
              title: "Attendance",
              children: [
                _drawerSubItem(
                  "Student Attendance",
                  () => Get.toNamed('/studentAttendance'),
                ),
                _drawerSubItem(
                  "Verify Attendance",
                  () => Get.toNamed('/verifyAttendance'),
                ),
                _drawerSubItem("Outings", () => Get.toNamed('/outingList')),
                _drawerSubItem(
                  "Outings Pending",
                  () => Get.toNamed('/outingPending'),
                ),
              ],
            ),

            _drawerExpandable(
              icon: Icons.assignment_outlined,
              iconColor: Colors.greenAccent,
              title: "Exams",
              children: [
                _drawerSubItem(
                  "Exam Category List",
                  () => Get.toNamed('/examCategoryList'),
                ),
                _drawerSubItem("Exams List", () => Get.toNamed('/examsList')),
                _drawerSubItem(
                  "Student Marks Upload",
                  () => Get.toNamed('/marksUpload'),
                ),
              ],
            ),
            _drawerExpandable(
              icon: Icons.apartment,
              iconColor: Colors.orangeAccent,
              title: "Hostel",
              children: [
                _drawerSubItem("Floors", () => Get.toNamed('/floors')),
                _drawerSubItem("Rooms", () => Get.toNamed('/rooms')),
                _drawerSubItem("Members", () => Get.toNamed('/hostelMembers')),
                _drawerSubItem("Add Hostel", () => Get.toNamed('/addHostel')),
              ],
            ),

            _drawerExpandable(
              icon: Icons.groups_2_outlined,
              iconColor: Colors.pinkAccent,
              title: "HR Management",
              children: [
                _drawerSubItem("Staff", () => Get.toNamed('/staff')),
                _drawerSubItem(
                  "Staff Attendance",
                  () => Get.toNamed('/staffAttendance'),
                ),
              ],
            ),
            _drawerItem(
              icon: Icons.message_outlined,
              title: "Communication",
              iconColor: Colors.tealAccent,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  Widget _drawerExpandable({
    required IconData icon,
    required Color iconColor,
    required String title,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      collapsedIconColor: Colors.white,
      iconColor: Colors.white,
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      children: children,
    );
  }

  Widget _drawerSubItem(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white70)),
      onTap: onTap,
    );
  }
}
