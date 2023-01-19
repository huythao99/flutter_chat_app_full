import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_svg/svg.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.assetIcon,
      required this.title,
      this.des = '',
      this.onpress,
      this.colorIcon = Colors.black});

  final String assetIcon;
  final String title;
  final String des;
  final Color colorIcon;
  final VoidCallback? onpress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: DimensionsCustom.calculateHeight(1.5),
            horizontal: DimensionsCustom.calculateWidth(4)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              assetIcon,
              width: DimensionsCustom.calculateWidth(8),
              color: colorIcon,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DimensionsCustom.calculateWidth(4)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: DimensionsCustom.calculateWidth(4)),
                  ),
                  if (des != '')
                    Text(des,
                        style: TextStyle(
                            fontSize: DimensionsCustom.calculateWidth(3), color: Colors.blueGrey))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
