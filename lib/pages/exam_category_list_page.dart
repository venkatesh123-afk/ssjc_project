import 'package:flutter/material.dart';

class ExamCategoryListPage extends StatefulWidget {
  const ExamCategoryListPage({super.key});

  @override
  State<ExamCategoryListPage> createState() => _ExamCategoryListPageState();
}

class _ExamCategoryListPageState extends State<ExamCategoryListPage> {
  static const Color dark1 = Color(0xFF1a1a2e);
  static const Color dark2 = Color(0xFF16213e);
  static const Color dark3 = Color(0xFF0f3460);
  static const Color purpleDark = Color(0xFF533483);
  static const Color neon = Color(0xFF00FFF5);

  String _query = "";

  final List<Map<String, String>> _categories = [
    {"sno": "1", "category": "MAINS", "branch": "SSJC-ADARSA CAMPUS"},
    {"sno": "2", "category": "EAMCET", "branch": "SSJC-ADARSA CAMPUS"},
    {"sno": "3", "category": "IPE", "branch": "SSJC-ADARSA CAMPUS"},
    {"sno": "4", "category": "NEET", "branch": "SSJC-ADARSA CAMPUS"},
    {"sno": "5", "category": "ADVANCE", "branch": "SSJC-ADARSA CAMPUS"},
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _categories.where((c) {
      return c["category"]!.toLowerCase().contains(_query.toLowerCase()) ||
          c["branch"]!.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Exam Category List",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [dark1, dark2, dark3, purpleDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Column(
          children: [
            const SizedBox(height: 95),

            // ------------ WHITE SEARCH BAR -------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // white background
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    // White circle around the search icon
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.black, // black icon
                        size: 22,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: TextField(
                        onChanged: (v) => setState(() => _query = v),
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: "Search category / branch...",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ------------ LIST OF CARDS -------------
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final item = filtered[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          dark3.withOpacity(0.45),
                          purpleDark.withOpacity(0.45),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: neon.withOpacity(0.32),
                        width: 1.3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: neon.withOpacity(0.25),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item['sno']}.  ${item['category']}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Branch: ${item['branch']}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFB5C7E8),
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
      ),
    );
  }
}
