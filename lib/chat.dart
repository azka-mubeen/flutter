import 'package:flutter/material.dart';

//import 'homePage/navigation/bottom_nav.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController =
  TextEditingController();
  final List<String> _messages = [];

  void _sendMessage(String message) {
    setState(() {
      _messages.add(message);
      _textEditingController.clear();
    });
  }

  Widget _buildChatMessageList() {
    return ListView.builder(
      itemCount: _messages.length,
      itemBuilder: (BuildContext context, int index) {
        final message = _messages[index];
        return ListTile(
          title: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: const Color(0xff26495c),

      ),


      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildChatMessageList(),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_textEditingController.text);
                  },
                ),

              ],
            ),
          ),

        ],
      ),
      // bottomNavigationBar: MyBottomNavigationBar(
      //   currentIndex: 1, // Set the current index based on the active screen
      //   onTap: (index) {
      //     // Handle navigation when an item on the bottom navigation bar is tapped
      //     // You can use Navigator or any other navigation method here
      //   },
      // ),
    );
  }
}


