import 'package:flutter/material.dart';

import 'package:ssjc_p/model/model1.dart';

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

  final List<String> branches = ['SSJC-ADARSHA', 'SSJC-SSG'];
  final List<String> shifts = [
    'Morning Shift',
    'Afternoon Shift',
    'Evening Shift',
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _fetchAttendanceData() async {
    if (selectedBranch == null || selectedShift == null) {
      _showSnackBar('⚠ Please select Branch and Shift', Colors.orange);
      return;
    }

    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

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
      AttendanceRecord(
        batch: 'ADA-SR-MIC2',
        total: 71,
        present: 70,
        absent: 1,
        outing: 0,
      ),
      AttendanceRecord(
        batch: 'ADA-SR-MIC3',
        total: 43,
        present: 41,
        absent: 1,
        outing: 1,
      ),
      AttendanceRecord(
        batch: 'ADA-SR-MIC4',
        total: 33,
        present: 27,
        absent: 6,
        outing: 0,
      ),
      AttendanceRecord(
        batch: 'ADA-SR-SM1',
        total: 54,
        present: 42,
        absent: 12,
        outing: 0,
      ),
      AttendanceRecord(
        batch: 'ADA-SR-SM2',
        total: 59,
        present: 54,
        absent: 5,
        outing: 0,
      ),
    ];

    setState(() {
      attendanceData = mockData;
      isLoading = false;
    });

    _animationController.forward(from: 0.0);
    _showSnackBar('✅ Attendance data loaded successfully', Colors.green);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildFilterCard(),
                      const SizedBox(height: 20),
                      _buildVerifyButton(),
                      const SizedBox(height: 20),
                      if (attendanceData.isNotEmpty) _buildAttendanceTable(),
                      if (attendanceData.isEmpty && !isLoading)
                        _buildEmptyState(),
                      if (isLoading) _buildLoadingState(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // FILTER BOX

  Widget _buildFilterCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00D4FF), Color(0xFF0099FF)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.fact_check, color: Colors.white, size: 24),
              ),
              SizedBox(width: 12),
              Text(
                'Select filters to verify attendance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: 'Branch',
                  icon: Icons.account_tree,
                  iconColor: Color(0xFF00D4FF),
                  value: selectedBranch,
                  items: branches,
                  onChanged: (val) => setState(() => selectedBranch = val),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  label: 'Shift',
                  icon: Icons.access_time,
                  iconColor: Color(0xFF48BB78),
                  value: selectedShift,
                  items: shifts,
                  onChanged: (val) => setState(() => selectedShift = val),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
            SizedBox(width: 6),
            Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
        SizedBox(height: 8),

        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text("Select", style: TextStyle(color: Colors.white60)),
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.white60),
              dropdownColor: Color(0xFF1a1a2e),
              style: TextStyle(color: Colors.white, fontSize: 13),

              items: items.map((item) {
                return DropdownMenuItem(value: item, child: Text(item));
              }).toList(),

              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerifyButton() {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF06B6D4), Color(0xFF3B82F6), Color(0xFF9333EA)],
        ),
        borderRadius: BorderRadius.circular(16),
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
          onTap: isLoading ? null : _fetchAttendanceData,
          borderRadius: BorderRadius.circular(16),

          child: Center(
            child: isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.verified, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Verify Attendance",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceTable() {
    return FadeTransition(
      opacity: _fadeAnimation,

      child: Column(
        children: [
          _buildSummaryCards(),
          SizedBox(height: 12),
          _buildTableHeader(),

          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: attendanceData.length,
            itemBuilder: (_, i) => _buildTableRow(attendanceData[i], i),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(child: _summary("Total", _calculateTotal(), Colors.blue)),
        SizedBox(width: 8),
        Expanded(child: _summary("Present", _calculatePresent(), Colors.green)),
        SizedBox(width: 8),
        Expanded(child: _summary("Absent", _calculateAbsent(), Colors.red)),
      ],
    );
  }

  Widget _summary(String label, int value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.withOpacity(0.12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),

      child: Column(
        children: [
          Text(
            "$value",
            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(label, style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.green, Colors.teal]),
      ),

      child: Row(
        children: const [
          Expanded(
            flex: 3,
            child: Text(
              "Batch",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text("Total", style: TextStyle(color: Colors.white)),
          ),
          Expanded(
            child: Text("Present", style: TextStyle(color: Colors.white)),
          ),
          Expanded(
            child: Text("Absent", style: TextStyle(color: Colors.white)),
          ),
          Expanded(
            child: Text("Out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(AttendanceRecord rec, int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.07)),
        ),
      ),

      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(rec.batch, style: TextStyle(color: Colors.white)),
          ),
          Expanded(child: _cell(rec.total.toString(), Colors.blue)),
          Expanded(child: _cell(rec.present.toString(), Colors.green)),
          Expanded(child: _cell(rec.absent.toString(), Colors.red)),
          Expanded(child: _cell(rec.outing.toString(), Colors.orange)),
        ],
      ),
    );
  }

  Widget _cell(String text, Color color) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      children: const [
        Icon(Icons.table_chart, color: Colors.white70, size: 60),
        SizedBox(height: 10),
        Text(
          "No Data Available",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(height: 5),
        Text(
          "Select filters and tap Verify Attendance",
          style: TextStyle(color: Colors.white54),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CircularProgressIndicator(color: Colors.cyan),
    );
  }

  int _calculateTotal() => attendanceData.fold(0, (sum, r) => sum + r.total);
  int _calculatePresent() =>
      attendanceData.fold(0, (sum, r) => sum + r.present);
  int _calculateAbsent() => attendanceData.fold(0, (sum, r) => sum + r.absent);
}
