import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';

class Person extends StatelessWidget {
  const Person({super.key, required this.user, required this.onPress});

  final Map<String, dynamic> user;
  final Function(Map<String, dynamic>) onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onPress(user),
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
                    user['avatar'] ??
                        'https://glyndwr.ac.uk/media/marketing/animals/sajad-nori-s1puI2BWQzQ-unsplash-2-1360x1360.jpg',
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
                      user['username'],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: DimensionsCustom.calculateWidth(4)),
                    ),
                    SizedBox(
                      height: DimensionsCustom.calculateHeight(1.25),
                    ),
                    Text(
                      'Profile',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: DimensionsCustom.calculateWidth(4)),
                    )
                  ],
                ),
              )),
            ],
          ),
        ));
  }
}
