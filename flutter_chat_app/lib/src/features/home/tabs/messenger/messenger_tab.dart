import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_svg/svg.dart';

class MessengerTab extends StatefulWidget {
  const MessengerTab({super.key});

  @override
  State<MessengerTab> createState() => _MessengerTabState();
}

class _MessengerTabState extends State<MessengerTab> {
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
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Search', border: InputBorder.none),
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: DimensionsCustom.calculateWidth(6),
                ),
              ],
            )),
        // Expanded(child: ListView(
        //   padding: EdgeInsets.symmetric(vertical: DimensionsCustom.calculateHeight(1)),
        //   children: [
        //     GestureDetector(
        //       child: Container(
        //         decoration: BoxDecoration(
        //           border: Border(bottom: BorderSide(color: Colors.grey.shade200))
        //         ),
        //         child: Row(
        //
        //         ),
        //       ),
        //     )
        //   ],
        // ))
      ],
    );
  }
}
