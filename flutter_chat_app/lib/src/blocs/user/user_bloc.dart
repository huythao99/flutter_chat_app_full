import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/apis/models/user/user_info_model.dart';
import 'package:flutter_chat_app/src/blocs/user/user_event.dart';
import 'package:flutter_chat_app/src/blocs/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState.empty()) {
    on<UserChanged>(_onUserChanged);
  }

  late StreamSubscription<User> _userSubscription;

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }

  void _onUserChanged(
    UserChanged event,
    Emitter<UserState> emit,
  ) {
    if (event.user != null) {
      emit(UserState.updateUser(event.user));
    } else {
      emit(const UserState.updateUser(null));
    }
  }
}
