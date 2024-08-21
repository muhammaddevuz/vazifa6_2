class UserModel {
  int id;
  String name;
  String? email;
  String phone;
  String? photo;
  int role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.photo,
    required this.role,
  });
}
