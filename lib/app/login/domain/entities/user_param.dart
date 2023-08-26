class UserParam  {
  final String email;
  final String password;
  const UserParam({
    required this.email,
    required this.password,
  });

  UserParam copyWith({
    String? email,
    String? password,
  }) {
    return UserParam(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      'email': email,
      'password': password,
    };
  }
}