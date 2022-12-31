import 'package:flutter/cupertino.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalR {
  // https://6117-85-68-26-122.ngrok.io -> http://localhost:5241
  static const String url = 'your api via ngrok or public one';

  static final HubConnection connection = HubConnectionBuilder()
      .withUrl(
          url + '/chatHub',
          HttpConnectionOptions(
            logging: (level, message) => print(message),
          ))
      .build();

  static Future<void> initHub() async {
    debugPrint('Starting Hub : ' + url + '/chatHub');
    await connection.start();
  }

  static Future<void> stopHub() async {
    debugPrint('Stopping Hub : ' + url + '/chatHub');
    await connection.stop();
  }

  // GROUP PART and EVERYONE PART

  static Future<void> joinGroup(String groupName) async {
    connection.invoke('JoinGroup', args: [groupName]);
  }

  static Future<void> removeFromGroup(String groupName) async {
    connection.invoke('RemoveFromGroup', args: [groupName]);
  }

  static Future<void> sendMessageToEveryone(String name, String text) async {
    connection.invoke('SendMessageToEveryone', args: [name, text]);
  }

  static Future<String> sendMessageToGroup(
      String groupName, String userName, String text) async {
    connection.invoke('SendMessageToGroup', args: [groupName, userName, text]);
    return text;
  }
}
