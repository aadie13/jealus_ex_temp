import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//*******************************//
import 'package:jealus_ex/controllers/auth_controller.dart';
import 'package:jealus_ex/controllers/user_profile_controller.dart';
import 'package:jealus_ex/repositories/auth_repository.dart';
import 'package:jealus_ex/general_providers.dart';

import '../custom_exception.dart';

class Register extends HookWidget {
  @override
  Widget build(BuildContext context) {
    //final user = context.read(authControllerProvider);
    final authControllerState = useProvider(firebaseAuthProvider).currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: EmailRegisterForm(),
    );
  }
}

Widget buildLoading() => Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    );

class EmailRegisterForm extends HookWidget {
  //const emailRegisterForm({Key? key}) : super(key: key);

  //TODO:add profile photo
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //final userControllerState = useProvider(authControllerProvider).state;
    return Scaffold(
        appBar: AppBar(
          title: new Text(
            'Create your profile',
            style: TextStyle(fontSize: 25.0),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(children: [
              SizedBox(
                height: 20.0,
              ),
              Image(
                image: AssetImage("images/logo.png"),
                width: 390.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 1.0,
              ),
              Text(
                "SignUp as Customer",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Enter Name",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    TextField(
                      controller: phoneTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone",
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      color: Colors.yellow,
                      textColor: Colors.white,
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                                fontSize: 28.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                      onPressed: () async {
                        if (!emailTextEditingController.text.contains("@")) {
                          Fluttertoast.showToast(msg: "Invalid email");
                        } else if (passwordTextEditingController.text.length <
                            6) {
                          Fluttertoast.showToast(
                              msg:
                                  "Password must be atleast 7 characters long");
                        } else if (nameTextEditingController.text.length < 3) {
                          Fluttertoast.showToast(
                              msg: "name must be at least 3 characters");
                        } else if (phoneTextEditingController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "Enter Phone number");
                        } else {
                          await context
                              .read(authRepositoryProvider)
                              .registerNewUser(emailTextEditingController.text,
                                  passwordTextEditingController.text)
                              .then((value) async {
                            var user =
                                context.read(authControllerProvider.state);
                            if (user != null) {
                              await context
                                  .read(userControllerProvider)
                                  .addUserProfile(
                                    name: nameTextEditingController.text,
                                    phone: phoneTextEditingController.text,
                                  ); //TODO add birthday? and phone authentication
                              print(user);
                              print(user.uid);
                              print("Account Created");
                              Fluttertoast.showToast(msg: "Account created!");
                              Navigator.of(context).pushReplacementNamed(
                                  '/addVehiclesToProfile');
                            } else {
                              print("Account Not Created");
                              Fluttertoast.showToast(
                                  msg: "Account Not created! User == null");
                            }
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}
