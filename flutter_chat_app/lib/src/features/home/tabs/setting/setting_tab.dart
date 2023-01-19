import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/src/blocs/user/user_bloc.dart';
import 'package:flutter_chat_app/src/blocs/user/user_event.dart';
import 'package:flutter_chat_app/src/blocs/user/user_state.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_chat_app/src/features/home/tabs/setting/components/button_widget.dart';
import 'package:flutter_svg/svg.dart';

class SettingTab extends StatefulWidget {
  const SettingTab({super.key});

  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  void onLogout() {
    BlocProvider.of<UserBloc>(context).add(const UserChanged(null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return ListView(
        padding: EdgeInsets.symmetric(vertical: DimensionsCustom.calculateHeight(2)),
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: DimensionsCustom.calculateHeight(1),
                  horizontal: DimensionsCustom.calculateWidth(4)),
              child: Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      if (state.userAvatar != '')
                        SizedBox(
                          width: DimensionsCustom.calculateWidth(14),
                          height: DimensionsCustom.calculateWidth(14),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(DimensionsCustom.calculateWidth(13)),
                            child: Image.network(
                              state.userAvatar,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: DimensionsCustom.calculateWidth(4)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.userName,
                              style: TextStyle(
                                  fontSize: DimensionsCustom.calculateWidth(5),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(
                                  fontSize: DimensionsCustom.calculateWidth(3),
                                  color: Colors.grey.shade800),
                            )
                          ],
                        ),
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
          ),
          const ButtonWidget(
            assetIcon: 'assets/icons/moon.svg',
            title: 'Dark mode',
            des: 'System',
          ),
          const ButtonWidget(
            assetIcon: 'assets/icons/music_note.svg',
            title: 'Sound',
            des: 'System',
            colorIcon: Colors.blue,
          ),
          const ButtonWidget(
            assetIcon: 'assets/icons/notification.svg',
            title: 'Notification',
            colorIcon: Colors.purple,
          ),
          const ButtonWidget(
            assetIcon: 'assets/icons/shield.svg',
            title: 'Security',
            colorIcon: Colors.green,
          ),
          const ButtonWidget(
            assetIcon: 'assets/icons/album.svg',
            title: 'Album',
            colorIcon: Colors.blue,
          ),
          const ButtonWidget(
            assetIcon: 'assets/icons/download_bottom.svg',
            title: 'Update system',
            colorIcon: Colors.blue,
          ),
          const ButtonWidget(
            assetIcon: 'assets/icons/warning.svg',
            title: 'Report system',
            colorIcon: Colors.orange,
          ),
          const ButtonWidget(
            assetIcon: 'assets/icons/question.svg',
            title: 'Help',
            colorIcon: Colors.blue,
          ),
          ButtonWidget(
            assetIcon: 'assets/icons/sign_out.svg',
            title: 'Sign out',
            onpress: onLogout,
          ),
        ],
      );
    });
  }
}
