
// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:tailor_assistant/Tailor/upload_dress.dart';
import 'package:path/path.dart' as Path;
import '../models/User.dart' as MyUser;

class Profile extends StatefulWidget {
  var userData;

 Profile(this.userData, {Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState(userData);
}

class _ProfileState extends State<Profile> {
  final MyUser.User userData ;
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController sNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? downloadURL;
  File? _imageFile;
  final _formKey = GlobalKey<FormState>();
  final image = ImagePicker();

  _ProfileState(this.userData);

  // function to pick image from gallery
  Future<void> pickImage() async {
    final pickedFile = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        Get.snackbar("Error", "No image selected");
      }
    });
  }

  // function to upload image
  Future<void> uploadImage() async {
    if (_imageFile == null) return;

    try {
      String fileName = Path.basename(_imageFile!.path);
      firebase_storage.Reference firebaseStorageRef =
      firebase_storage.FirebaseStorage.instance.ref().child(fileName);
      await firebaseStorageRef.putFile(_imageFile!);
      String imageUrl = await firebaseStorageRef.getDownloadURL();

      // Save the download URL to the local variable
      userData.imgUrl = imageUrl;
    } catch (e) {
      Get.snackbar('Error', 'Error uploading image: $e');
    }
  }


  Future<void> updateProfile(user, BuildContext context) async {
    try {
      // Upload the user's image to Firebase Storage
      await uploadImage();

      // Save the user's data to Firestore
        await saveUserData();
      Navigator.of(context, rootNavigator: true).pop();
      // Show a success message
      await ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your profile has been created'),
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
        ),

      );

    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      Get.snackbar('Error', 'Error creating account: $e');
    }
  }

  Future<void> saveUserData() async {
    try {
      // Save the user data to Firestore
      await FirebaseFirestore.instance.collection('user').doc(userData.uId).set(
        userData.createMap(),
      );
    } catch (e) {
      Get.snackbar('Error', 'Error saving user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          backgroundColor: const Color(0xff4257b4),
          title: const Text("Profile"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.location_on_outlined),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10),
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                          )
                        ],
                        shape: BoxShape.circle,
                        image: _imageFile != null
                            ? DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(_imageFile!),
                        )
                            : const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://cdn.pixabay.com/photo/2012/04/13/21/07/user-33638_1280.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 4, color: Colors.white),
                          color: Colors.grey,
                        ),
                        child: GestureDetector(
                          onTap: pickImage,
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // user name
                const SizedBox(height: 16.0),
                const Text(
                  'User Name', // Replace with actual user name
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // rating bar
                const SizedBox(height: 8.0),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star_half, color: Colors.yellow),
                      SizedBox(width: 5.0),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    // First Name
                    Row(
                      children: <Widget>[
                        const Icon(Icons.account_circle),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: fNameController,
                            decoration: const InputDecoration(
                              hintText: "First Name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                        )
                      ],
                    ),
                    // Last Name
                    Row(
                      children: <Widget>[
                        const Icon(Icons.account_circle),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: lNameController,
                            decoration: const InputDecoration(
                              hintText: "Last Name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    // Shop Name
                    Row(
                      children: <Widget>[
                        const Icon(Icons.add_business),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: sNameController,
                            decoration: const InputDecoration(
                              hintText: "Shop Name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your shop name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    // Phone Number
                    Row(
                      children: <Widget>[
                        const Icon(Icons.add_call),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: phoneNoController,
                            decoration: const InputDecoration(
                              hintText: "Phone Number",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    // Address
                    Row(
                      children: <Widget>[
                        const Icon(Icons.account_box_rounded),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: addressController,
                            decoration: const InputDecoration(
                              hintText: "Address",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20, width: 200),
                const SizedBox(height: 20),
                SizedBox(
                  width: 310,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff26495c),
                    ),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(child: CircularProgressIndicator());
                        },
                      );
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        try {
                            userData.firstName =  fNameController.text.trim();
                            userData.lastName = lNameController.text.trim();
                            userData.shopName = sNameController.text.trim();
                            userData.phoneNo = phoneNoController.text.trim();
                            userData.address = addressController.text.trim();


                          await updateProfile(userData, context);

                            Navigator.of(context, rootNavigator: true).pop();
                        } catch (e) {
                          Navigator.of(context, rootNavigator: true).pop();
                          Get.snackbar("Error","Error occurred: $e");

                        }
                      }
                      // Navigate to UploadDress
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UploadDress(userData)),
                      );
                    },
                    child: const Text('Create'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
