import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.friendName, required this.onBack});

  final String friendName;
  final Function() onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: DimensionsCustom.calculateWidth(4),
          vertical: DimensionsCustom.calculateHeight(1)),
      child: Row(
        children: [
          InkWell(
            onTap: onBack,
            child: Icon(
              Icons.arrow_back,
              size: DimensionsCustom.calculateWidth(7),
              color: Colors.blue,
            ),
          ),
          Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: DimensionsCustom.calculateWidth(4)),
                child: Text(
                  friendName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: DimensionsCustom.calculateWidth(6)),
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
    );
  }
}
