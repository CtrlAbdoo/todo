import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/database/UsersDao.dart';
import 'package:todo/database/model/User.dart' as MyUser;

class AuthProvider extends ChangeNotifier {
  MyUser.User? databaseUser;
  User? firebaseAuthUser;

  Future<void> register(
      var email,
      var password,
      var fullName,
      var userName
      ) async {
    var result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    await UsersDao.creatUser(MyUser.User(
        id: result.user?.uid,
        fullName: fullName,
        userName: userName,
        email: email));
  }
  Future<void> login(var email, var password)async{
    final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password);
    var user = await UsersDao.getUser(result.user!.uid);
    databaseUser = user;
    firebaseAuthUser = result.user;
  }

  void logout() {
    databaseUser = null;
    FirebaseAuth.instance.signOut();
  }
  Future<void> checkAuthenticationStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      firebaseAuthUser = user;
    } else {
      firebaseAuthUser = null; // Set to null when not authenticated
    }
    notifyListeners();
  }

}
