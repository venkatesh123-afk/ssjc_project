import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// Controllers
import 'controllers/theme_controller.dart';
import 'controllers/auth_controller.dart';

// Theme
import 'theme/app_theme.dart';

// Pages
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/profile_page.dart';

import 'pages/staff_list_page.dart';
import 'pages/outing_list_page.dart';
import 'pages/outing_pending_listPage.dart';
import 'pages/subject_marks_upload_page.dart';
import 'pages/Staff_Attendance_Page.dart';
import 'pages/ClassAttendancePage.dart';
import 'pages/exam_category_list_page.dart';
import 'pages/exam_list_page.dart';
import 'pages/student_attendance.dart';
import 'pages/verify_attendance_page .dart';

import 'pages/Room_page.dart';
import 'pages/hostel_members_page.dart';
import 'pages/floors_page.dart';
import 'pages/add_hostel_page.dart';
import 'pages/hostel_attendance_View_page.dart';
import 'pages/hostel_attendance_result_page.dart';
import 'pages/fee_head_page.dart';

/// 🔥 ONE AND ONLY MAIN FUNCTION
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // 🌗 Global controller (NOT user-specific)
  Get.put(ThemeController(), permanent: true);

  // 🔐 AuthController MUST NOT be permanent (multi-user safe)
  Get.lazyPut<AuthController>(() => AuthController());

  runApp(const SsJcApp());
}

class SsJcApp extends StatelessWidget {
  const SsJcApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SSJC',

        // 🌗 THEME
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode:
            themeController.isDark.value ? ThemeMode.dark : ThemeMode.light,

        // 🚀 Always start from splash
        initialRoute: '/splash',

        getPages: [
          // 🔑 AUTH FLOW
          GetPage(name: '/splash', page: () => const SplashPage()),
          GetPage(name: '/login', page: () => const LoginPage()),
          GetPage(name: '/dashboard', page: () => const DashboardPage()),
          GetPage(name: '/profile', page: () => const ProfilePage()),

          // 👨‍🏫 STAFF
          GetPage(name: '/staff', page: () => const StaffListPage()),
          GetPage(
            name: '/staffAttendance',
            page: () => const StaffAttendancePage(),
          ),
          GetPage(
            name: '/classAttendance',
            page: () => ClassAttendancePage(),
          ),

          // 🚶 OUTING
          GetPage(name: '/outingList', page: () => const OutingListPage()),
          GetPage(
            name: '/outingPending',
            page: () => const OutingPendingListPage(),
          ),

          // 📝 ATTENDANCE
          GetPage(
            name: '/verifyAttendance',
            page: () => const VerifyAttendancePage(),
          ),
          GetPage(
            name: '/studentAttendance',
            page: () => const StudentAttendancePage(),
          ),

          // 📚 EXAMS
          GetPage(
            name: '/examCategoryList',
            page: () => const ExamCategoryListPage(),
          ),
          GetPage(name: '/examsList', page: () => const ExamsListPage()),
          GetPage(
            name: '/marksUpload',
            page: () => const SubjectMarksUploadPage(),
          ),

          // 💰 FEES
          GetPage(name: '/feeHeads', page: () => const FeeHeadPage()),

          // 🏨 HOSTEL / ROOMS
          GetPage(name: '/rooms', page: () => const RoomsPage()),
          GetPage(
            name: '/hostelMembers',
            page: () => const HostelMembersPage(),
          ),
          GetPage(name: '/floors', page: () => const FloorsPage()),
          GetPage(name: '/addHostel', page: () => const AddHostelPage()),
          GetPage(
            name: '/hostelAttendanceFilter',
            page: () => const HostelAttendanceFilterPage(),
          ),
          GetPage(
            name: '/hostelAttendanceResult',
            page: () => const HostelAttendanceResultPage(),
          ),
        ],
      ),
    );
  }
}
