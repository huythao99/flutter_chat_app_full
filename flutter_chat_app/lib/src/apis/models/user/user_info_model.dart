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

  static final empty = User(data: Data.empty);
}

class Data {
  Data({
    required this.id,
    required this.email,
    required this.name,
    required this.avatar,
    required this.phone,
    this.password,
    this.token,
    this.refreshToken,
  });

  String id;
  String email;
  String? password;
  String phone;
  String name;
  String avatar;
  String? token;
  String? refreshToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        avatar: json["avatar"],
        phone: json['phone'],
        password: json['password'],
        token: json['token'],
        refreshToken: json['refreshToken'],
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

  static final empty = Data(id: '', email: '', name: '', avatar: '', phone: '');
}
