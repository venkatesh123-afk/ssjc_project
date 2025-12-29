class FeeHeadModel {
  final int id;
  final String feeHead;
  final String feeGroup;
  final String admission;
  final int status;

  FeeHeadModel({
    required this.id,
    required this.feeHead,
    required this.feeGroup,
    required this.admission,
    required this.status,
  });

  factory FeeHeadModel.fromJson(Map<String, dynamic> json) {
    return FeeHeadModel(
      id: json['id'],
      feeHead: json['feehead'],
      feeGroup: json['feegroup'],
      admission: json['admission'],
      status: json['status'],
    );
  }
}
