import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/src/apis/client_api.dart';
import 'package:flutter_chat_app/src/apis/paths/chat_path.dart';
import 'package:flutter_chat_app/src/blocs/user/user_bloc.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_chat_app/src/models/chat_argument.dart';
import 'package:flutter_chat_app/src/socket/client_socket.dart';
import 'package:flutter_chat_app/src/utils/error_handler.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, this.conversationID = '', required this.friend});

  final String conversationID;
  final Friend friend;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _message = TextEditingController();
  String conversationID = '';

  @override
  void initState() {
    super.initState();
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

  Future<void> _sendMessage() async {
    try {
      if (_message.text.trim() == '') {
        return;
      }
      Map<String, dynamic> body = {
        "sender": context.read<UserBloc>().state.userID,
        "receiver": [context.read<UserBloc>().state.userID, widget.friend.id],
        "message": _message.text,
        "conversation": conversationID,
      };
      Response res = await ClientApi.postApi(ChatPath.sendMessage, body, false);
      setState(() {
        conversationID = res.data['conversation'];
      });
    } on DioError catch (e) {
      ErrorHandler().showMessage(e, context);
    }
  }

  void _onBack() {
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
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: DimensionsCustom.calculateWidth(4),
                  vertical: DimensionsCustom.calculateHeight(1)),
              child: Row(
                children: [
                  InkWell(
                    onTap: _onBack,
                    child: Icon(
                      Icons.arrow_back,
                      size: DimensionsCustom.calculateWidth(7),
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: DimensionsCustom.calculateWidth(4)),
                        child: Text(
                          widget.friend.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: DimensionsCustom.calculateWidth(6)),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: SvgPicture.asset(
                              'assets/icons/phone.svg',
                              width: DimensionsCustom.calculateWidth(6),
                              color: Colors.blue,
                            ),
                          ),
                          InkWell(
                            child: SvgPicture.asset(
                              'assets/icons/video.svg',
                              width: DimensionsCustom.calculateWidth(6),
                              color: Colors.blue,
                            ),
                          ),
                          InkWell(
                            child: SvgPicture.asset(
                              'assets/icons/info_circle.svg',
                              width: DimensionsCustom.calculateWidth(6),
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
            Expanded(child: Container()),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: DimensionsCustom.calculateWidth(4),
                  vertical: DimensionsCustom.calculateHeight(1)),
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                          height: DimensionsCustom.calculateHeight(5.5),
                          padding:
                              EdgeInsets.symmetric(horizontal: DimensionsCustom.calculateWidth(4)),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                                  BorderRadius.circular(DimensionsCustom.calculateWidth(20))),
                          child: TextField(
                            controller: _message,
                            maxLines: 4,
                            style: TextStyle(fontSize: DimensionsCustom.calculateWidth(4)),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Something',
                            ),
                          ))),
                  InkWell(
                    onTap: _sendMessage,
                    child: Padding(
                      padding: EdgeInsets.only(left: DimensionsCustom.calculateWidth(4)),
                      child: Transform.rotate(
                        angle: -pi / 4,
                        child: Icon(
                          Icons.send,
                          size: DimensionsCustom.calculateWidth(8),
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
