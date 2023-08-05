import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:path/path.dart' as Path;
  import 'package:image_picker/image_picker.dart';
  import 'package:tailor_assistant/models/User.dart';
  import 'dart:io';
  import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
  import '../Functions/dress.dart';
  import 'EditProfile.dart';


  class UploadDress extends StatefulWidget {
  final User userData;

  const UploadDress(this.userData, {Key? key}) : super(key: key);

  @override
  State<UploadDress> createState() => _UploadDressState(userData);
  }

  class _UploadDressState extends State<UploadDress> {
  File? _pickedImage;
  final User userData;
  final _formKey = GlobalKey<FormState>();
  TextEditingController desController = TextEditingController();
  _UploadDressState(this.userData);

  Future<void> _pickImage() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
  setState(() {
  _pickedImage = File(pickedImage.path);
  });
  }
  }

  // Storage dress to firebase Storage
  Future<void> uploadDress(Dress dress, User userData) async {
  if (_pickedImage == null) return;

  try {
  String dressName = Path.basename(_pickedImage!.path);

  firebase_storage.Reference firebaseStorageRef =
  firebase_storage.FirebaseStorage.instance.ref().child(dressName);
  await firebaseStorageRef.putFile(_pickedImage!);
  String imageUrl = await firebaseStorageRef.getDownloadURL();

  // Create a new Dress object with the provided description and the imageUrl from Firebase
  Dress newDress = Dress(description: dress.description, imageUrl: imageUrl);

  // Add the new dress to the user's dresses list
  userData.dresses.add(newDress);
// Save the dress data to Firestore
  await FirebaseFirestore.instance.collection('dresses').doc(userData.uId).set({
  'dresses': userData.dresses.map((dress) {
  return {
  'description': dress.description,
  'imageUrl': dress.imageUrl,
  };
  }).toList(),
  });
  // Show a success message
  ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
  content: Text('Dress uploaded successfully'),
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.green,
  ),
  );
  } catch (e) {
  Get.snackbar('Error', 'Error uploading dress: $e');
  }
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          "assets/images/machine.jpg",
                          fit: BoxFit.fill,
                        ),
                        const Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: Text(
                              "Capture the Essence of your style",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Poppins",
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff26495c),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20.0),
                    margin: const EdgeInsets.all(10),
                    child: const Text(
                      "Please upload dresses to make your profile look better",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.2125,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    height: 100,
                    width: 100,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Material(
                        elevation: 4, // Adjust the elevation as needed
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                // Adjust the blur radius as needed
                                offset: const Offset(
                                  0,
                                  2,
                                ), // Adjust the offset as needed
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              _pickedImage != null
                                  ? Image.file(_pickedImage!, fit: BoxFit.cover)
                                  : const SizedBox(),
                              _pickedImage == null
                                  ? const Icon(
                                      Icons.add,
                                      size: 50,
                                      color: Colors.black,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: desController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xffffffff),
                        hintText: 'Add dress Description',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: 310,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff26495c),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          // Create a Dress object and pass the description
                          // from the TextField
                          Dress dress = Dress(description: desController.text.trim(), imageUrl: 'imageUrl');

                          // Call the uploadDress function to store the dress data
                          uploadDress(dress, userData);
                          desController.clear();
                        },
                        child: const Text("Upload Dress"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to the next page (EditProfileScreen)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfileScreen(userData),
              ),
            );
          },
          backgroundColor: const Color(0xff26495c),
          child: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
