import 'package:get/get.dart';
import '../api/api_service.dart';
import '../api/api_collection.dart';
import '../model/fee_head_model.dart';

class FeeController extends GetxController {
  var isLoading = false.obs;
  var feeHeads = <FeeHeadModel>[].obs;

  Future<void> loadFeeHeads(int branchId) async {
    try {
      isLoading.value = true;
      feeHeads.clear();

      final data = await ApiService.getRequest(
        ApiCollection.feeHeadsByBranch(branchId),
      );

      if (data['success'] == "true") {
        feeHeads.value = (data['indexdata'] as List)
            .map((e) => FeeHeadModel.fromJson(e))
            .where((f) => f.status == 1) // ✅ active fees only
            .toList();
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load fee heads");
    } finally {
      isLoading.value = false;
    }
  }

  void clear() {
    feeHeads.clear();
  }
}
