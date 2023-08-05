// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:tailor_assistant/models/User.dart';
import '../Customer/user_profile.dart';
import '../Tailor/EditProfile.dart';
import '../Tailor/upload_dress.dart';
//import '../chat.dart';
//import 'navigation/bottom_nav.dart';
import 'navigation/nav_drawer.dart';

class HomePage extends StatefulWidget {

  User userData;
  HomePage(this.userData, {super.key});

  @override
  State<HomePage> createState() => _HomePageState(this.userData);
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final User userData;
 
  

  _HomePageState(this.userData){
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(


          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
            backgroundColor: const Color(0xff26495c),
            title: const Text("Home"),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Page2()));
                },
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color(0xff26495c),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [

                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            'https://png.pngtree.com/png-clipart/20190924/original/pngtree-vector-user-young-boy-avatar-icon-png-image_4827810.jpg'),
                      ),
                      SizedBox(height: 10
                      ),
                      Text(
                        'User',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),

                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Your Profile'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen(userData)));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.notifications_none),
                  title: const Text('Notifications'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Page2()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Privacy policy'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Page3()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Page4()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.perm_contact_cal_outlined),
                  title: const Text('About'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Page5()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.call),
                  title: const Text('Contact us'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Page6()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help_outline_sharp),
                  title: const Text('Help'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Page7()));
                  },
                ),
              ],
            ),
          ),
          body: IndexedStack(
            //index: _currentIndex,
            children: [
              // ListView for the first tab
              ListView(
                children: [
                  _buildUserPost(
                    username: 'Tailor 1',
                    location: 'Kalabagh, Mianwali',
                    time: '5 hours ago',
                    profilePhotoUrl:
                    'https://cdn.icon-icons.com/icons2/2859/PNG/512/avatar_face_girl_female_woman_profile_smiley_happy_people_icon_181665.png',
                    postImages: [
                      'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1656012267-best-flowy-dresses-women-doen-dress-1656012229.png?crop=1xw:0.9952380952380953xh;center,top&resize=980:*',
                      'https://m.media-amazon.com/images/I/51by4AVedeL._AC_UY1000_.jpg',
                    ],
                  ),
                  _buildUserPost(
                    username: 'Tailor 2',
                    location: 'Namal, Mianwali',
                    time: '3 hours ago',
                    profilePhotoUrl:
                    'https://cdn.icon-icons.com/icons2/2859/PNG/512/avatar_face_girl_female_woman_profile_smiley_happy_people_icon_181662.png',
                    postImages: [
                      'https://static-01.daraz.pk/p/4aee278b694ca4cd24654204a67db96f.jpg',
                      'https://m.media-amazon.com/images/I/41gDlAL0SmL.jpg',
                    ],
                  ),
                  // Add more user posts here
                ],
              ),

              
            ],
          ),
          // bottomNavigationBar: MyBottomNavigationBar(
          //   currentIndex: 0, // Set the current index based on the active screen
          //   onTap: (index) {
          //
          //   },
          // ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xff26495c),
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => UploadDress(userData)));
            },
          ));
    }

    Widget _buildUserPost({
      required String username,
      required String location,
      required String time,
      required String profilePhotoUrl,
      required List<String> postImages,
    }) {
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => UserProfilePage()));
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(profilePhotoUrl),
                ),
              ),
              title: Text(username),
              subtitle: Text('$location • $time'),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(
                postImages.length,
                    (index) =>
                    SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.network(postImages[index])),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.comment),
                  onPressed: () {
                    // Handle comment button pressed
                  },
                ),
                Row(
                  children: List.generate(
                    5,
                        (index) =>
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

          ],
        ),

      );
    }
  }
