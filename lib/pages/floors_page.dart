import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/search_field.dart';
import '../controllers/branch_controller.dart';
import '../model/branch_model.dart';

class FloorsPage extends StatefulWidget {
  const FloorsPage({super.key});

  @override
  State<FloorsPage> createState() => _FloorsPageState();
}

class _FloorsPageState extends State<FloorsPage> {
  String _query = '';

  static const Color dark1 = Color(0xFF1a1a2e);
  static const Color dark2 = Color(0xFF16213e);
  static const Color dark3 = Color(0xFF0f3460);
  static const Color purpleDark = Color(0xFF533483);
  static const Color neon = Color(0xFF00FFF5);

  // ---------------- CONTROLLER ----------------
  final BranchController branchCtrl = Get.put(BranchController());

  int? selectedBranchId;
  String selectedBranchName = "";

  final List<Map<String, String>> _floors = [
    {'floor': 'GROUND FLOOR', 'hostel': 'SSG EAMCET CAMPUS'},
    {'floor': 'FIRST FLOOR', 'hostel': 'SSG EAMCET CAMPUS'},
    {'floor': 'SECOND FLOOR', 'hostel': 'SSG NEET & MAINS'},
  ];

  @override
  void initState() {
    super.initState();
    branchCtrl.loadBranches();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _floors.where((f) {
      return f['floor']!.toLowerCase().contains(_query.toLowerCase()) ||
          f['hostel']!.toLowerCase().contains(_query.toLowerCase());
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
          "Floors List",
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

            // 🔍 SEARCH
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white24),
                ),
                child: SearchField(
                  hint: 'Search floor / hostel',
                  hintStyle: const TextStyle(color: Color(0xFFB5C7E8)),
                  textColor: Colors.white,
                  iconColor: neon,
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 🏫 BRANCH DROPDOWN (FIXED)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() {
                if (branchCtrl.isLoading.value) {
                  return const CircularProgressIndicator(color: neon);
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

            // 🏢 FLOORS LIST
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filtered.length,
                itemBuilder: (context, i) {
                  final item = filtered[i];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(18),
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
                      boxShadow: [
                        BoxShadow(
                          color: neon.withOpacity(0.18),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['floor']!,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),

                        Text(
                          "Hostel: ${item['hostel']}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFB5C7E8),
                          ),
                        ),
                        const SizedBox(height: 2),

                        Text(
                          "Branch: ${selectedBranchName.isEmpty ? 'All Branches' : selectedBranchName}",
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

      // ➕ ADD FLOOR
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: neon,
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text("Add Floor", style: TextStyle(color: Colors.black)),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Add Floor (Dummy Action)")),
          );
        },
      ),
    );
  }
}
