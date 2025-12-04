import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssjc_p/pages/Room_page.dart';
import 'package:ssjc_p/pages/Staff_Attendance_Page.dart';
import 'package:ssjc_p/pages/exam_category_list_page.dart';
import 'package:ssjc_p/pages/exam_list_page.dart';
import 'package:ssjc_p/pages/splash_page.dart';
import 'theme/app_theme.dart';
import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/staff_list_page.dart';
import 'pages/hostel_members_page.dart';
import 'pages/floors_page.dart';
import 'pages/add_hostel_page.dart';
import 'pages/hostel_attendance_View_page.dart';
import 'pages/hostel_attendance_result_page.dart';

void main() {
  runApp(const ssjcApp());
}

class ssjcApp extends StatelessWidget {
  const ssjcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ssjc',
      theme: AppTheme.lightTheme,
      initialRoute: '/splash',
      getPages: [
        // ⭐ Correct Staff List Route
        GetPage(name: '/staff', page: () => const StaffListPage()),

        // ⭐ Correct Staff Attendance Route (NO SPACES)
        GetPage(
          name: '/staffAttendance',
          page: () => const StaffAttendancePage(),
        ),

        // Exam Pages
        GetPage(
          name: '/examCategoryList',
          page: () => const ExamCategoryListPage(),
        ),
        GetPage(name: '/examsList', page: () => const ExamsListPage()),

        // Rooms Page
        GetPage(name: '/rooms', page: () => const RoomsPage()),

        // Splash / Login / Dashboard
        GetPage(name: '/splash', page: () => const SplashPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/dashboard', page: () => const DashboardPage()),

        // Hostel Pages
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
