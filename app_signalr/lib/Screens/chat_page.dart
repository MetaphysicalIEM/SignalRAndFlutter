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
    widget.talkToEveryone ? _runEveryoneRoom() : _runGroupRoom();
    super.initState();
  }

  void _runEveryoneRoom() {
    SignalR.connection.on('ReceiveMessageFromEveryone', (arguments) {
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

  void _runGroupRoom() {
    SignalR.connection.on('ReceiveMessageFromGroup', (arguments) {
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

  void _sendMessage() {
    widget.talkToEveryone
        ? SignalR.sendMessageToEveryone(
            widget.userName, _messageEditingController.text)
        : SignalR.sendMessageToGroup(
            widget.groupName, widget.userName, _messageEditingController.text);
    _messageEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          widget.talkToEveryone ? 'General Chat' : widget.groupName,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            if (!widget.talkToEveryone) {
              SignalR.removeFromGroup(widget.groupName);
            }
            Future.delayed(const Duration(milliseconds: 700), () {
              Navigator.pop(context);
            });
          },
        ),
      ),
      body: SingleChildScrollView(child: _buildScreen()),
    );
  }

  Widget _buildScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.black,
          width: double.infinity,
          height: 650,
          child: ListView.builder(
            itemCount: _listMessage.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                child: Text(_listMessage[index],
                    style: const TextStyle(
                        color: Colors.white, fontStyle: FontStyle.italic)),
              );
            },
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              textAlign: TextAlign.center,
              controller: _messageEditingController,
              cursorColor: Colors.blue,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                      onTap: () {
                        print('Send message');
                        _sendMessage();
                      },
                      child: const Icon(Icons.send)),
                  border: const OutlineInputBorder(),
                  hintText: 'Your message',
                  hintStyle: const TextStyle(color: Colors.black)),
            ),
          ),
        )
      ],
    );
  }
}
