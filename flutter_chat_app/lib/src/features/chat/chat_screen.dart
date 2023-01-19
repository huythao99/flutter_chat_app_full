import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
      body: Column(
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
                    size: DimensionsCustom.calculateWidth(9),
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: DimensionsCustom.calculateWidth(4)),
                      child: Text(
                        'User name',
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
          Row(
            children: [],
          )
        ],
      ),
    );
  }
}
