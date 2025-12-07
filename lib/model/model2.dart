class StudentModel {
  final String id;
  final String name;
  final String permissionBy;
  final String? image;

  StudentModel({
    required this.id,
    required this.name,
    required this.permissionBy,
    this.image,
  });
}
