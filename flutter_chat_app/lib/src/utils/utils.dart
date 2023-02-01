import 'package:flutter_chat_app/src/apis/models/conversation/conversation_response_model.dart';

class Utils {
  static String getFriendNameByID(List<Receiver> receiver, String userID) {
    return receiver.firstWhere((element) => element.id != userID).username;
  }

  static String getFriendAvatarByID(List<Receiver> receiver, String userID) {
    return receiver.firstWhere((element) => element.id != userID).avatar;
  }

  static String getFriendID(List<Receiver> receiver, String userID) {
    return receiver.firstWhere((element) => element.id != userID).id;
  }
}
