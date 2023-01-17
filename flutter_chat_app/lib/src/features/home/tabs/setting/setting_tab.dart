import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/src/blocs/user/user_bloc.dart';
import 'package:flutter_chat_app/src/blocs/user/user_state.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_svg/svg.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      debugPrint(state.userAvatar);
      return ListView(
        padding: EdgeInsets.symmetric(vertical: DimensionsCustom.calculateHeight(2)),
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: DimensionsCustom.calculateHeight(1),
                horizontal: DimensionsCustom.calculateWidth(4)),
            child: Row(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    if (state.userAvatar != '')
                      Image.network(
                        state.userAvatar,
                        width: DimensionsCustom.calculateWidth(13),
                        height: DimensionsCustom.calculateWidth(13),
                      )
                  ],
                )),
                SvgPicture.asset(
                  'assets/icons/angle_right.svg',
                  width: DimensionsCustom.calculateWidth(4),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: DimensionsCustom.calculateHeight(1),
                  horizontal: DimensionsCustom.calculateWidth(4)),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/moon.svg',
                    width: DimensionsCustom.calculateWidth(6),
                  )
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
