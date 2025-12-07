import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SSJCAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showSearch;
  final String selectedYear;
  final List<String> years;
  final Function() onGridMenu;

  const SSJCAppBar({
    super.key,
    required this.title,
    required this.years,
    required this.onGridMenu,
    required this.showSearch,
    required this.selectedYear,
    required Container body,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),

      title: Row(
        children: [
          // ---------- TITLE ----------
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 10),

          // ---------- GRID MENU ----------
          IconButton(
            icon: const Icon(Icons.grid_view_rounded, color: Colors.white),
            onPressed: () => _openGridMenu(context),
          ),

          const SizedBox(width: 10),
        ],
      ),
    );
  }

  // -------------------------------------------------------
  //           GRID MENU (OPEN BELOW APP BAR)
  // -------------------------------------------------------
  void _openGridMenu(BuildContext context) {
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
    );
  }

  Widget _menuCard({
    required Color color,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
