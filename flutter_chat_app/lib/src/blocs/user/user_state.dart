import 'package:flutter_chat_app/src/apis/models/user/user_info_model.dart';

class UserState {
  const UserState._({
    this.user,
  });

  const UserState.empty() : this._();

  const UserState.updateUser(User? user) : this._(user: user);

  final User? user;

  List<Object> get userInfo => [user ?? {}];
}
