class ChatArguments {
  String conversationID = '';
  final Friend friend;

  ChatArguments(this.conversationID, this.friend);
}

class Friend {
  final String id;
  final String name;
  final String avatar;

  Friend(this.id, this.name, this.avatar);
}
