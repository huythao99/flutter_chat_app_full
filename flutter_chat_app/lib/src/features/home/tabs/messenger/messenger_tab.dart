import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/src/apis/client_api.dart';
import 'package:flutter_chat_app/src/apis/models/conversation/conversation_response_model.dart';
import 'package:flutter_chat_app/src/apis/paths/conversation_path.dart';
import 'package:flutter_chat_app/src/blocs/user/user_bloc.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_chat_app/src/constants/route/route_main.dart';
import 'package:flutter_chat_app/src/features/home/tabs/messenger/components/conversation_widget.dart';
import 'package:flutter_chat_app/src/features/home/tabs/messenger/components/header_widget.dart';
import 'package:flutter_chat_app/src/features/home/tabs/messenger/components/search_widget.dart';
import 'package:flutter_chat_app/src/models/chat_argument.dart';
import 'package:flutter_chat_app/src/utils/error_handler.dart';
import 'package:flutter_chat_app/src/utils/utils.dart';

class MessengerTab extends StatefulWidget {
  const MessengerTab({super.key});

  @override
  State<MessengerTab> createState() => _MessengerTabState();
}

class _MessengerTabState extends State<MessengerTab> {
  final TextEditingController _search = TextEditingController();
  final ScrollController _controller = ScrollController();
  late String userID;

  List<Conversation> conversations = [];
  int total = 0;

  Future<void> _getConversation(bool refresh) async {
    try {
      Map<String, dynamic> params = {
        "keyword": _search.text,
        "skip": refresh ? 0 : conversations.length
      };

      Response res = await ClientApi.getApi(ConversationPath.getConversation, params);
      ConversationResponse data = ConversationResponse.fromJson(res.data);
      if (mounted) {
        if (refresh) {
          setState(() {
            conversations = data.conversations;
            total = data.total;
          });
        } else {
          setState(() {
            conversations.addAll(data.conversations);
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

  void onPress(Conversation conversation) {
    Navigator.of(context).pushNamed(RouteMain.routeChat,
        arguments: ChatArguments(
            conversation.id,
            Friend(
                Utils.getFriendID(conversation.receiver, userID),
                Utils.getFriendNameByID(conversation.receiver, userID),
                Utils.getFriendAvatarByID(conversation.receiver, userID))));
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
        const HeaderWidget(),
        SearchWidget(search: _search),
        Expanded(
            child: ListView.builder(
          controller: _controller,
          itemCount: conversations.length,
          padding: EdgeInsets.symmetric(vertical: DimensionsCustom.calculateHeight(1)),
          itemBuilder: (context, index) {
            return ConversationWidget(
              conversation: conversations.elementAt(index),
              userID: userID,
              onPress: onPress,
            );
          },
        ))
      ],
    );
  }
}
