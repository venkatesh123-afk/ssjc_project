import 'package:flutter/material.dart';
import '../widgets/search_field.dart';

class StaffListPage extends StatefulWidget {
  const StaffListPage({super.key});

  @override
  State<StaffListPage> createState() => _StaffListPageState();
}

class _StaffListPageState extends State<StaffListPage> {
  // ================= COLORS =================
  static const Color dark1 = Color(0xFF1a1a2e);
  static const Color dark2 = Color(0xFF16213e);
  static const Color dark3 = Color(0xFF0f3460);
  static const Color purpleDark = Color(0xFF533483);
  static const Color neon = Color(0xFF00FFF5);

  final List<Map<String, String>> _allStaff = [
    {'name': 'SRI SARASWATHI GROUPS', 'empId': '666667'},
    {'name': 'AV RAMANA REDDY', 'empId': '666668'},
    {'name': 'NV SURESH', 'empId': '666669'},
    {'name': 'A GANESH REDDY', 'empId': '666670'},
    {'name': 'A G SANKAR REDDY', 'empId': '666671'},
    {'name': 'V VEERA REDDY', 'empId': '666672'},
  ];

  String _query = "";

  void _addStaff() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Add Staff (Demo Action)")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filtered = _allStaff.where((s) {
      return s['name']!.toLowerCase().contains(_query.toLowerCase()) ||
          s['empId']!.contains(_query);
    }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Staff List",
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // ================= BODY =================
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: isDark
                  ? const LinearGradient(
                      colors: [dark1, dark2, dark3, purpleDark],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).scaffoldBackgroundColor,
                        Theme.of(context).colorScheme.surface,
                      ],
                    ),
            ),
          ),

          Column(
            children: [
              const SizedBox(height: 95),

              // ================= SEARCH =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withOpacity(0.12)
                        : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark
                          ? Colors.white24
                          : Theme.of(context).dividerColor,
                    ),
                  ),
                  child: SearchField(
                    hint: "Search by name / employee ID",
                    hintStyle: TextStyle(
                      color: isDark ? const Color(0xFFB5C7E8) : Colors.black54,
                    ),
                    textColor: isDark ? Colors.white : Colors.black,
                    iconColor: isDark ? neon : Colors.black54,
                    onChanged: (v) => setState(() => _query = v),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ================= STAFF LIST =================
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtered.length,
                  itemBuilder: (context, i) {
                    final s = filtered[i];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: isDark
                            ? LinearGradient(
                                colors: [
                                  dark3.withOpacity(0.55),
                                  purpleDark.withOpacity(0.55),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.08),
                                  Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.08),
                                ],
                              ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDark
                              ? neon.withOpacity(0.35)
                              : Theme.of(context).dividerColor,
                          width: 1.3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? neon.withOpacity(0.22)
                                : Colors.black12,
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s['name']!,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Emp ID: ${s['empId']}",
                                style: TextStyle(
                                  color: isDark
                                      ? const Color(0xFFB5C7E8)
                                      : Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),

                          // SERIAL BADGE
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 14,
                            ),
                            decoration: BoxDecoration(
                              color: neon,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "${i + 1}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // ================= ADD STAFF BUTTON =================
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton.icon(
                onPressed: _addStaff,
                icon: Icon(
                  Icons.add,
                  color: isDark ? Colors.black : Colors.white,
                ),
                label: Text(
                  "Add Staff",
                  style: TextStyle(
                    color: isDark ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDark ? neon : Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 22,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
