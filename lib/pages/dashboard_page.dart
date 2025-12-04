import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/base_screen.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
      child: BaseScreen(
        drawer: _buildDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,

          leading: Builder(
            builder: (context) => Tooltip(
              message: "Open navigation menu",
              textStyle: const TextStyle(color: Colors.white),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ),

          title: const Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),

        body: Padding(
          padding: const EdgeInsets.only(top: 120, left: 16, right: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _neonCard(
                      color1: Colors.blueAccent,
                      color2: Colors.lightBlue,
                      icon: Icons.check_circle,
                      title: "Hostel Attendance",
                      onTap: () => Get.toNamed('/hostelAttendanceFilter'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _neonCard(
                      color1: Colors.purpleAccent,
                      color2: Colors.deepPurple,
                      icon: Icons.hiking,
                      title: "Issue Outing",
                      onTap: () => Get.toNamed('/issueOuting'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _neonCard(
                      color1: Colors.orangeAccent,
                      color2: Colors.deepOrange,
                      icon: Icons.verified_user,
                      title: "Verify Outing",
                      onTap: () => Get.toNamed('/verifyOuting'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  //                       DRAWER
  // ==========================================================

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
            // ------------ HEADER ------------
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0f3460), Color(0xFF533483)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
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

            // ------------ CHAT ------------
            _drawerItem(
              icon: Icons.chat_bubble_outline,
              title: "Chat",
              iconColor: Colors.cyanAccent,
              onTap: () {},
            ),

            // ------------ ATTENDANCE ------------
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
                _drawerSubItem("Outings", () => Get.toNamed('/issueOuting')),
                _drawerSubItem(
                  "Verify Outings",
                  () => Get.toNamed('/verifyOuting'),
                ),
              ],
            ),

            // ------------ EXAMS ------------
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
              ],
            ),

            // ------------ HOSTEL ------------
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

            // ------------ HR MANAGEMENT ------------
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

            // ------------ COMMUNICATION ------------
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

  // ==========================================================
  //                     Neon Card Widget
  // ==========================================================

  Widget _neonCard({
    required Color color1,
    required Color color2,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: color1.withOpacity(0.6),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
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
      ),
    );
  }

  // ==========================================================
  //                     Drawer Items
  // ==========================================================

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
