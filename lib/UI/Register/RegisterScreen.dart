import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/FireBaseErrorCodes.dart';
import 'package:todo/Providers/AuthProvider.dart';
import 'package:todo/UI/DialogUtils.dart';
import 'package:todo/UI/common/CustomFormField.dart';
import 'package:todo/ValidationUtilities.dart';
import 'package:todo/database/UsersDao.dart';
import 'package:todo/database/model/User.dart' as MyUser;

import '../Login/LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullName = TextEditingController(text: 'abdoo');

  TextEditingController userName = TextEditingController(text: 'alaska');

  TextEditingController email = TextEditingController(text: 'abdooal@gmail.com');

  TextEditingController password = TextEditingController(text: '123456');

  TextEditingController passwordConfirmation = TextEditingController(text: '123456');

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          //color: Theme.of(context).colorScheme.primaryContainer,
            image: DecorationImage(
                image: AssetImage('assets/images/SIGN IN – 1.jpg'),
                fit: BoxFit.fill)),
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Create Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          body: Container(
            alignment: AlignmentDirectional.center,
            padding: EdgeInsets.all(12),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 150,),
                    CustomFormField(
                      hintText: 'Full Name',
                      keyboardType: TextInputType.name,
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return 'please enter full name';
                        }
                        return null;
                      },
                      controller: fullName,
                    ),
                    CustomFormField(
                      hintText: 'User Name',
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return 'please enter username';
                        }
                        return null;
                      },
                      controller: userName,
                    ),
                    CustomFormField(
                      hintText: 'E-Mail',
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter email';
                        }
                        if (!isValiedEmail(text)) {
                          return 'email not valied';
                        }
                        return null;
                      },
                      controller: email,
                    ),
                    CustomFormField(
                      hintText: 'Password',
                      keyboardType: TextInputType.visiblePassword,
                      secureText: true,
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return 'please enter password';
                        }
                        if (text.length < 6) {
                          return 'password should be at least 6 character';
                        }
                        return null;
                      },
                      controller: password,
                    ),
                    CustomFormField(
                      hintText: 'Password Confirmation',
                      keyboardType: TextInputType.visiblePassword,
                      secureText: true,
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return 'please enter password';
                        }
                        if (password.text != text) {
                          return "password dosen't match";
                        }
                        return null;
                      },
                      controller: passwordConfirmation,
                    ),
                    SizedBox(height: 100),
                    ElevatedButton(
                      onPressed: () {
                        createAccount();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              // color: Color(0xFFBDBDBD)
                            ),
                          ),
                          Icon(
                            Icons
                                .arrow_forward_rounded, //color: Color(0xFFBDBDBD)
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0.39,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void createAccount() async {
    if (formkey.currentState?.validate() == false) {
      return;
    }
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      DialogUtils.showLoading(context, 'Loading.....');
      authProvider.register(email.text, password.text, fullName.text, userName.text);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, 'Registered successfuly',posActionTitle: 'Ok',
      posAction: (){
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
      );
    }
    on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == FireBaseErrorCodes.weakPassword) {
        DialogUtils.showMessage(
            context,
            'The password provided is too weak.');
      } else if (e.code == FireBaseErrorCodes.emailAlreadyInUse) {
        DialogUtils.showMessage(
            context,'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}