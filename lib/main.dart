import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'pages/verify_attendance_page .dart';
import 'theme/app_theme.dart';
import 'controllers/auth_controller.dart';

// Pages
import 'pages/splash_page.dart';
import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/staff_list_page.dart';
import 'pages/outing_list_page.dart';
import 'pages/outing_pending_listPage.dart';
import 'pages/subject_marks_upload_page.dart';
import 'pages/Staff_Attendance_Page.dart';
import 'pages/exam_category_list_page.dart';
import 'pages/exam_list_page.dart';
import 'pages/student_attendance.dart';
import 'pages/Room_page.dart';
import 'pages/hostel_members_page.dart';
import 'pages/floors_page.dart';
import 'pages/add_hostel_page.dart';
import 'pages/hostel_attendance_View_page.dart';
import 'pages/hostel_attendance_result_page.dart';
import 'pages/fee_head_page.dart';

/// 🔥 ONLY ONE MAIN FUNCTION
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // ✅ Storage init
  runApp(const SsJcApp());
}

class SsJcApp extends StatelessWidget {
  const SsJcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SSJC',
      theme: AppTheme.lightTheme,
      initialRoute: '/splash',

      // ✅ GLOBAL BINDING (VERY IMPORTANT)
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController(), permanent: true);
      }),

      getPages: [
        // Splash / Login / Dashboard
        GetPage(name: '/splash', page: () => const SplashPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/dashboard', page: () => const DashboardPage()),

        // Staff
        GetPage(name: '/staff', page: () => const StaffListPage()),
        GetPage(
          name: '/staffAttendance',
          page: () => const StaffAttendancePage(),
        ),

        // Outing
        GetPage(name: '/outingList', page: () => const OutingListPage()),
        GetPage(
          name: '/outingPending',
          page: () => const OutingPendingListPage(),
        ),

        // Attendance
        GetPage(
          name: '/verifyAttendance',
          page: () => const VerifyAttendancePage(),
        ),
        GetPage(
          name: '/studentAttendance',
          page: () => const StudentAttendancePage(),
        ),

        // Exams
        GetPage(
          name: '/examCategoryList',
          page: () => const ExamCategoryListPage(),
        ),
        GetPage(name: '/examsList', page: () => const ExamsListPage()),
        GetPage(
          name: '/marksUpload',
          page: () => const SubjectMarksUploadPage(),
        ),

        // Fees
        GetPage(name: '/feeHeads', page: () => const FeeHeadPage()),

        // Rooms / Hostel
        GetPage(name: '/rooms', page: () => const RoomsPage()),
        GetPage(name: '/hostelMembers', page: () => const HostelMembersPage()),
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
    );
  }
}
