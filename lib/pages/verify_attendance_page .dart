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
      duration: Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
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

    setState(() {
      isLoading = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    // Mock data
    final List<AttendanceRecord> mockData = [
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
      AttendanceRecord(
        batch: 'ADM-JR-SM1',
        total: 70,
        present: 63,
        absent: 5,
        outing: 2,
      ),
      AttendanceRecord(
        batch: 'ADM-JR-SM2',
        total: 83,
        present: 73,
        absent: 9,
        outing: 1,
      ),
      AttendanceRecord(
        batch: 'ADM-JR-SM3',
        total: 72,
        present: 65,
        absent: 5,
        outing: 2,
      ),
      AttendanceRecord(
        batch: 'ADM-JR-SM4',
        total: 73,
        present: 67,
        absent: 6,
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
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildAppTitle(context),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFilterCard(),
                        SizedBox(height: 20),
                        _buildVerifyButton(),
                        SizedBox(height: 20),
                        if (attendanceData.isNotEmpty) _buildAttendanceTable(),
                        if (attendanceData.isEmpty && !isLoading)
                          _buildEmptyState(),
                        if (isLoading) _buildLoadingState(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppTitle(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Row(
        children: const [
          SizedBox(width: 14),
          Icon(Icons.arrow_back, color: Colors.white),
          SizedBox(width: 6),
          Text(
            "Verify Attendence",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
            Text(
              label,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
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
              hint: Text(
                'Select',
                style: TextStyle(color: Colors.white60, fontSize: 13),
              ),
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white60,
                size: 20,
              ),
              dropdownColor: Color(0xFF1a1a2e),
              style: TextStyle(color: Colors.white, fontSize: 13),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              items: items.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
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
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.verified, color: Colors.white, size: 22),
                      SizedBox(width: 8),
                      Text(
                        'Verify Attendance',
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
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            // Summary Cards
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildSummaryCard(
                      'Total',
                      _calculateTotal(),
                      Color(0xFF3B82F6),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildSummaryCard(
                      'Present',
                      _calculatePresent(),
                      Color(0xFF10B981),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: _buildSummaryCard(
                      'Absent',
                      _calculateAbsent(),
                      Color(0xFFEF4444),
                    ),
                  ),
                ],
              ),
            ),

            // Table Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                ),
              ),
              child: Row(
                children: [
                  Expanded(flex: 3, child: _buildHeaderText('Batch')),
                  Expanded(flex: 1, child: _buildHeaderText('Total')),
                  Expanded(flex: 1, child: _buildHeaderText('Present')),
                  Expanded(flex: 1, child: _buildHeaderText('Absent')),
                  Expanded(flex: 1, child: _buildHeaderText('Out')),
                ],
              ),
            ),

            // Table Body
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: attendanceData.length,
              itemBuilder: (context, index) {
                return _buildTableRow(attendanceData[index], index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String label, int value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            '$value',
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTableRow(AttendanceRecord record, int index) {
    final bool isEven = index % 2 == 0;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isEven ? Colors.white.withOpacity(0.03) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              record.batch,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: _buildCellText(record.total.toString(), Colors.blue),
          ),
          Expanded(
            flex: 1,
            child: _buildCellText(record.present.toString(), Colors.green),
          ),
          Expanded(
            flex: 1,
            child: _buildCellText(record.absent.toString(), Colors.red),
          ),
          Expanded(
            flex: 1,
            child: _buildCellText(record.outing.toString(), Colors.orange),
          ),
        ],
      ),
    );
  }

  Widget _buildCellText(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00D4FF), Color(0xFF0099FF)],
              ),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(Icons.table_chart, color: Colors.white, size: 40),
          ),
          SizedBox(height: 16),
          Text(
            'No Data Available',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Select filters and click "Verify Attendance"',
            style: TextStyle(color: Colors.white60, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(40),
      child: Center(
        child: Column(
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00D4FF)),
            ),
            SizedBox(height: 16),
            Text(
              'Loading attendance data...',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateTotal() {
    return attendanceData.fold(0, (sum, record) => sum + record.total);
  }

  int _calculatePresent() {
    return attendanceData.fold(0, (sum, record) => sum + record.present);
  }

  int _calculateAbsent() {
    return attendanceData.fold(0, (sum, record) => sum + record.absent);
  }
}
