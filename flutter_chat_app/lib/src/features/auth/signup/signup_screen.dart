import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/constants/dimensions.dart';
import 'package:flutter_chat_app/src/constants/validate_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_chat_app/src/constants/regex.dart';

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

  XFile? _image;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _name = TextEditingController();

  final ImagePicker _picker = ImagePicker();

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

  Future<void> _onPickerAvatar() async {
    try {
      var image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    } catch (e) {
      // debugPrint(e.toString());
    }
  }

  Future<void> _onPressSignup() async {
    // debugPrint(_formKey.currentState.toString());
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        toolbarHeight: 0,
        elevation: 0,
      ),
      body: ListView(
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
                padding: EdgeInsets.symmetric(vertical: DimensionsCustom.calculateHeight(2)),
                child: Center(
                  child: Ink(
                    width: DimensionsCustom.calculateWidth(30),
                    height: DimensionsCustom.calculateWidth(30),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      shape: BoxShape.circle,
                    ),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(DimensionsCustom.calculateWidth(15)),
                        onTap: _onPickerAvatar,
                        child: _image != null
                            ? ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(DimensionsCustom.calculateWidth(15)),
                                child: Image.file(
                                  File(_image!.path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(Icons.add_outlined,
                                color: Colors.blueAccent,
                                size: DimensionsCustom.calculateWidth(15))),
                  ),
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
                    } else if (!RegexPattern.regexEmail.hasMatch(value.trim())) {
                      return 'Please enter email correct';
                    }
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
                    } else if (value.trim().length < ValidateText.minLength) {
                      return 'Password must at least 6 characters';
                    } else if (value.trim().length > ValidateText.maxLength) {
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
                              padding: EdgeInsets.only(top: DimensionsCustom.calculateHeight(2)),
                              child:
                                  Icon(_showPassword ? Icons.visibility : Icons.visibility_off))),
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
                              padding: EdgeInsets.only(top: DimensionsCustom.calculateHeight(2)),
                              child:
                                  Icon(_showRePassword ? Icons.visibility : Icons.visibility_off))),
                      border: const UnderlineInputBorder(),
                      labelText: 'Enter your repassword'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: DimensionsCustom.calculateWidth(4),
                    vertical: DimensionsCustom.calculateHeight(1)),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    } else if (!RegexPattern.regexPhone.hasMatch(value.trim())) {
                      return 'Your phone number is invalid';
                    }
                    return null;
                  },
                  keyboardAppearance: Brightness.dark,
                  controller: _phone,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Enter your phone number'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: DimensionsCustom.calculateWidth(4),
                    vertical: DimensionsCustom.calculateHeight(1)),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    } else if (value.trim().length < ValidateText.minLength) {
                      return 'Your name is too short';
                    } else if (value.trim().length > ValidateText.maxLength) {
                      return 'Your name is too long';
                    }
                    return null;
                  },
                  keyboardAppearance: Brightness.dark,
                  controller: _name,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(), labelText: 'Enter your name'),
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
  }
}
