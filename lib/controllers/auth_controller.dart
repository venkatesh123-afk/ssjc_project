import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api/api_collection.dart';
import '../api/api_service.dart';
import '../utils/get_storage.dart'; // ✅ ADD THIS

class AuthController extends GetxController {
  var isLoading = false.obs;

  final box = GetStorage();

  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;

      final response = await ApiService.loginRequest(
        ApiCollection.login(username, password),
      );

      print("LOGIN RESPONSE => $response");

      if (response["access_token"] != null) {
        final token = response["access_token"];

        // ✅ 1. SAVE TOKEN (API USE)
        AppStorage.saveToken(token);

        // ✅ 2. SAVE LOGIN STATE (NAVIGATION USE)
        AppStorage.setLoggedIn(true);

        // ✅ 3. MEMORY TOKEN FOR CURRENT SESSION
        ApiService.token = token;

        // ✅ 4. GO TO DASHBOARD
        Get.offAllNamed('/dashboard');
      } else {
        Get.snackbar(
          "Login Failed",
          response["message"] ?? "Invalid username or password",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print("LOGIN ERROR => $e");

      Get.snackbar(
        "Network Error",
        "Unable to connect to server",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
