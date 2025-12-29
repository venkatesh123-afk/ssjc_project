import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/branch_controller.dart';
import '../../controllers/fee_controller.dart';

/// ===================
/// FEE HEAD LIST PAGE
/// ===================
class FeeHeadPage extends StatefulWidget {
  const FeeHeadPage({super.key});

  @override
  State<FeeHeadPage> createState() => _FeeHeadPageState();
}

class _FeeHeadPageState extends State<FeeHeadPage> {
  final BranchController branchCtrl = Get.put(BranchController());
  final FeeController feeCtrl = Get.put(FeeController());

  String? selectedBranch;
  int? selectedBranchId;

  @override
  void initState() {
    super.initState();
    branchCtrl.loadBranches();
  }

  @override
  Widget build(BuildContext context) {
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
          "Fee Heads",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
              const SizedBox(height: 16),

              /// -------- BRANCH DROPDOWN --------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(
                  () => DropdownButtonFormField<String>(
                    value: selectedBranch,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Select Branch",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    items: branchCtrl.branches
                        .map<DropdownMenuItem<String>>(
                          (b) => DropdownMenuItem(
                            value: b.branchName,
                            child: Text(b.branchName),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      final branch = branchCtrl.branches.firstWhere(
                        (b) => b.branchName == v,
                      );

                      setState(() {
                        selectedBranch = v;
                        selectedBranchId = branch.id;
                      });

                      feeCtrl.loadFeeHeads(branch.id);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// -------- FEE HEAD LIST --------
              Expanded(
                child: Obx(() {
                  if (feeCtrl.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.cyan),
                    );
                  }

                  if (feeCtrl.feeHeads.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Fee Heads Found",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: feeCtrl.feeHeads.length,
                    itemBuilder: (context, index) {
                      final fee = feeCtrl.feeHeads[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0f3460), Color(0xFF533483)],
                          ),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fee.feeHead,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  fee.feeGroup,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),

                            ElevatedButton(
                              onPressed: () {
                                Get.snackbar(
                                  "Collect Fee",
                                  "Collecting ${fee.feeHead}",
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyanAccent,
                                foregroundColor: Colors.black,
                              ),
                              child: const Text("Collect"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
