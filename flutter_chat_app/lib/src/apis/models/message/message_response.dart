class MessageResposne {
  final int total;
  final List<Message> messages;
  final SubConversation conversation;

  const MessageResposne({required this.total, required this.messages, required this.conversation});

  factory MessageResposne.fromJson(Map<String, dynamic> json) {
    Iterable list = json['messages'];
    List<Message> messages = List<Message>.from(list.map((e) => Message.fromJson(e)));
    return MessageResposne(
        total: json['total'],
        messages: messages,
        conversation: SubConversation.fromJson(json['conversation']));
  }
}

class Message {
  final String sender;
  final String id;
  final String message;
  final String image;
  final String createdAt;
  final String updatedAt;
  final SubConversation conversation;

  const Message(
      {required this.conversation,
      required this.createdAt,
      required this.id,
      required this.image,
      required this.message,
      required this.updatedAt,
      required this.sender});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        conversation: SubConversation.fromJson(json['conversation']),
        createdAt: json['createdAt'],
        id: json['_id'],
        image: json['image'],
        message: json['message'],
        updatedAt: json['updatedAt'],
        sender: json['sender']);
  }
}

class SubConversation {
  final String id;
  final String sender;
  final List<String> receiver;
  final String message;

  const SubConversation({
    required this.id,
    required this.message,
    required this.sender,
    required this.receiver,
  });

  factory SubConversation.fromJson(Map<String, dynamic> json) {
    Iterable list = json['receiver'];
    List<String> receiver = List<String>.from(list.map((e) => e));
    return SubConversation(
        id: json['_id'], message: json['message'], sender: json['sender'], receiver: receiver);
  }
}
