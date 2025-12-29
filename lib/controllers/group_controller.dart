import 'package:get/get.dart';
import 'package:ssjc_p/api/api_service.dart';
import '../api/api_collection.dart';
import '../model/group_model.dart';

class GroupController extends GetxController {
  var isLoading = false.obs;
  var groups = <GroupModel>[].obs;

  Future<void> loadGroups(int branchId) async {
    try {
      isLoading.value = true;
      groups.clear();

      // ✅ API CALL
      final data = await ApiService.getRequest(
        ApiCollection.groupsByBranch(branchId),
      );

      if (data['success'] == "true") {
        groups.value = (data['indexdata'] as List)
            .map((e) => GroupModel.fromJson(e))
            .toList(); // ✅ LOAD ALL (status 0 + 1)
      }
    } catch (e) {
      print("GROUP API ERROR => $e");
    } finally {
      isLoading.value = false;
    }
  }

  void clear() {
    groups.clear();
  }
}
