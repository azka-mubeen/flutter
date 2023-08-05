import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Profile'),
          backgroundColor:  const Color(0xff26495c),

        ),
        floatingActionButton: Container(
          height: 100,
          width: 100,
          child: FloatingActionButton(
            backgroundColor: const Color(0xff26495c),
            child: const Text("Send Request",
            textAlign: TextAlign.center),
            onPressed: () {

            },
          ),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/cover_photo.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile_photo.jpg'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Icon(Icons.person,
                    color: Color(0xffc4a35a),
                  ),
                  Expanded(
                    child: Text(
                      'Anisa Kanwal',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],),
              const SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Icon(Icons.location_on_outlined,
                    color: Color(0xffc4a35a),
                  ),
                  Expanded(
                    child: Text(
                      'Near Jahaz Choak',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 ElevatedButton.icon(
                   style: ElevatedButton.styleFrom(
                     backgroundColor: const Color(0xff26495c),
                   ),
                    onPressed: () {
                      // Chat button onPressed logic
                    },
                    icon: const Icon(Icons.chat),
                    label: const Text('Chat'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

            ],
           ),
      );
    }
}
