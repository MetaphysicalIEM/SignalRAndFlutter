import 'package:app_signalr/Network/signal_r.dart';
import 'package:app_signalr/Screens/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
https://pub.dev/packages/signalr_core -> signalR Package
https://learn.microsoft.com/en-us/aspnet/core/tutorials/signalr?view=aspnetcore-7.0&tabs=visual-studio -> SignalR set up
https://ngrok.com/ -> use ngrok to create a virtual tunnel with your local API REST
https://learn.microsoft.com/en-us/aspnet/signalr/overview/guide-to-the-api/working-with-groups -> related to SignalR Group
*/

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
  ]);
  SignalR.initHub();
  return runApp(const MaterialApp(
    home: MenuPage(),
  ));
}
