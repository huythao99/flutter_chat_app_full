class UsersReponse {
  final int total;
  final List<User> users;

  const UsersReponse({required this.total, required this.users});

  factory UsersReponse.fromJson(Map<String, dynamic> json) {
    Iterable list = json['users'];
    List<User> users = List<User>.from(list.map((user) => User.fromJson(user)));
    return UsersReponse(total: json['total'], users: users);
  }
}

class User {
  final String id;
  final String username;
  final String email;
  final String phone;
  final String avatar;

  const User(
      {required this.id,
      required this.avatar,
      required this.email,
      required this.phone,
      required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        avatar: json['avatar'],
        email: json['email'],
        phone: json['phone'],
        username: json['username']);
  }
}
