import 'package:flutter/material.dart';

class VerifyOutingPage extends StatelessWidget {
  final String? name;
  final String? adm;
  final String? time;
  final String? status;
  final String? type;

  const VerifyOutingPage({
    super.key,
    this.name,
    this.adm,
    this.time,
    this.status,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Dark gradients
    final darkGradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF1a1a2e),
        Color(0xFF16213e),
        Color(0xFF0f3460),
        Color(0xFF533483),
      ],
      stops: [0.0, 0.3, 0.6, 1.0],
    );

    // Light gradients
    final lightGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Theme.of(context).scaffoldBackgroundColor,
        Theme.of(context).colorScheme.surface,
      ],
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: isDark ? darkGradient : lightGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppTitle(context, isDark),
                const SizedBox(height: 28),
                Center(
                  child: Text(
                    adm ?? "ADM NO 24037",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.10)
                        : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isDark
                          ? Colors.white30
                          : Theme.of(context).dividerColor,
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRow("Student Name", name ?? "RAMA", isDark),
                      _buildRow("Father Name", "VENKATESWARLU", isDark),
                      _buildRow("Course", "MAINS", isDark),
                      _buildRow("Batch", "ADA-SR-MIC2", isDark),
                      const SizedBox(height: 10),
                      Divider(
                        color: isDark ? Colors.white24 : Colors.black12,
                        thickness: 1,
                      ),
                      const SizedBox(height: 10),
                      _buildRow(
                          "Permission By", "RAKINDI HARI RAMA JOGAIAH", isDark),
                      _buildRow("Purpose", "Medical", isDark),
                      _buildRow("Type", type ?? "Hospital", isDark),
                      _buildRow("Time", time ?? "10:30", isDark),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          "assets/girl.jpg",
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildReportButton(context),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= APP TITLE =================
  Widget _buildAppTitle(BuildContext context, bool isDark) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Row(
        children: [
          Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          const SizedBox(width: 8),
          Text(
            "Verify Outing",
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

  // ================= DATA ROW =================
  Widget _buildRow(String title, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title : ",
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= BUTTON =================
  Widget _buildReportButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF06B6D4),
            Color(0xFF3B82F6),
            Color(0xFF9333EA),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF3B82F6).withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Reported successfully...'),
                backgroundColor: const Color(0xFF3B82F6),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
          child: const Center(
            child: Text(
              'Report In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
