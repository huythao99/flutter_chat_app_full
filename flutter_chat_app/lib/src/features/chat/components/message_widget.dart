import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/src/blocs/user/user_bloc.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.message, required this.sender});

  final String message;
  final String sender;

  @override
  Widget build(BuildContext context) {
    print(message);
    return Row(
      mainAxisAlignment: sender == context.read<UserBloc>().state.userID
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: DimensionsCustom.calculateWidth(80)),
          margin: EdgeInsets.symmetric(vertical: DimensionsCustom.calculateHeight(1)),
          padding: EdgeInsets.symmetric(
              horizontal: DimensionsCustom.calculateWidth(2),
              vertical: DimensionsCustom.calculateHeight(0.5)),
          decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(DimensionsCustom.calculateWidth(1.5))),
          child: Text(
            message,
            // '123 123 123 123 123 123 123 12 312 312 312 31 21 21 321 321 312 312',
            style: TextStyle(fontSize: DimensionsCustom.calculateWidth(4), color: Colors.black),
          ),
        ),
      ],
    );
  }
}
