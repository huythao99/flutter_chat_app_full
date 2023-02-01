import 'dart:convert';

class ConversationResponse {
  // final List<Conversation> conversations;
  final int total;

  const ConversationResponse({required this.total});

  factory ConversationResponse.fromJson(Map<String, dynamic> json) {
    print(json['conversations']);
    // print(jsonDecode(json['conversations']));
    // Iterable list = jsonDecode(json['conversations']);
    // print(list);
    // List<Conversation> conversations =
    //     List<Conversation>.from(list.map((conversation) => Conversation.fromJson(conversation)));
    return ConversationResponse(total: json['total']);
  }
}

class Conversation {
  final String id;
  final String sender;
  final List<Receiver> receiver;
  final String message;

  const Conversation({
    required this.id,
    required this.message,
    required this.sender,
    required this.receiver,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    Iterable list = jsonDecode(json['receiver']);
    List<Receiver> receiver =
        List<Receiver>.from(list.map((receiver) => Receiver.fromJson(receiver)));
    return Conversation(
        id: json["id"], message: json["message"], sender: json["sender"], receiver: receiver);
  }
}

class Receiver {
  final String id;
  final String username;
  final String email;
  final String phone;
  final String avatar;

  const Receiver({
    required this.avatar,
    required this.email,
    required this.id,
    required this.phone,
    required this.username,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
      id: json["id"],
      email: json["email"],
      avatar: json["avatar"],
      username: json['username'],
      phone: json['phone']);
}
