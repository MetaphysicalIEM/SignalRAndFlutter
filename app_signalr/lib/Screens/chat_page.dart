import 'package:app_signalr/Network/signal_r.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  final String groupName;
  final bool talkToEveryone;
  const ChatPage(
      {Key? key,
      required this.userName,
      required this.groupName,
      required this.talkToEveryone})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<String> _listMessage = [];

  final TextEditingController _messageEditingController =
      TextEditingController();

  @override
  void initState() {
    widget.talkToEveryone ? runTalk() : runTalkGroup();
    super.initState();
  }

  void runTalk() {
    SignalR.connection.on('MessageForEveryone', (arguments) {
      print(arguments);
      print('everyone talk');
      try {
        setState(() {
          _listMessage.add(arguments![0] + ': ' + arguments[1]);
        });
      } catch (e) {
        print(e);
      }
    });
  }

  void runTalkGroup() {
    SignalR.connection.on('SendMessageToGroup', (arguments) {
      print(arguments);
      print('group talk');
      try {
        setState(() {
          _listMessage.add(arguments![0] + ': ' + arguments[1]);
        });
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          widget.talkToEveryone ? 'General Chat' : widget.groupName,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            if (!widget.talkToEveryone) {
              SignalR.removeFromGroup(widget.groupName);
            }
            Future.delayed(Duration(milliseconds: 700), () {
              Navigator.pop(context);
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Container(
                height: 500,
                width: double.infinity,
                color: Colors.black,
                child: Column(
                  children: [
                    for (int i = 0; i < _listMessage.length; i++)
                      Text(
                        _listMessage[i],
                        style: TextStyle(
                            color: Colors.white, fontStyle: FontStyle.italic),
                      )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                textAlign: TextAlign.center,
                controller: _messageEditingController,
                cursorColor: Colors.blue,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {
                          print('send');
                          sendMessage();
                        },
                        child: Icon(Icons.send)),
                    border: OutlineInputBorder(),
                    hintText: 'Your message',
                    hintStyle: TextStyle(color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> sendMessage() async {
    if (widget.talkToEveryone) {
      SignalR.sendMessageToEveryone(
          widget.userName, _messageEditingController.text);
    } else {
      SignalR.sendMessageToGroup(
          widget.groupName, widget.userName, _messageEditingController.text);
    }
    _messageEditingController.clear();
  }
}
