class ApiCollection {
  static const String baseUrl = "https://dev.srisaraswathigroups.in/api";

  // ---------------- LOGIN ----------------
  static String login(String username, String password) =>
      "/login?user_login=${Uri.encodeQueryComponent(username)}"
      "&password=${Uri.encodeQueryComponent(password)}";

  // ---------------- BRANCH ----------------
  static const String branchList = "/branchlist";

  // ---------------- GROUPS ----------------
  static String groupsByBranch(int branchId) => "/groupslistbybranch/$branchId";

  // ---------------- COURSES ----------------
  static String coursesByGroup(int groupId) => "/courselistbygroup/$groupId";

  // ---------------- BATCHES ----------------
  static String batchesByCourse(int courseId) => "/batchlistbycourse/$courseId";

  // ---------------- FEE HEADS ----------------
  static String feeHeadsByBranch(int branchId) => "/feeheadsbybranch/$branchId";
}
