
// ignore_for_file: use_build_context_synchronously, library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Admin/admin_panel.dart';
import '../Login/login_page.dart';
import '../Tailor/EditProfile.dart';
//import '../Tailor/create_profile.dart';
import '../homePage/MyHomePage.dart';
//import '../homePage/home.dart';
import '../models/User.dart' as MyUser;

class Auth{
  //Sign up authentication
  signup(MyUser.User user,BuildContext context) async {
    try {
// ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: user.password);
      final uid = FirebaseAuth.instance.currentUser?.uid;
      user.uId = uid!;
      FirebaseFirestore.instance.collection(
          'user').doc(uid).set(
          user.createMap()
      ).then((_) {

        // show msg on successful registration
        ScaffoldMessenger
            .of(context)
            .showSnackBar(
          const SnackBar(content: Text(
              'You have been registered successfully'),

            elevation: 0,
            behavior: SnackBarBehavior
                .floating,
            backgroundColor: Colors.green,

          ),

        )
            .closed
            .then((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (
                context) => const LoginPage()),
          );
        });
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Warning: ','The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Warning: ','The account already exist for the email.');
      }
    } catch (e) {
      Get.snackbar('Error: ','Error creating account $e');
    }
  }

// Login authentication
  signin(String email, password, BuildContext context) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final uid = FirebaseAuth.instance.currentUser?.uid;
      DocumentSnapshot  snapshot = (await FirebaseFirestore
          .instance
          .collection('user').doc(uid)

          .get());

      if (snapshot.exists) {
        MyUser.User userData = MyUser.User.empty();

        Map<String, dynamic> dataMap = snapshot.data() as  Map<String, dynamic>;
        if (dataMap != null) {
          userData.initializeVariablesFromMap(dataMap);

          if (userData.getRole== 'tailor') {
            await Future.delayed(const Duration(seconds: 1));
            Navigator.of(context).pop();// close the circular progress indicator
            Navigator.of(context).push(// navigate to profile page
              MaterialPageRoute(
                builder: (context) =>  EditProfileScreen(userData),
              ),
            );
          } else if (userData.getRole == 'customer') {
            await Future.delayed(const Duration(seconds: 1));
            Navigator.of(context).pop();// close the circular progress indicator
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>  MyHomePage(userData),
              ),
            );
          } else if (userData.email== 'admin@gmail.com' && userData.password == 'Admin@123') {
            await Future.delayed(const Duration(seconds: 1));
            Navigator.of(context).pop();// close the circular progress indicator
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AdminPanelScreen(userData),
              ),
            );
          }
        } else {
          // Handle the case when userData is null
          Get.snackbar('Warning: ','User data not found.');
          Navigator.of(context).pop();
        }
      } else {
        // Handle the case when the document doesn't exist
        Get.snackbar('Warning: ','The document does not exist');
        Navigator.of(context).pop();
      }

      print('/////// Success ////////');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Register: ','Please first sign up');
        Navigator.of(context).pop();
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error: ','Wrong password provided');
        Navigator.of(context).pop();
      }
    }
  }
  // Function to reset password , firebase will send email to user to reset password
  Future<void> sendPasswordResetEmail(String email) async{

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    //Navigator.of(context as BuildContext).pop();
    Get.snackbar("Success", "Successfully send email");
    Future.delayed(Duration(seconds: 3), () {
      Get.off(() => const LoginPage());
    });
  }

}
