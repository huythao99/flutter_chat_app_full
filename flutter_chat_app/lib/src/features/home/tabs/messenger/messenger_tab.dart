import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_chat_app/src/constants/route/route_main.dart';
import 'package:flutter_svg/svg.dart';

class MessengerTab extends StatefulWidget {
  const MessengerTab({super.key});

  @override
  State<MessengerTab> createState() => _MessengerTabState();
}

class _MessengerTabState extends State<MessengerTab> {
  void _onPress() {
    Navigator.of(context).pushNamed(RouteMain.routeChat);
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
        Expanded(
            child: ListView(
          padding: EdgeInsets.symmetric(vertical: DimensionsCustom.calculateHeight(1)),
          children: [
            InkWell(
                onTap: _onPress,
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
                            'https://glyndwr.ac.uk/media/marketing/animals/sajad-nori-s1puI2BWQzQ-unsplash-2-1360x1360.jpg',
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
                              'User name',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: DimensionsCustom.calculateWidth(4)),
                            ),
                            SizedBox(
                              height: DimensionsCustom.calculateHeight(2),
                            ),
                            Text(
                              'message',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: DimensionsCustom.calculateWidth(4)),
                            )
                          ],
                        ),
                      )),
                      Text(
                        'Time',
                        style: TextStyle(fontSize: DimensionsCustom.calculateWidth(3)),
                      )
                    ],
                  ),
                ))
          ],
        ))
      ],
    );
  }
}
