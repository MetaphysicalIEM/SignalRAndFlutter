import 'package:signalr_core/signalr_core.dart';

class SignalR {
  static const String url =
      'https://85de-2a00-23c7-c98c-e01-5023-db51-de42-f576.ngrok.io';
  static final HubConnection connection = HubConnectionBuilder()
      .withUrl(
          url + '/chatHub',
          HttpConnectionOptions(
            logging: (level, message) => print(message),
          ))
      .build();

  static Future<void> initHub() async {
    await connection.start();
    print('Starting Hub : ' + url + '/chatHub');
  }

  static Future<void> stopHub() async {
    await connection.stop();
  }

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
