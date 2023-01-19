import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/src/apis/client_api.dart';
import 'package:flutter_chat_app/src/apis/models/user/user_info_model.dart';
import 'package:flutter_chat_app/src/apis/paths/auth_path.dart';
import 'package:flutter_chat_app/src/blocs/user/user_bloc.dart';
import 'package:flutter_chat_app/src/blocs/user/user_event.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_chat_app/src/constants/regex.dart';
import 'package:flutter_chat_app/src/constants/route/route_auth.dart';
import 'package:flutter_chat_app/src/constants/validate_text.dart';
import 'package:flutter_chat_app/src/utils/error_handler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _showPassword = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _onClickEye() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Future<void> _onLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        Map<String, dynamic> body = {
          'email': _emailController.text,
          'password': _passController.text,
        };
        Response res = await ClientApi.postApi(AuthPath.login, body, false);
        if (res.data != null && context.mounted) {
          BlocProvider.of<UserBloc>(context).add(UserChanged(User.fromJson(res.data)));
        }
        // debugPrint(res.data.toString());
        // debugPrint(User.fromJson(res.data).toJson().toString());
      } on DioError catch (e) {
        // debugPrint()
        ErrorHandler().showMessage(e, context);
      }
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.blue,
            statusBarBrightness: Brightness.dark,
          )),
      body: SafeArea(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/facebook_banner.png',
                  fit: BoxFit.cover,
                  height: DimensionsCustom.calculateHeight(26),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: DimensionsCustom.calculateWidth(4),
                            vertical: DimensionsCustom.calculateWidth(4)),
                        child: TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is not empty';
                            } else if (!RegexPattern.regexEmail.hasMatch(value.trim())) {
                              return 'Please enter email correct';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: DimensionsCustom.calculateWidth(4),
                            vertical: DimensionsCustom.calculateWidth(2)),
                        child: TextFormField(
                            controller: _passController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Password is not empty';
                              } else if (value.trim().length < ValidateText.minLength) {
                                return 'Password must at least 6 characters';
                              } else if (value.trim().length > ValidateText.maxLength) {
                                return 'Password must be max 32 character';
                              }
                            },
                            decoration: InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                    onPressed: _onClickEye,
                                    icon: Icon(_showPassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined))),
                            obscureText: !_showPassword),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: DimensionsCustom.calculateWidth(4),
                      vertical: DimensionsCustom.calculateHeight(2)),
                  child: ElevatedButton(
                    onPressed: _onLogin,
                    child: const Text('Login'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: DimensionsCustom.calculateWidth(4),
                      vertical: DimensionsCustom.calculateHeight(1)),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      Navigator.pushNamed(context, RouteAuth.routeSignup);
                    },
                    child: const Text('Signup'),
                  ),
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
