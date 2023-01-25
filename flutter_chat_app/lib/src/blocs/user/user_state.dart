import 'package:flutter_chat_app/src/apis/models/user/user_info_model.dart';

class UserState {
  const UserState._({
    this.user,
  });

  const UserState.empty() : this._();

  const UserState.updateUser(User? user) : this._(user: user);

  final User? user;

  String get userToken => user?.data.token ?? '';

  String get userAvatar => user?.data.avatar ?? '';

  String get userName => user?.data.name ?? '';

  String get userID => user?.data.id ?? '';
}
