// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Functions/auth.dart';
import '../models/User.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Auth auth = Auth();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // Initially password is obscure
  bool _obscureText = true;
  bool _obscureConfirmPassword = true;
  String dropdownValue = "tailor";
  List<String> userTypes = ['tailor', 'customer', 'admin'];
  final _formKey = GlobalKey<FormState>();

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Toggles the confirm password show status
  void _toggle2() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  // check if the user already exist
  Future<bool> checkEmailExists(String email) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return querySnapshot.size >
        0; // Return true if a user with the given email exists
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(

        child: Form(
            key: _formKey,
            child: Material(
              child: Container(

                  // iphone14pro
                  padding: const EdgeInsets.only(top: 20.0),
                  width: double.infinity,
                  child: Center(

                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(50, 30, 50, 20),
                          width: 80,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(300.5),
                            child: Image.asset(
                              "assets/images/Ologo.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          // login Text
                          margin: const EdgeInsets.all(10),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              height: 1.2125,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        // email text field
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          width: 320,
                          height: 70,
                          child: TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xffffffff),
                              labelText: "Email",
                              prefixIcon: Icon(Icons.email),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email address.';
                              } else if (!RegExp(r'\S+@\S+\.\S+')
                                  .hasMatch(value)) {
                                return "Please enter a valid email address";
                              }
                              return null;
                            },
                          ),
                        ),

                        // Password Text Field

                        Container(
                          margin: const EdgeInsets.all(5.0),
                          width: 320,
                          height: 70,
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xffffffff),
                              prefixIcon: const Icon(Icons.lock),
                              labelText: 'Password',
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: _toggle,
                              ),
                            ),
                            obscureText: _obscureText,
                            onChanged: (value) {
                              setState(() {});
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password.';
                              } else if (!RegExp(
                                      r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)")
                                  .hasMatch(value)) {
                                return "Password should contain Capital, small letter & Number & Special";
                              }
                              return null;
                            },
                          ),
                        ),

                        //confirm password text field
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          width: 320,
                          height: 70,
                          child: TextFormField(
                            controller: confirmPasswordController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xffffffff),
                              prefixIcon: const Icon(Icons.lock),
                              labelText: 'Confirm Password',
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: _toggle2,
                              ),
                            ),
                            obscureText: _obscureConfirmPassword,
                            onChanged: (value) {
                              setState(() {});
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password.';
                              } else if (value != passwordController.text) {
                                return 'The confirm password does not match password.';
                              }
                              return null;
                            },
                          ),
                        ),

                        // user type dropdown menu
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          width: 320,
                          height: 65,
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xffffffff),
                              labelText: 'User Type',
                              prefixIcon: Icon(Icons.person),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                items: userTypes.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),

                        // Signup button

                        Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(14),
                          child: Center(
                            child: SizedBox(
                              width: 310,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xff26495c), // background
                                  foregroundColor: Colors.white, // foreground
                                ),
                                onPressed: () async {
                                  showDialog(context: context, builder: (context){
                                    return const Center(child: CircularProgressIndicator());
                                  },);
                                  FormState? formState = _formKey.currentState;
                                  if (_formKey.currentState!.validate() &&
                                      formState != null) {
                                    _formKey.currentState!.save();

                                    try {
                                      var user=User.empty();
                                      user.email= emailController.text.trim();
                                      user.password= passwordController.text.trim();
                                      user.role= dropdownValue;
                                      await auth.signup(
                                        user,
                                          context);

                                      Navigator.of(context).pop();
                                    } catch (e) {
                                    //  print("Error occur $e");
                                      // Handle the error, such as showing an error message to the user
                                    }
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: const [
                                    Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // if already have account navigate to login page
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: const Text(
                            'Already have an account ?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 1.2125,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              height: 1.2125,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ]))),
            )),
      ),
    );
  }
}
