import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HostelAttendanceFilterPage extends StatefulWidget {
  const HostelAttendanceFilterPage({super.key});

  @override
  State<HostelAttendanceFilterPage> createState() =>
      _HostelAttendanceFilterPageState();
}

class _HostelAttendanceFilterPageState
    extends State<HostelAttendanceFilterPage> {
  String? _branch;
  String? _hostel;
  String? _floor;
  String? _room;

  String _month = 'Nov';

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),

      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,

        // -----------------------------------------------------------------------
        //                              APP BAR
        // -----------------------------------------------------------------------
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
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
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                "View Hostel Attendance",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),

        // -----------------------------------------------------------------------
        //                          FULL PAGE GRADIENT FIXED
        // -----------------------------------------------------------------------
        body: Container(
          width: double.infinity,
          height: double.infinity,

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
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),

              child: Column(
                children: [
                  // -----------------------------------------------------------------------
                  //                               DROPDOWNS
                  // -----------------------------------------------------------------------
                  _neonDropdown(
                    label: "Select Branch",
                    icon: Icons.school,
                    iconColor: Color(0xFF00FFF5),
                    value: _branch,
                    items: const [
                      DropdownMenuItem(
                        value: 'EAMCET',
                        child: Text('SSJC-EAMCET CAMPUS'),
                      ),
                      DropdownMenuItem(
                        value: 'NEET',
                        child: Text('SSJC-NEET & MAINS'),
                      ),
                    ],
                    onChanged: (v) => setState(() => _branch = v),
                  ),
                  const SizedBox(height: 14),

                  _neonDropdown(
                    label: "Select Hostel",
                    icon: Icons.apartment,
                    iconColor: Color(0xFFD06BFF),
                    value: _hostel,
                    items: const [
                      DropdownMenuItem(value: 'ADARSA', child: Text('ADARSA')),
                      DropdownMenuItem(value: 'VIDHYA', child: Text('VIDHYA')),
                    ],
                    onChanged: (v) => setState(() => _hostel = v),
                  ),
                  const SizedBox(height: 14),

                  _neonDropdown(
                    label: "Select Floor",
                    icon: Icons.layers,
                    iconColor: Color(0xFF4DA3FF),
                    value: _floor,
                    items: const [
                      DropdownMenuItem(value: '1', child: Text('First Floor')),
                      DropdownMenuItem(value: '2', child: Text('Second Floor')),
                    ],
                    onChanged: (v) => setState(() => _floor = v),
                  ),
                  const SizedBox(height: 14),

                  _neonDropdown(
                    label: "Select Room",
                    icon: Icons.meeting_room,
                    iconColor: Color(0xFFFF72C6),
                    value: _room,
                    items: const [
                      DropdownMenuItem(value: 'C-201', child: Text('C-201')),
                      DropdownMenuItem(value: 'C-202', child: Text('C-202')),
                      DropdownMenuItem(value: 'C-203', child: Text('C-203')),
                    ],
                    onChanged: (v) => setState(() => _room = v),
                  ),

                  const SizedBox(height: 14),

                  _neonDropdown(
                    label: "Select Month",
                    icon: Icons.calendar_month,
                    iconColor: Color(0xFFFFE066),
                    value: _month,
                    items: const [
                      DropdownMenuItem(value: 'Jan', child: Text('January')),
                      DropdownMenuItem(value: 'Feb', child: Text('February')),
                      DropdownMenuItem(value: 'Mar', child: Text('March')),
                      DropdownMenuItem(value: 'Apr', child: Text('April')),
                      DropdownMenuItem(value: 'May', child: Text('May')),
                      DropdownMenuItem(value: 'Jun', child: Text('June')),
                      DropdownMenuItem(value: 'Jul', child: Text('July')),
                      DropdownMenuItem(value: 'Aug', child: Text('August')),
                      DropdownMenuItem(value: 'Sep', child: Text('September')),
                      DropdownMenuItem(value: 'Oct', child: Text('October')),
                      DropdownMenuItem(value: 'Nov', child: Text('November')),
                      DropdownMenuItem(value: 'Dec', child: Text('December')),
                    ],
                    onChanged: (v) => setState(() => _month = v!),
                  ),

                  const SizedBox(height: 30),

                  // -----------------------------------------------------------------------
                  //                          GET STUDENTS BUTTON
                  // -----------------------------------------------------------------------
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 8,
                      ),
                      icon: const Icon(Icons.search),
                      label: const Text(
                        'Get Students',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => Get.toNamed('/hostelAttendanceResult'),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // -----------------------------------------------------------------------
                  //                          ACTION BUTTONS
                  // -----------------------------------------------------------------------
                  Row(
                    children: [
                      Expanded(
                        child: _neonButton(
                          label: "Add Attendance",
                          color: Colors.greenAccent,
                          icon: Icons.add,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _neonButton(
                          label: "Check Status",
                          color: Colors.blueAccent,
                          icon: Icons.check_circle,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // -----------------------------------------------------------------------
  //                              NEON DROPDOWN
  // -----------------------------------------------------------------------
  Widget _neonDropdown({
    required String label,
    required IconData icon,
    required Color iconColor,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white24),
      ),

      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 12),

          Expanded(
            child: DropdownButtonFormField<String>(
              dropdownColor: const Color(0xFF16213e),
              style: const TextStyle(color: Colors.white),
              iconEnabledColor: Colors.cyanAccent,
              value: value,

              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),

              items: items,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  //                              NEON BUTTON
  // -----------------------------------------------------------------------
  Widget _neonButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 50,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 7,
        ),
        icon: Icon(icon),
        label: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onPressed: onTap,
      ),
    );
  }
}
