import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/FireBaseErrorCodes.dart';
import 'package:todo/UI/DialogUtils.dart';
import 'package:todo/UI/Register/RegisterScreen.dart';
import 'package:todo/UI/common/CustomFormField.dart';
import 'package:todo/ValidationUtilities.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

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
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Login',
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
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter password';
                        }
                        if (text.length < 6) {
                          return 'password should be at least 6 character';
                        }
                        return null;
                      },
                      controller: password,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xFFF9F9F9),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          Icon(Icons.arrow_forward_rounded,
                              color: Color(0xFFF9F9F9)),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3598DB),
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        },
                        child: Text(
                          'Or Create New Account',
                          style: TextStyle(
                            //color: Color(0xFF505050),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            height: 0,
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void login() async{
    if (formkey.currentState?.validate() == false) {
      return;
    }
    try {
      DialogUtils.showLoading(context, 'Loading....',isCancelable: false);
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text,
          password: password.text
      );
      DialogUtils.hideDialog(context);
      print(result.user?.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == FireBaseErrorCodes.userNotFound) {
        print('No user found for that email.');
      } else if (e.code == FireBaseErrorCodes.wrongPassword) {
        print('Wrong password provided for that user.');
      }
    }
  }
}
