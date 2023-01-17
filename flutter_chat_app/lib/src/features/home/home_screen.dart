import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_chat_app/src/features/home/tabs/messenger/messenger_tab.dart';
import 'package:flutter_chat_app/src/features/home/tabs/setting/setting_tab.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation _animation;

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MessengerTab(),
    SettingTab(),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    _animation = IntTween(begin: 180, end: 20).animate(_animationController);
    _animation.addListener(() => setState(() {}));
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
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.only(
            left: DimensionsCustom.calculateWidth(4),
            right: DimensionsCustom.calculateWidth(4),
            top: DimensionsCustom.calculateHeight(1),
            bottom: 0),
        child: Row(
          children: [
            Expanded(
              flex: _animation.value,
              // fit: FlexFit.tight,
              child: GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: DimensionsCustom.calculateWidth(1)),
                  padding: EdgeInsets.symmetric(vertical: DimensionsCustom.calculateHeight(1)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(DimensionsCustom.calculateWidth(15)),
                      border: Border.all(
                          width: 1,
                          color: _selectedIndex == 0 ? Colors.blue.shade400 : Colors.white)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/facebook_messenger.svg',
                        width: DimensionsCustom.calculateWidth(8),
                        color:
                            _selectedIndex == 0 ? Colors.blue.shade400 : Colors.blueGrey.shade100,
                      ),
                      if (_animationController.value == 0.0)
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: DimensionsCustom.calculateWidth(2)),
                          child: Text(
                            'Chat',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: DimensionsCustom.calculateWidth(5),
                                color: Colors.blue.shade400),
                          ),
                        ),
                    ],
                  ),
                ),
                onTap: () {
                  _onItemTapped(0);
                },
              ),
            ),
            Expanded(
              flex: 60,
              // fit: FlexFit.tight,
              // Uses to hide widget when flex is going to 0
              child: GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: DimensionsCustom.calculateWidth(1)),
                  padding: EdgeInsets.symmetric(vertical: DimensionsCustom.calculateHeight(1)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(DimensionsCustom.calculateWidth(15)),
                    border: Border.all(
                        width: 1, color: _selectedIndex == 1 ? Colors.blue.shade400 : Colors.white),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.rotate(
                        angle: (_animation.value - 120.0),
                        child: SvgPicture.asset(
                          'assets/icons/gear.svg',
                          width: DimensionsCustom.calculateWidth(7),
                          color:
                              _selectedIndex == 1 ? Colors.blue.shade400 : Colors.blueGrey.shade100,
                        ),
                      ),
                      if (_animationController.value == 1.0)
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: DimensionsCustom.calculateWidth(2)),
                          child: Text(
                            'Setting',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: DimensionsCustom.calculateWidth(5),
                                color: Colors.blue.shade400),
                          ),
                        ),
                    ],
                  ),
                ),
                onTap: () {
                  _onItemTapped(1);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
