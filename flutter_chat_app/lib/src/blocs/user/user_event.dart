import 'package:flutter_chat_app/src/apis/models/user/user_info_model.dart';

abstract class UserEvent {
  const UserEvent();
}

class UserChanged extends UserEvent {
  const UserChanged(this.user);

  final User? user;
}
