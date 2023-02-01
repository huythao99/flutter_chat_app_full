import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required TextEditingController search,
  }) : _search = search;

  final TextEditingController _search;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Expanded(
              child: TextField(
                controller: _search,
                decoration: const InputDecoration(hintText: 'Search', border: InputBorder.none),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/search.svg',
              width: DimensionsCustom.calculateWidth(6),
            ),
          ],
        ));
  }
}
