import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/ui/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  late LoginNavigator navigator;
  void loginFireBaseAuth(String email, String password) async {
    try {
      //show loading
      navigator.showLoading();
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // hide loading
      navigator.hideLoading();
      //show message
      navigator.showMessage('login successfully');
      // retrieve data
      var userObj = await DatabaseUtils.getUser(result.user?.uid ?? '');
      if (userObj == null) {
        navigator.hideLoading();
        navigator.showMessage('Register failed please try again');
      } else {
        navigator.navigateToHome(userObj);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //hide loading
        navigator.hideLoading();
        //show message
        navigator.showMessage('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        //hide loading
        navigator.hideLoading();
        //show message
        navigator.showMessage('Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }
  }
}
