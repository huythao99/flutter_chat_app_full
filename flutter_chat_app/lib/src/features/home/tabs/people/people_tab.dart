import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/apis/client_api.dart';
import 'package:flutter_chat_app/src/apis/paths/user_path.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_chat_app/src/utils/error_handler.dart';
import 'package:flutter_svg/svg.dart';

class PeopleTab extends StatefulWidget {
  const PeopleTab({super.key});

  @override
  State<PeopleTab> createState() => _PeopleTabState();
}

class _PeopleTabState extends State<PeopleTab> {
  Timer? timer;
  final ScrollController _controller = ScrollController();
  final TextEditingController _search = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  int total = 0;
  int currentPage = 0;
  List<Map<String, dynamic>> users = [];

  Future<void> _searchPeople(String text, int page) async {
    try {
      Map<String, dynamic> params = {
        'keyword': text.trim(),
        'page': page,
      };
      Response res = await ClientApi.getApi(UserPath.search, params);
      if (page > 0) {
        setState(() {
          currentPage = page;
          users.addAll(res.data['users']);
        });
      } else {
        setState(() {
          users = [...res.data['users']];

          total = res.data['total'];
          currentPage = page;
        });
      }
    } on DioError catch (e) {
      ErrorHandler().showMessage(e, context);
    } finally {
      // _refreshIndicatorKey.currentState?.;
    }
  }

  void _onLoadMore() {
    if (users.length < total) {
      _searchPeople(_search.text, currentPage + 1);
    }
  }

  Future<void> _onRefresh() async {
    _refreshIndicatorKey.currentState?.show();
    _searchPeople(_search.text, 0);
  }

  @override
  void initState() {
    super.initState();
    _searchPeople('', 0);
    _controller.addListener(() {
      if (_controller.position.extentAfter < DimensionsCustom.endReachedThreshold) {
        _onLoadMore();
      }
    });
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
            'Find people',
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
                Expanded(
                  child: TextField(
                    controller: _search,
                    onChanged: (value) {
                      timer?.cancel();
                      timer = Timer(const Duration(milliseconds: 700), () {
                        _searchPeople(value, 0);
                      });
                    },
                    decoration: const InputDecoration(
                        hintText: 'Search with email, phone, name, ...', border: InputBorder.none),
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/search.svg',
                  width: DimensionsCustom.calculateWidth(6),
                ),
              ],
            )),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: DimensionsCustom.calculateHeight(1.25)),
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _onRefresh,
            child: ListView.builder(
              controller: _controller,
              itemCount: users.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {},
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
                              borderRadius:
                                  BorderRadius.circular(DimensionsCustom.calculateWidth(10)),
                              child: Image.network(
                                users[index]['avatar'] ??
                                    'https://glyndwr.ac.uk/media/marketing/animals/sajad-nori-s1puI2BWQzQ-unsplash-2-1360x1360.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: DimensionsCustom.calculateWidth(4)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  users[index]['username'],
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
              },
            ),
          ),
        ))
      ],
    );
  }
}
