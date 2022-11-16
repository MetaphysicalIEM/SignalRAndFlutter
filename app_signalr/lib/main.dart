import 'package:app_signalr/Network/signal_r.dart';
import 'package:app_signalr/Screens/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
