import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  SignupScreenState createState() {
    return SignupScreenState();
  }
}

class SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _showPassword = false;
  bool _showRePassword = false;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  void _toggle() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toggleRePassword() {
    setState(() {
      _showRePassword = !_showRePassword;
    });
  }

  Future<void> _onPressSignup() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/images/facebook_banner.png',
                  fit: BoxFit.cover,
                  height: DimensionsCustom.calculateHeight(26),
                ),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: DimensionsCustom.calculateHeight(1)),
                      child: Center(
                          child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_outlined,
                          size: DimensionsCustom.calculateWidth(10),
                        ),
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: DimensionsCustom.calculateWidth(4),
                          vertical: DimensionsCustom.calculateHeight(1)),
                      child: TextFormField(
                        validator: (value) {
                          // if (value == null || value.trim().isEmpty) {
                          //   return 'Please enter some text';
                          // } else if (!RegexPattern.regexEmail
                          //     .hasMatch(value.trim())) {
                          //   return 'Please enter email correct';
                          // }
                          return null;
                        },
                        keyboardAppearance: Brightness.dark,
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(), labelText: 'Enter your email'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: DimensionsCustom.calculateWidth(4),
                          vertical: DimensionsCustom.calculateHeight(1)),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter some text';
                          } else if (value.trim().length < 6) {
                            return 'Password must at least 6 characters';
                          } else if (value.trim().length > 32) {
                            return 'Password must be max 32 character';
                          }
                          return null;
                        },
                        keyboardAppearance: Brightness.dark,
                        obscureText: !_showPassword,
                        controller: _pass,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: _toggle,
                                icon: Padding(
                                    padding:
                                        EdgeInsets.only(top: DimensionsCustom.calculateHeight(2)),
                                    child: Icon(
                                        _showPassword ? Icons.visibility : Icons.visibility_off))),
                            border: const UnderlineInputBorder(),
                            labelText: 'Enter your password'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: DimensionsCustom.calculateWidth(4),
                          vertical: DimensionsCustom.calculateHeight(1)),
                      child: TextFormField(
                        validator: (value) {
                          if (value != _pass.text) {
                            return 'Confirm password must be equal password';
                          }
                          return null;
                        },
                        keyboardAppearance: Brightness.dark,
                        obscureText: !_showRePassword,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: _toggleRePassword,
                                icon: Padding(
                                    padding:
                                        EdgeInsets.only(top: DimensionsCustom.calculateHeight(2)),
                                    child: Icon(_showRePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off))),
                            border: const UnderlineInputBorder(),
                            labelText: 'Enter your repassword'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: DimensionsCustom.calculateWidth(4),
                          vertical: DimensionsCustom.calculateHeight(1)),
                      child: TextFormField(
                        keyboardAppearance: Brightness.dark,
                        // controller: _pass,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: _toggle,
                                icon: Padding(
                                    padding:
                                        EdgeInsets.only(top: DimensionsCustom.calculateHeight(2)),
                                    child: Icon(
                                        _showPassword ? Icons.visibility : Icons.visibility_off))),
                            border: const UnderlineInputBorder(),
                            labelText: 'Enter your phone number'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: DimensionsCustom.calculateWidth(4),
                          vertical: DimensionsCustom.calculateHeight(1)),
                      child: TextFormField(
                        keyboardAppearance: Brightness.dark,
                        // controller: _pass,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: _toggle,
                                icon: Padding(
                                    padding:
                                        EdgeInsets.only(top: DimensionsCustom.calculateHeight(2)),
                                    child: Icon(
                                        _showPassword ? Icons.visibility : Icons.visibility_off))),
                            border: const UnderlineInputBorder(),
                            labelText: 'Enter your name'),
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: DimensionsCustom.calculateWidth(4),
                      vertical: DimensionsCustom.calculateHeight(1)),
                  child: ElevatedButton(
                    onPressed: _onPressSignup,
                    child: const Text('Signup'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: DimensionsCustom.calculateWidth(4),
                      vertical: DimensionsCustom.calculateHeight(1)),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      Navigator.pop(context);
                    },
                    child: const Text('Login'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
