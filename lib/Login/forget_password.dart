import 'package:flutter/material.dart';
import '../Functions/auth.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({Key? key}) : super(key: key);

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Auth auth = Auth();



  @override
  Widget build(BuildContext context) {
    return Form(
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
                        //image
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

                        // login Text
                        Container(

                          margin: const EdgeInsets.all(10),
                          child: const Text(
                            'Forget Password',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              height: 1.2125,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                        //user instructions
                        Container(
                          padding: const EdgeInsets.all(30),
                          margin: const EdgeInsets.all(10),
                            child: const Text(
                              textAlign: TextAlign.center,
                              'Enter an Email associated with your account,'
                                  ' We will send you a link to reset password',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                height: 1.2125,
                                color: Colors.grey,
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
                                borderSide: BorderSide(width: 1, color: Colors.black),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email address.';
                              } else if (!value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                          ),
                        ),

                        // Elevated button reset password
                        Container(
                          margin: const EdgeInsets.only(bottom: 20.0),
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
                                onPressed: () {
                                  showDialog(context: context, builder: (context){
                                    return const Center(child: CircularProgressIndicator());
                                  },);
                                  FormState? formState = _formKey.currentState;
                                  if (formState != null && formState.validate()) {
                                    auth.sendPasswordResetEmail(emailController.text.trim());
                                  }

                                  // Do something with the form data
                                },
                                child: const Text(
                                  'Reset Password',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ),

                      ]))),
        ));
  }
}
