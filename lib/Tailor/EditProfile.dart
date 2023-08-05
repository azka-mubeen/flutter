import 'package:flutter/material.dart';
import 'package:tailor_assistant/Tailor/create_profile.dart';
import 'package:tailor_assistant/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../Functions/dress.dart';
//import '../homePage/navigation/bottom_nav.dart';

class EditProfileScreen extends StatelessWidget {
  User userData;

  EditProfileScreen(this.userData, {Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xff26495c),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://media.istockphoto.com/id/1088080594/photo/tailoring.webp?b=1&s=170667a&w=0&k=20&c=-HSjpApjJphXmPpjZy1SJJLa1TLHXfP2VcUNT_adI5I='),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 110.0),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        'https://cdn.pixabay.com/photo/2012/04/13/21/07/user-33638_1280.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 110.0),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        userData.imgUrl, // Provide the actual URL here
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff26495c),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(userData)));
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profile'),
                ),
              ),
            ),

            // Display user name and location
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.person,
                    color: Color(0xffc4a35a),
                  ),
                  Expanded(
                    child: Text(
                      '${userData.firstName}${' '}${userData.lastName}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xffc4a35a),
                  ),
                  Expanded(
                    child: Text(
                      userData.location,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('dresses')
                  .where(FieldPath.documentId, isEqualTo: userData.uId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error fetching data'),
                  );
                }

                // Clear dresses list before updating
               // userData.dresses.clear();

                // Iterate over the documents and populate the dresses list
                for (var document in snapshot.data!.docs) {
                  var data = document.data() as Map<String, dynamic>;
                  List dresses = data['dresses']??[];
                  for(var dress in dresses){
                    userData.dresses.add(
                      Dress(
                        description: dress['description'] ?? '',
                        imageUrl: dress['imageUrl'] ??
                            'https://cdn.pixabay.com/photo/2012/04/13/21/07/user-33638_1280.png',
                      ),
                    );
                  }

                }


                return SingleChildScrollView(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      viewportFraction: 0.9,
                      initialPage: 2,
                    ),
                    items: userData.dresses.map((dress) {
                      return Center(
                        child: Column(
                          children: [
                            Image.network(
                              dress.imageUrl,
                              fit: BoxFit.contain,
                              width: 200,
                              height: 150,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              dress.description,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );

              },
            ),
          ],
        ),
      ),
      //      bottomNavigationBar: MyBottomNavigationBar(
      //   currentIndex: 2, // Set the current index based on the active screen
      //   onTap: (index) {
      //     // Handle navigation when an item on the bottom navigation bar is tapped
      //     // You can use Navigator or any other navigation method here
      //   },
      // ),
    );
  }
}
