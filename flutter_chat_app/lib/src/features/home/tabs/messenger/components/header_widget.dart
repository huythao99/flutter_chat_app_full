import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: DimensionsCustom.calculateWidth(4),
          vertical: DimensionsCustom.calculateHeight(1)),
      child: Text(
        'Messenger',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: DimensionsCustom.calculateWidth(7)),
      ),
    );
  }
}
