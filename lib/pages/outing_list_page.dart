import 'package:flutter/material.dart';
import 'package:ssjc_p/pages/issue_outing.dart';

class OutingListPage extends StatefulWidget {
  const OutingListPage({super.key});

  @override
  State<OutingListPage> createState() => _OutingListPageState();
}

class _OutingListPageState extends State<OutingListPage> {
  bool showStudents = false;
  TextEditingController searchController = TextEditingController();
  int selectedFilter = 0;

  final List<Map<String, dynamic>> students = [
    {
      "name": "Rajesh Kumar",
      "adm": "CS-2021-001",
      "time": "2025-11-23 • 10:30 AM",
      "status": "Approved",
      "type": "Home Pass",
    },
    {
      "name": "Priya Sharma",
      "adm": "IT-2021-045",
      "time": "2025-11-23 • 11:00 AM",
      "status": "Pending",
      "type": "Out Pass",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0f1c2e) : Colors.white,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? [
                      Color(0xFF1a1a2e),
                      Color(0xFF16213e),
                      Color(0xFF0f3460),
                      Color(0xFF533483),
                    ]
                  : [
                      Color(0xFFE0F2FE),
                      Color(0xFFBAE6FD),
                      Color(0xFF7DD3FC),
                      Color(0xFF38BDF8),
                    ],
              stops: [0.0, 0.3, 0.6, 1.0],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildAppTitle(context),
                  const SizedBox(height: 18.0),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      double itemWidth = (constraints.maxWidth - 12) / 2;
                      return Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          SizedBox(
                            width: itemWidth,
                            child: outingCard(
                              "Out Pass",
                              "0",
                              Colors.redAccent,
                              Icons.exit_to_app_rounded,
                            ),
                          ),
                          SizedBox(
                            width: itemWidth,
                            child: outingCard(
                              "Home Pass",
                              "1",
                              Colors.deepPurpleAccent,
                              Icons.home,
                            ),
                          ),
                          SizedBox(
                            width: itemWidth,
                            child: outingCard(
                              "Self Outing",
                              "0",
                              Colors.orangeAccent,
                              Icons.exit_to_app,
                            ),
                          ),
                          SizedBox(
                            width: itemWidth,
                            child: outingCard(
                              "Self Home",
                              "0",
                              Colors.teal,
                              Icons.home,
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 25),

                  // FILTER SECTION
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.07)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Filter Options",
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),

                        // FILTER BUTTONS
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedFilter = 0;
                                  });
                                },
                                child: filterButton(
                                    "All", selectedFilter == 0, isDark),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedFilter = 1;
                                  });
                                },
                                child: filterButton(
                                    "📅 Today", selectedFilter == 1, isDark),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        // SEARCH BAR
                        Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white10 : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white24
                                  : Colors.grey.shade400,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: isDark ? Colors.white70 : Colors.grey,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search students...",
                                    hintStyle: TextStyle(
                                      color:
                                          isDark ? Colors.white70 : Colors.grey,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    // Logic for search filter here if needed
                                    print("Search text: $value");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // BOTTOM BUTTONS
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigoAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          label: const Text("Filter Students"),
                          onPressed: () => setState(() => showStudents = true),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          label: const Text("Issue Outing"),
                          onPressed: () {
                            showIssueOutingDialog(context);
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  // STUDENT LIST
                  if (showStudents)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF193C68), Color(0xFF462A78)],
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      student["name"],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      student["adm"],
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.access_time,
                                          color: Colors.white70,
                                          size: 17,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          student["time"],
                                          style: const TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: student["status"] == "Approved"
                                            ? Colors.green
                                            : Colors.orange,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.white),
                                      ),
                                      child: Text(
                                        student["status"],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      student["type"],
                                      style: const TextStyle(
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildAppTitle(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

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
            "Outing list",
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

  Widget outingCard(String title, String count, Color color, IconData icon) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [color.withOpacity(0.85), color.withOpacity(0.6)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
          const SizedBox(height: 2),
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text("Pending: 0", style: TextStyle(color: Colors.white)),
          const Text("Approved: 0", style: TextStyle(color: Colors.white)),
          const Text(
            "Not Reported: All-In",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget filterButton(String text, bool selected, bool isDark) {
    return Container(
      height: 46,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected
            ? Colors.lightBlue
            : isDark
                ? Colors.white12
                : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected
              ? Colors.white
              : isDark
                  ? Colors.white
                  : Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

void showIssueOutingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      final bool isDark = Theme.of(context).brightness == Brightness.dark;

      return Dialog(
        backgroundColor: isDark ? const Color(0xFF1D2434) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Container(
          padding: const EdgeInsets.all(18),
          height: 260,
          child: Column(
            children: [
              // ❌ removed const here
              Row(
                children: [
                  const Icon(
                    Icons.add_circle,
                    color: Colors.green,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Issue Outing",
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              dropDown(context, "Select Student"),
              const SizedBox(height: 12),
              dropDown(context, "Outing Type"),

              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const IssueOutingPage(
                            studentName: "",
                            outingType: "",
                          ),
                        ),
                      );
                    },
                    child: const Text("Issue"),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget dropDown(BuildContext context, String text) {
  final bool isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    height: 50,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: isDark ? const Color(0xFF293042) : Colors.grey.shade200,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: isDark ? Colors.white24 : Colors.grey.shade400,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: isDark ? Colors.white70 : Colors.black54,
            fontSize: 15,
          ),
        ),
        Icon(
          Icons.arrow_drop_down,
          color: isDark ? Colors.white : Colors.black54,
        ),
      ],
    ),
  );
}
