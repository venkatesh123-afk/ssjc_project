import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../api/api_collection.dart';

class ApiService {
  ApiService._(); // 🔒 prevent instantiation

  // 🔐 Local storage
  static final GetStorage box = GetStorage();

  static var token;

  // ================= LOGIN =================
  static Future<Map<String, dynamic>> loginRequest(String endpoint) async {
    final Uri url = Uri.parse(ApiCollection.baseUrl + endpoint);

    try {
      final response = await http
          .post(
            url,
            headers: const {
              "Content-Type": "application/x-www-form-urlencoded",
              "Accept": "application/json",
            },
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          "Login failed (${response.statusCode}): ${response.body}",
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  // ================= GET REQUEST =================
  static Future<Map<String, dynamic>> getRequest(String endpoint) async {
    final Uri url = Uri.parse(ApiCollection.baseUrl + endpoint);

    final String? token = box.read('token');

    if (token == null || token.isEmpty) {
      throw Exception("No token found. Please login again.");
    }

    try {
      final response = await http
          .get(
            url,
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $token",
            },
          )
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          "GET API Error (${response.statusCode}): ${response.body}",
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
