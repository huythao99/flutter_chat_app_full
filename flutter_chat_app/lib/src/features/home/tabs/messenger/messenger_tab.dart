import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/src/apis/client_api.dart';
import 'package:flutter_chat_app/src/apis/models/conversation/conversation_response_model.dart';
import 'package:flutter_chat_app/src/apis/paths/conversation_path.dart';
import 'package:flutter_chat_app/src/blocs/user/user_bloc.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_chat_app/src/constants/route/route_main.dart';
import 'package:flutter_chat_app/src/models/chat_argument.dart';
import 'package:flutter_chat_app/src/utils/error_handler.dart';
import 'package:flutter_chat_app/src/utils/utils.dart';
import 'package:flutter_svg/svg.dart';

class MessengerTab extends StatefulWidget {
  const MessengerTab({super.key});

  @override
  State<MessengerTab> createState() => _MessengerTabState();
}

class _MessengerTabState extends State<MessengerTab> {
  final TextEditingController _search = TextEditingController();
  final ScrollController _controller = ScrollController();
  late String userID;

  List<dynamic> conversations = [];
  int total = 0;

  Future<void> _getConversation(bool refresh) async {
    try {
      Map<String, dynamic> params = {
        "keyword": _search.text,
        "skip": refresh ? 0 : conversations.length
      };

      Response res = await ClientApi.getApi(ConversationPath.getConversation, params);
      Map<String, dynamic> newData = {
        ...res.data,
      };
      ConversationResponse data = ConversationResponse.fromJson(newData);
      if (mounted) {
        if (refresh) {
          setState(() {
            conversations = res.data['conversations'];
            total = res.data['total'];
          });
        } else {
          setState(() {
            conversations = [...conversations, ...res.data['conversations']];
          });
        }
      }
    } on DioError catch (e) {
      ErrorHandler().showMessage(e, context);
    }
  }

  void _onLoadMore() {
    if (conversations.length < total) {
      _getConversation(false);
    }
  }

  void _onPress(dynamic conversation) {
    Navigator.of(context).pushNamed(RouteMain.routeChat,
        arguments: ChatArguments(
            conversation['_id'],
            Friend(
                Utils.getFriendID(conversation['receiver'], userID),
                Utils.getFriendNameByID(conversation['receiver'], userID),
                Utils.getFriendAvatarByID(conversation['receiver'], userID))));
  }

  @override
  void initState() {
    super.initState();

    userID = context.read<UserBloc>().state.userID;

    _getConversation(false);
    _controller.addListener(() {
      if (_controller.position.extentAfter < DimensionsCustom.endReachedThreshold) {
        _onLoadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: DimensionsCustom.calculateWidth(4),
              vertical: DimensionsCustom.calculateHeight(1)),
          child: Text(
            'Messenger',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: DimensionsCustom.calculateWidth(7)),
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(
              horizontal: DimensionsCustom.calculateWidth(5),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: DimensionsCustom.calculateWidth(4),
            ),
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(DimensionsCustom.calculateWidth(10))),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _search,
                    decoration: const InputDecoration(hintText: 'Search', border: InputBorder.none),
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: DimensionsCustom.calculateWidth(6),
                ),
              ],
            )),
        Expanded(
            child: ListView.builder(
          controller: _controller,
          itemCount: conversations.length,
          padding: EdgeInsets.symmetric(vertical: DimensionsCustom.calculateHeight(1)),
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () => _onPress(conversations[index]),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensionsCustom.calculateWidth(4),
                      vertical: DimensionsCustom.calculateHeight(1.5)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: DimensionsCustom.calculateWidth(18),
                        height: DimensionsCustom.calculateWidth(18),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(DimensionsCustom.calculateWidth(10)),
                          child: Image.network(
                            Utils.getFriendAvatarByID(conversations[index]['receiver'],
                                context.read<UserBloc>().state.userID),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: DimensionsCustom.calculateWidth(4)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Utils.getFriendNameByID(conversations[index]['receiver'],
                                  context.read<UserBloc>().state.userID),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: DimensionsCustom.calculateWidth(4)),
                            ),
                            SizedBox(
                              height: DimensionsCustom.calculateHeight(1.25),
                            ),
                            Text(
                              conversations[index]['message'],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: DimensionsCustom.calculateWidth(4)),
                            )
                          ],
                        ),
                      )),
                      // Text(
                      //   'Time',
                      //   style: TextStyle(fontSize: DimensionsCustom.calculateWidth(3)),
                      // )
                    ],
                  ),
                ));
          },
        ))
      ],
    );
  }
}
