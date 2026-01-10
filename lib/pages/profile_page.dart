import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Profile"),
              Tab(text: "Attendance"),
              Tab(text: "Pay Scale"),
              Tab(text: "Leaves"),
              Tab(text: "Change Password"),
              Tab(text: "TFA"),
            ],
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
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const SafeArea(
            child: TabBarView(
              children: [
                _ProfileTab(), // ✅ FULL PROFILE UI
                Center(child: Text("Attendance")),
                Center(child: Text("Pay Scale")),
                Center(child: Text("Leaves")),
                Center(child: Text("Change Password")),
                Center(child: Text("TFA")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ===========================================================
/// PROFILE TAB (FULL CARD-BASED UI)
/// ===========================================================

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= HEADER =================
          Center(
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 55),
                ),
                SizedBox(height: 10),
                Text(
                  "VALLAMREDDY MEERA REDDY",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "MEERAREDDY@GMIL.COM",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          _sectionTitle("Personal Information"),
          _grid([
            _infoCard("Name", "VALLAMREDDY MEERA REDDY"),
            _infoCard("Father's Name", "HANUMA REDDY"),
            _infoCard("Gender", "Male"),
            _infoCard("Date of Birth", "1990-12-18"),
            _infoCard("Nationality", "INDIAN"),
            _infoCard("Marital Status", "Married"),
            _infoCard("Religion", "HINDU"),
            _infoCard("Community", "OC"),
            _infoCard("Blood Group", "B-ve"),
          ]),

          _sectionTitle("Contact Information"),
          _grid([
            _infoCard("Email", "MEERAREDDY@GMIL.COM"),
            _infoCard("Mobile", "9398049086"),
            _infoCard("Alternate Phone", "9398049086"),
            _infoCard(
              "Current Address",
              "MANIKESWARAM, ADDANKI MANDAL",
              fullWidth: true,
            ),
            _infoCard(
              "Permanent Address",
              "MANIKESWARAM, ADDANKI MANDAL",
              fullWidth: true,
            ),
          ]),

          _sectionTitle("Professional Information"),
          _grid([
            _infoCard("Designation", "113"),
            _infoCard("Job Type", "Full Time"),
            _infoCard("Department", "45"),
            _infoCard("Experience", "N/A"),
            _infoCard("Date of Joining", "2023-04-12"),
            _infoCard("Shift", "General"),
          ]),

          _sectionTitle("Identification"),
          _grid([
            _infoCard("PAN", "CPNPM4009P"),
            _infoCard("Aadhar", "415465665578"),
            _infoCard("Passport", "N/A"),
            _infoCard("Driving License", "N/A"),
          ]),

          const SizedBox(height: 24),
          const Center(
            child: Text(
              "2026 © SSJC",
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}

/// ===========================================================
/// REUSABLE UI HELPERS
/// ===========================================================

Widget _sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _grid(List<Widget> children) {
  return Wrap(
    spacing: 12,
    runSpacing: 12,
    children: children,
  );
}

Widget _infoCard(
  String label,
  String value, {
  bool fullWidth = false,
}) {
  return SizedBox(
    width: fullWidth ? double.infinity : 160,
    child: Card(
      color: Colors.white.withOpacity(0.95),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
