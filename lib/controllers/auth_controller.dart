// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import '../api/api_collection.dart';
// import '../api/api_service.dart';
// import '../utils/get_storage.dart'; // ✅ ADD THIS

// class AuthController extends GetxController {
//   var isLoading = false.obs;

//   final box = GetStorage();

//   Future<void> login(String username, String password) async {
//     try {
//       isLoading.value = true;

//       final response = await ApiService.loginRequest(
//         ApiCollection.login(username, password),
//       );

//       print("LOGIN RESPONSE => $response");

//       if (response["access_token"] != null) {
//         final token = response["access_token"];

//         // ✅ 1. SAVE TOKEN (API USE)
//         AppStorage.saveToken(token);

//         // ✅ 2. SAVE LOGIN STATE (NAVIGATION USE)
//         AppStorage.setLoggedIn(true);

//         // ✅ 4. GO TO DASHBOARD
//         Get.offAllNamed('/dashboard');
//       } else {
//         Get.snackbar(
//           "Login Failed",
//           response["message"] ?? "Invalid username or password",
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       print("LOGIN ERROR => $e");

//       Get.snackbar(
//         "Network Error",
//         "Unable to connect to server",
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssjc_p/utils/get_storage.dart';
import '../api/api_service.dart';
import 'profile_controller.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;

  // ================= LOGIN =================
  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;

      // ✅ CALL DEDICATED LOGIN API (MATCHES POSTMAN)
      final response = await ApiService.login(
        username: username,
        password: password,
      );

      // ✅ SUCCESS CHECK - Handle different success formats
      final isSuccess = response["success"] == true ||
          response["success"] == "true" ||
          response["success"] == 1;

      if (isSuccess && response["access_token"] != null) {
        // 🔥 CLEAR PREVIOUS USER'S PROFILE DATA (MULTI-USER SUPPORT)
        _clearProfileController();

        // 🔐 SAVE SESSION
        AppStorage.saveToken(response["access_token"]);
        AppStorage.saveUserId(response["userid"]);
        AppStorage.setLoggedIn(true);

        // 🚀 GO TO DASHBOARD
        Get.offAllNamed('/dashboard');
      } else {
        // Extract error message
        final errorMsg = response["message"] ??
            response["error"] ??
            response["msg"] ??
            "Invalid credentials";

        Get.snackbar(
          "Login Failed",
          errorMsg,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("LOGIN ERROR => $e");

      // Extract error message from exception
      String errorMessage = "Server connection failed";
      final errorString = e.toString();

      if (errorString.contains("Invalid") ||
          errorString.contains("credentials") ||
          errorString.contains("Invalid credentials")) {
        errorMessage = "Invalid credentials";
      } else if (errorString.contains("Network") ||
          errorString.contains("connection")) {
        errorMessage = "Network error: Please check your internet connection";
      } else if (errorString.contains("timeout") ||
          errorString.contains("Timeout")) {
        errorMessage = "Connection timeout: Please try again";
      } else if (errorString.contains("Server error")) {
        errorMessage = "Server error: Please try again later";
      } else {
        // Try to extract the actual error message from the exception
        // Remove "Exception: " prefix if present
        errorMessage = errorString.replaceFirst("Exception: ", "").trim();
        if (errorMessage.isEmpty) {
          errorMessage = "Login failed: Please try again";
        }
      }

      Get.snackbar(
        "Error",
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ================= CLEAR PROFILE CONTROLLER =================
  void _clearProfileController() {
    if (Get.isRegistered<ProfileController>()) {
      final profileController = Get.find<ProfileController>();
      // Clear profile data
      profileController.profile.value = null;
      profileController.isLoading.value = true;
    }
  }

  // ================= LOGOUT =================
  void logout() {
    // 🔥 CLEAR PROFILE CONTROLLER (MULTI-USER SUPPORT)
    if (Get.isRegistered<ProfileController>()) {
      Get.delete<ProfileController>(force: true);
    }

    // 🔥 CLEAR STORED USER SESSION
    AppStorage.clear();

    // ❌ DO NOT delete ThemeController
    // ✅ Delete ONLY AuthController
    if (Get.isRegistered<AuthController>()) {
      Get.delete<AuthController>(force: true);
    }

    // 🔑 RE-REGISTER FOR NEXT USER
    Get.lazyPut<AuthController>(() => AuthController());

    // 🚪 BACK TO LOGIN
    Get.offAllNamed('/login');
  }
}
