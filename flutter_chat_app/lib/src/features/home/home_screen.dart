import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_chat_app/src/features/home/tabs/messenger/messenger_tab.dart';
import 'package:flutter_chat_app/src/features/home/tabs/people/people_tab.dart';
import 'package:flutter_chat_app/src/features/home/tabs/setting/setting_tab.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animation;

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MessengerTab(),
    PeopleTab(),
    SettingTab(),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      _animation.animateTo(120, duration: const Duration(milliseconds: 400));
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _animation = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        bottomOpacity: 0,
        elevation: 0,
        toolbarOpacity: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/facebook_messenger.svg',
              width: DimensionsCustom.calculateWidth(7),
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset('assets/icons/facebook_messenger.svg',
                width: DimensionsCustom.calculateWidth(7), color: Colors.blue.shade300),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              width: DimensionsCustom.calculateWidth(7),
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/search.svg',
              width: DimensionsCustom.calculateWidth(7),
              color: Colors.blue.shade300,
            ),
            label: 'Find people',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/gear.svg',
              width: DimensionsCustom.calculateWidth(7),
              color: Colors.grey,
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/gear.svg',
              width: DimensionsCustom.calculateWidth(7),
              color: Colors.blue.shade300,
            ),
            label: 'Setting',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue.shade300,
        onTap: _onItemTapped,
        showUnselectedLabels: false,
      ),
    );
  }
}
