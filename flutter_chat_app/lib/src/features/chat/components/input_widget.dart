import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';

class InputWidget extends StatelessWidget {
  const InputWidget(
      {super.key, required this.messageController, required this.sendMessage});

  final TextEditingController messageController;
  final Function() sendMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: DimensionsCustom.calculateWidth(4),
          vertical: DimensionsCustom.calculateHeight(1)),
      child: Row(
        children: [
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  height: DimensionsCustom.calculateHeight(5.5),
                  padding: EdgeInsets.symmetric(
                      horizontal: DimensionsCustom.calculateWidth(4),
                      vertical: 0),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(
                          DimensionsCustom.calculateWidth(20))),
                  child: TextField(
                    controller: messageController,
                    expands: true,
                    maxLines: null,
                    textAlignVertical: TextAlignVertical.center,
                    style:
                        TextStyle(fontSize: DimensionsCustom.calculateWidth(4)),
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                        hintText: 'Something',
                        contentPadding: EdgeInsets.zero),
                  ))),
          InkWell(
            onTap: sendMessage,
            child: Padding(
              padding:
                  EdgeInsets.only(left: DimensionsCustom.calculateWidth(4)),
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
    );
  }
}
