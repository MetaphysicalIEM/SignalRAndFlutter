import 'package:app_signalr/Network/signal_r.dart';
import 'package:app_signalr/Screens/chat_page.dart';
import 'package:app_signalr/Widgets/logo_menu.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerGroup = TextEditingController();

  bool _talkToEveryone = false;
  bool _talkToGroup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.blue, Colors.black]),
          ),
          width: double.infinity,
          height: double.infinity,
          child: _buildPickOption()),
    );
  }

  Widget _buildPickOption() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoMenu(),
            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                textAlign: TextAlign.center,
                controller: _controllerName,
                cursorColor: Colors.white,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'User name',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                textAlign: TextAlign.center,
                controller: _controllerGroup,
                cursorColor: Colors.white,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.characters,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Group name',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextButton.icon(
              onPressed: () {
                if (_talkToGroup == false) {
                  setState(() {
                    _talkToGroup = true;
                    _talkToEveryone = false;
                  });
                } else {
                  setState(() {
                    _talkToGroup = false;
                  });
                }
              },
              style: TextButton.styleFrom(backgroundColor: Colors.black),
              icon: Icon(
                Icons.chat,
                color: _talkToGroup ? Colors.green : Colors.blue,
              ),
              label: Text(
                'G.R want to talk',
                style:
                    TextStyle(color: _talkToGroup ? Colors.green : Colors.blue),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                if (_talkToEveryone == false) {
                  setState(() {
                    _talkToEveryone = true;
                    _talkToGroup = false;
                  });
                } else {
                  setState(() {
                    _talkToEveryone = false;
                  });
                }
              },
              style: TextButton.styleFrom(backgroundColor: Colors.black),
              icon: Icon(
                Icons.chat,
                color: _talkToEveryone ? Colors.green : Colors.blue,
              ),
              label: Text(
                'E.V want to talk',
                style: TextStyle(
                    color: _talkToEveryone ? Colors.green : Colors.blue),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.black),
              onPressed: validate,
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }

  bool confirmData() {
    return ((_controllerGroup.text.isNotEmpty ||
                _controllerName.text.isNotEmpty) &&
            (_talkToEveryone || _talkToGroup))
        ? true
        : false;
  }

  void validate() {
    if (confirmData()) {
      if (_talkToGroup) {
        SignalR.joinGroup(_controllerGroup.text);
      }
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatPage(
                  userName: _controllerName.text,
                  groupName: _controllerGroup.text,
                  talkToEveryone: _talkToEveryone,
                )),
      );
    } else {
      print('error');
    }
  }
}
