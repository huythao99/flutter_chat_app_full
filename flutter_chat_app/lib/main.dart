import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/src/apis/client_api.dart';
import 'package:flutter_chat_app/src/apis/models/user/user_info_model.dart';
import 'package:flutter_chat_app/src/blocs/app_bloc_observer.dart';
import 'package:flutter_chat_app/src/blocs/user/user_bloc.dart';
import 'package:flutter_chat_app/src/blocs/user/user_event.dart';
import 'package:flutter_chat_app/src/blocs/user/user_state.dart';
import 'package:flutter_chat_app/src/common_widgets/error/error_page_widgets.dart';
import 'package:flutter_chat_app/src/constants/key_storage.dart';
import 'package:flutter_chat_app/src/constants/route/route_auth.dart';
import 'package:flutter_chat_app/src/constants/route/route_main.dart';
import 'package:flutter_chat_app/src/features/auth/login/login_screen.dart';
import 'package:flutter_chat_app/src/features/auth/signup/signup_screen.dart';
import 'package:flutter_chat_app/src/features/home/home_screen.dart';
import 'package:flutter_chat_app/src/local_storage/shared_preferences.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  ClientApi.initClientApi();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<UserBloc>(
      create: (context) => UserBloc(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool authenticated = false;

  void _onChangeStatus(bool status) {
    setState(() {
      authenticated = status;
    });
  }

  void onStart() async {
    await SharedStorage().initPreferences();

    final String user = await SharedStorage().getStringData(KeyStorage.user);
    if (user != '' && context.mounted) {
      BlocProvider.of<UserBloc>(context).add(UserChanged(User.fromJson(jsonDecode(user))));
    } else {
      _onChangeStatus(false);
      navigatorKey.currentState?.pushNamedAndRemoveUntil(RouteAuth.routeLogin, (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    onStart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state.userToken != '' && !authenticated) {
            _onChangeStatus(true);
            navigatorKey.currentState
                ?.pushNamedAndRemoveUntil(RouteMain.routeHome, (route) => false);
          } else {
            _onChangeStatus(false);
            navigatorKey.currentState
                ?.pushNamedAndRemoveUntil(RouteAuth.routeLogin, (route) => false);
          }
        },
        listenWhen: (previous, current) {
          return previous.userToken != current.userToken;
        },
        child: MaterialApp(
          navigatorKey: navigatorKey,
          onGenerateRoute: (settings) {
            late Widget page;
            if (authenticated) {
              switch (settings.name) {
                case RouteMain.routeHome:
                  page = const HomeScreen();
                  break;
                default:
                  page = const ErrorPageWidget();
                  break;
              }
            } else {
              switch (settings.name) {
                case RouteAuth.routeLogin:
                  page = const LoginScreen();
                  break;
                case RouteAuth.routeSignup:
                  page = const SignupScreen();
                  break;

                default:
                  page = const ErrorPageWidget();
                  break;
              }
            }

            return MaterialPageRoute<dynamic>(
              builder: (context) {
                return page;
              },
              settings: settings,
            );
          },
          debugShowCheckedModeBanner: false,
          home: authenticated ? const HomeScreen() : const LoginScreen(),
        ));
  }
}
