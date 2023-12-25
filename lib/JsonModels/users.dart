class UsersModel {
  final int? usrId;
  final String usrName;
  final String usrPassword;

  UsersModel({
    this.usrId,
    required this.usrName,
    required this.usrPassword,
  });

  factory UsersModel.fromMap(Map<String, dynamic> json) => UsersModel(
        usrId: json["usrId"],
        usrName: json["usrName"],
        usrPassword: json["usrPassword"],
      );

  Map<String, dynamic> toMap() => {
        "usrId": usrId,
        "usrName": usrName,
        "usrPassword": usrPassword,
      };
}
