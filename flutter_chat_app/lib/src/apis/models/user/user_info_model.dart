class User {
  User({
    required this.data,
  });

  Data data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        data: Data.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.phone,
    required this.password,
    this.token,
    this.refreshToken,
  });

  String id;
  String email;
  String password;
  String phone;
  String name;
  String avatar;
  String? token;
  String? refreshToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        email: json["email"],
        name: json["username"],
        avatar: json["avatar"],
        phone: json['phone'],
        password: json['password'],
        token: json['access_token'],
        refreshToken: json['refresh_token'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "avatar": avatar,
        "phone": phone,
        "token": token,
        "password": password,
        "refreshToken": refreshToken,
      };
}
