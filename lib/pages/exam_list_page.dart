import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamsListPage extends StatefulWidget {
  const ExamsListPage({super.key});

  @override
  State<ExamsListPage> createState() => _ExamsListPageState();
}

class _ExamsListPageState extends State<ExamsListPage> {
  static const Color dark1 = Color(0xFF1a1a2e);
  static const Color dark2 = Color(0xFF16213e);
  static const Color dark3 = Color(0xFF0f3460);
  static const Color purpleDark = Color(0xFF533483);
  static const Color neon = Color(0xFF00FFF5);

  String _query = "";

  final List<Map<String, String>> _exams = [
    {
      "sno": "1",
      "examName": "MAINS MODEL WEEKEND TEST-10",
      "category": "MAINS",
      "mode": "SSJC-ADARSA CAMPUS",
    },
    {
      "sno": "2",
      "examName": "WEEKEND TEST-01",
      "category": "MAINS",
      "mode": "SSJC-ADARSA CAMPUS",
    },
    {
      "sno": "3",
      "examName": "MAINS MODEL WEEKEND TEST-08",
      "category": "MAINS",
      "mode": "SSJC-ADARSA CAMPUS",
    },
    {
      "sno": "4",
      "examName": "MAINS MODEL WEEKEND TEST-03",
      "category": "MAINS",
      "mode": "SSJC-ADARSA CAMPUS",
    },
    {
      "sno": "5",
      "examName": "NEET MODEL WEEKEND TEST-01",
      "category": "NEET",
      "mode": "SSJC-ADARSA CAMPUS",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _exams.where((exam) {
      return exam["examName"]!.toLowerCase().contains(_query.toLowerCase()) ||
          exam["category"]!.toLowerCase().contains(_query.toLowerCase()) ||
          exam["mode"]!.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 26),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Exams List",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
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

            // ⭐ SEARCH BAR ⭐
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: TextField(
                        onChanged: (v) => setState(() => _query = v),
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: "Search exam / category / mode...",
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

            // ⭐ EXAMS LIST ⭐
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  final exam = filtered[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(18),
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
                          "${exam['sno']}.  ${exam['examName']}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text(
                          "Category: ${exam['category']}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFB5C7E8),
                          ),
                        ),
                        const SizedBox(height: 4),

                        Text(
                          "Mode: ${exam['mode']}",
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
