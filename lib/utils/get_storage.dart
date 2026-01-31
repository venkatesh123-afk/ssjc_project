import 'package:get_storage/get_storage.dart';

class AppStorage {
  static final GetStorage _box = GetStorage();

  // ---------------- TOKEN ----------------
  static void saveToken(String token) {
    _box.write('token', token);
  }

  static String? getToken() {
    final token = _box.read('token');
    if (token is String && token.trim().isNotEmpty) {
      return token;
    }
    return null;
  }

  // ---------------- USER ----------------
  static void saveUserId(int userId) {
    _box.write('userid', userId);
  }

  static int? getUserId() {
    return _box.read('userid');
  }

  // ---------------- LOGIN FLAG ----------------
  static void setLoggedIn(bool value) {
    _box.write('isLoggedIn', value);
  }

  static bool isLoggedIn() {
    return _box.read('isLoggedIn') ?? false;
  }

  // ---------------- LOGOUT ----------------
  static void clear() {
    _box.erase(); // 🔥 MULTI-USER SAFE
  }
}
