import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/apis/models/conversation/conversation_response_model.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_chat_app/src/utils/utils.dart';

class ConversationWidget extends StatelessWidget {
  const ConversationWidget(
      {super.key, required this.conversation, required this.onPress, required this.userID});

  final Conversation conversation;
  final String userID;
  final Function(Conversation) onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onPress(conversation),
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
                    Utils.getFriendAvatarByID(conversation.receiver, userID),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: DimensionsCustom.calculateWidth(4)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Utils.getFriendNameByID(conversation.receiver, userID),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: DimensionsCustom.calculateWidth(4)),
                    ),
                    SizedBox(
                      height: DimensionsCustom.calculateHeight(1.25),
                    ),
                    Text(
                      conversation.message,
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
  }
}
