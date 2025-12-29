import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/branch_controller.dart';
import '../model/branch_model.dart';

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

  final BranchController branchCtrl = Get.put(BranchController());

  String _query = "";

  int? selectedBranchId;
  String selectedBranchName = "";

  final List<Map<String, String>> _categories = [
    {"sno": "1", "category": "MAINS"},
    {"sno": "2", "category": "EAMCET"},
    {"sno": "3", "category": "IPE"},
    {"sno": "4", "category": "NEET"},
    {"sno": "5", "category": "ADVANCE"},
  ];

  @override
  void initState() {
    super.initState();
    branchCtrl.loadBranches();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _categories.where((c) {
      return c["category"]!.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Exam Categories",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [dark1, dark2, dark3],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),

              // 🔍 SEARCH
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  onChanged: (v) => setState(() => _query = v),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search category...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // 🏫 BRANCH DROPDOWN (FIXED)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() {
                  if (branchCtrl.isLoading.value) {
                    return const CircularProgressIndicator();
                  }

                  if (branchCtrl.branches.isEmpty) {
                    return const Text(
                      "No branches available",
                      style: TextStyle(color: Colors.white),
                    );
                  }

                  return DropdownButtonFormField<int>(
                    value: selectedBranchId,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Select Branch",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    items: branchCtrl.branches.map<DropdownMenuItem<int>>((
                      BranchModel b,
                    ) {
                      return DropdownMenuItem<int>(
                        value: b.id,
                        child: Text(b.branchName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedBranchId = value;

                        final selected = branchCtrl.branches.firstWhere(
                          (b) => b.id == value,
                        );

                        selectedBranchName = selected.branchName;
                      });
                    },
                  );
                }),
              ),

              const SizedBox(height: 15),

              // 📋 CATEGORY LIST
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final item = filtered[index];

                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          '/examList',
                          arguments: {
                            "category": item["category"],
                            "branchId": selectedBranchId,
                            "branchName": selectedBranchName,
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              dark3.withOpacity(0.45),
                              purpleDark.withOpacity(0.45),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: neon.withOpacity(0.32),
                            width: 1.3,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item['sno']}. ${item['category']}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Branch: ${selectedBranchName.isEmpty ? 'All Branches' : selectedBranchName}",
                              style: const TextStyle(color: Color(0xFFB5C7E8)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
