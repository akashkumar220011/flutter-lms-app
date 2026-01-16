class UserModel {
  final int? id;
  final String name;
  final String email;
  final String role;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      role: map['role'],
    );
  }
}
