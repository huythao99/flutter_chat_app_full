import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/src/blocs/app_bloc_observer.dart';
import 'package:flutter_chat_app/src/common_widgets/error/error_page_widgets.dart';
import 'package:flutter_chat_app/src/constants/route/route_auth.dart';
import 'package:flutter_chat_app/src/features/auth/login/login_screen.dart';
import 'package:flutter_chat_app/src/features/auth/signup/signup_screen.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool authenticated = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        late Widget page;
        if (authenticated) {
          switch (settings.name) {
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
      home: const LoginScreen(),
    );
  }
}
