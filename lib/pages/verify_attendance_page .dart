import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssjc_p/model/model1.dart';
import '../controllers/branch_controller.dart';
import '../model/branch_model.dart';

class VerifyAttendancePage extends StatefulWidget {
  const VerifyAttendancePage({super.key});

  @override
  State<VerifyAttendancePage> createState() => _VerifyAttendancePageState();
}

class _VerifyAttendancePageState extends State<VerifyAttendancePage>
    with SingleTickerProviderStateMixin {
  String? selectedBranch;
  String? selectedShift;

  bool isLoading = false;
  List<AttendanceRecord> attendanceData = [];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // ✅ BRANCH CONTROLLER (API)
  final BranchController branchCtrl = Get.put(BranchController());

  // UI uses List<String>
  List<String> branches = [];

  final List<String> shifts = const [
    'Morning Shift',
    'Afternoon Shift',
    'Evening Shift',
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    // 🔹 LOAD BRANCHES FROM API
    branchCtrl.loadBranches();

    // 🔹 FIXED: MODEL-BASED ACCESS
    ever(branchCtrl.branches, (_) {
      branches = branchCtrl.branches
          .map<String>((BranchModel b) => b.branchName)
          .toList();

      if (branches.isNotEmpty && selectedBranch == null) {
        selectedBranch = branches.first;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // ---------------- FETCH ATTENDANCE ----------------
  Future<void> _fetchAttendanceData() async {
    if (selectedBranch == null || selectedShift == null) {
      _showSnackBar('⚠ Please select Branch & Shift', Colors.orange);
      return;
    }

    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    // 🔹 MOCK DATA (replace with API later)
    final mockData = [
      AttendanceRecord(
        batch: 'ADA-SR-IIITIC',
        total: 59,
        present: 51,
        absent: 8,
        outing: 0,
      ),
      AttendanceRecord(
        batch: 'ADA-SR-MIC1',
        total: 67,
        present: 59,
        absent: 7,
        outing: 1,
      ),
    ];

    setState(() {
      attendanceData = mockData;
      isLoading = false;
    });

    _animationController.forward(from: 0);
    _showSnackBar('✅ Attendance Loaded', Colors.green);
  }

  void _showSnackBar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1a1a2e),
            Color(0xFF16213e),
            Color(0xFF0f3460),
            Color(0xFF533483),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Verify Attendance",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildFilterCard(),
                const SizedBox(height: 20),

                _buildVerifyButton(),
                const SizedBox(height: 25),

                if (isLoading) _buildLoadingState(),
                if (!isLoading && attendanceData.isEmpty) _buildEmptyState(),
                if (attendanceData.isNotEmpty) _buildAttendanceTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- FILTER CARD ----------------
  Widget _buildFilterCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildDropdown(
              label: 'Branch',
              icon: Icons.account_tree,
              iconColor: const Color(0xFF00D4FF),
              value: selectedBranch,
              items: branches,
              onChanged: (v) => setState(() => selectedBranch = v),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildDropdown(
              label: 'Shift',
              icon: Icons.access_time,
              iconColor: const Color(0xFF48BB78),
              value: selectedShift,
              items: shifts,
              onChanged: (v) => setState(() => selectedShift = v),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- DROPDOWN ----------------
  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required Color iconColor,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white24),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: const Text(
                "Select",
                style: TextStyle(color: Colors.white60),
              ),
              dropdownColor: const Color(0xFF1a1a2e),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white60,
              ),
              style: const TextStyle(color: Colors.white, fontSize: 13),
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- BUTTON ----------------
  Widget _buildVerifyButton() {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : _fetchAttendanceData,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyanAccent,
          foregroundColor: Colors.black,
        ),
        child: const Text(
          "Verify Attendance",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ---------------- DATA ----------------
  Widget _buildAttendanceTable() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: attendanceData
            .map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  e.batch,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: const [
          Icon(Icons.inbox, color: Colors.white54, size: 60),
          SizedBox(height: 12),
          Text(
            "No Data Available",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Center(child: CircularProgressIndicator(color: Colors.cyan)),
    );
  }
}
