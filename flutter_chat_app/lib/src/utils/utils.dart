class Utils {
  static String getFriendNameByID(List<dynamic> receiver, String userID) {
    return receiver.firstWhere((element) => element['_id'] != userID)['username'];
  }

  static String getFriendAvatarByID(List<dynamic> receiver, String userID) {
    return receiver.firstWhere((element) => element['_id'] != userID)['avatar'];
  }

  static String getFriendID(List<dynamic> receiver, String userID) {
    return receiver.firstWhere((element) => element['_id'] != userID)['_id'];
  }
}
