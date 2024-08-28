class UserModel {
  int id;
  String name;
  String? email;
  String? phone;
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

  // Factory constructor for creating a UserModel from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      photo: map['photo'],
      role: map['role_id'],
    );
  }
}
