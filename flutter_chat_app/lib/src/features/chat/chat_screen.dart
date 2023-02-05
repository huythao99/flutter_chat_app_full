import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/src/apis/client_api.dart';
import 'package:flutter_chat_app/src/apis/models/message/message_response.dart';
import 'package:flutter_chat_app/src/apis/paths/chat_path.dart';
import 'package:flutter_chat_app/src/blocs/user/user_bloc.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_chat_app/src/features/chat/components/header_widget.dart';
import 'package:flutter_chat_app/src/features/chat/components/input_widget.dart';
import 'package:flutter_chat_app/src/features/chat/components/message_widget.dart';
import 'package:flutter_chat_app/src/models/chat_argument.dart';
import 'package:flutter_chat_app/src/socket/client_socket.dart';
import 'package:flutter_chat_app/src/utils/error_handler.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, this.conversationID = '', required this.friend});

  final String conversationID;
  final Friend friend;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController = TextEditingController();
  String conversationID = '';
  List<Message> messages = [];
  int total = 0;

  @override
  void initState() {
    super.initState();
    _getMessages(false);
    if (widget.conversationID != '') {
      ClientSocket.emitEvent('join channel', {
        "conversationID": widget.conversationID,
        "userID": context.read<UserBloc>().state.userID
      });
      ClientSocket.listenEvent('receiverMessage', (dynamic data) {
        print(data);
      });
      setState(() {
        conversationID = widget.conversationID;
      });
    }
  }

  Future<void> sendMessage() async {
    try {
      // if (messageController.text.trim() == '') {
      //   return;
      // }
      // Map<String, dynamic> body = {
      //   "sender": context.read<UserBloc>().state.userID,
      //   "receiver": [context.read<UserBloc>().state.userID, widget.friend.id],
      //   "message": _message.text,
      //   "conversation": conversationID,
      // };
      // Response res = await ClientApi.postApi(ChatPath.sendMessage, body, false);
      // if (conversationID == '') {
      //   if (mounted) {
      //     ClientSocket.emitEvent('join channel', {
      //       "conversationID": res.data['conversation']['_id'],
      //       "userID": context.read<UserBloc>().state.userID
      //     });
      //   }
      //   ClientSocket.listenEvent('receiverMessage', (dynamic data) {
      //     print(data);
      //   });
      //   setState(() {
      //     conversationID = res.data['conversation'];
      //   });
      // }
      Map<String, dynamic> params = {
        "_id": "63d4e75360958fea0cfd0c0f",
        "sender": "63c2e23cb01d0aa303bbecf4",
        "conversation": {
          '_id': '63d4e6b060958fea0cfd0be6',
          'sender': '63c2e23cb01d0aa303bbecf4',
          'receiver': ['63c2e23cb01d0aa303bbecf4', '63c2e340b01d0aa303bbecf7'],
          'message': '6',
          '__v': '0'
        },
        'message': '6',
        'image': '',
        'createdAt': '2023-01-28T09:13:55.378Z',
        'updatedAt': '2023-01-28T09:13:55.378Z',
        '__v': '0'
      };
      setState(() {
        messages.insert(0, Message.fromJson(params));
      });
    } on DioError catch (e) {
      ErrorHandler().showMessage(e, context);
    }
  }

  Future<void> _getMessages(bool refresh) async {
    try {
      Map<String, dynamic> body = {
        "skip": refresh ? 0 : messages.length,
        "receiver": [context.read<UserBloc>().state.userID, widget.friend.id],
        "conversation": conversationID,
      };
      Response res = await ClientApi.getApi(ChatPath.getMessage, body);
      MessageResposne newResponse = MessageResposne.fromJson(res.data);
      if (messages.isEmpty && newResponse.total != 0) {
        setState(() {
          total = newResponse.total;
          messages = newResponse.messages;
          if (conversationID == '') {
            conversationID = newResponse.conversation.id;
          }
        });
      } else {
        messages.addAll(newResponse.messages);
      }
    } on DioError catch (e) {
      ErrorHandler().showMessage(e, context);
    }
  }

  void onBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        toolbarOpacity: 0,
        bottomOpacity: 0,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            HeaderWidget(
              friendName: widget.friend.name,
              onBack: onBack,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: DimensionsCustom.calculateWidth(4),
                    vertical: DimensionsCustom.calculateHeight(1)),
                child: ListView.builder(
                  reverse: true,
                  itemBuilder: (context, index) {
                    return MessageWidget(
                      key: ValueKey('message-${messages.elementAt(index).id}'),
                      message: messages.elementAt(index).message,
                      sender: messages.elementAt(index).sender,
                    );
                  },
                  itemCount: messages.length,
                  findChildIndexCallback: (key) {
                    final ValueKey<String> valueKey = key as ValueKey<String>;
                    final index = messages.indexWhere((m) {
                      return 'message-${m.id}' == valueKey.value;
                    });
                    if (index == -1) return null;
                    return index;
                  },
                ),
              ),
            ),
            InputWidget(
              messageController: messageController,
              sendMessage: sendMessage,
            )
          ],
        ),
      ),
    );
  }
}
