import 'package:flutter/material.dart';
import 'package:flutter_chat_app/src/apis/client_api.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ClientSocket {
  static Socket? _socket;

  static initial() {
    _socket ??= io(ClientApi.socketURL,
        OptionBuilder().setTransports(['websocket']).build());
    _socket?.on("connect_error", (error) {
      debugPrint('connect error' + error.toString());
    });
    _socket?.on("connect", (_) => debugPrint("connected"));
    _socket?.on('disconnect', (data) => {_socket?.connect()});
  }

  static listenEvent(String eventName, Function(dynamic) callback) {
    debugPrint("init run listen event $eventName");
    _socket?.on(eventName, (data) => callback(data));
  }

  static stopListenEvent(String event) {
    _socket?.off(event);
  }

  static emitEvent(String event, dynamic params) {
    _socket?.emit(event, params);
  }
}
