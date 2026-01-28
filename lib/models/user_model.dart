class UserModel {
  final String id;
  final String username;
  final String firstname;
  final String lastname;
  final String email;

  UserModel({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
    );
  }

  String get fullName => '$firstname $lastname';
}
