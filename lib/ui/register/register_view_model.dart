import 'package:chat_app/database/database_utils.dart';
import 'package:chat_app/model/my_user.dart';
import 'package:chat_app/ui/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//provider
class RegisterViewModle extends ChangeNotifier{
 late RegisterNavigator navigator;
 //logic
  void registerFireBaseAuth(String email , String password,String firstName, String lastName,String userName)async{
    //show loading
    navigator.showLoading();
    try {
      final result =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //save data
      var user =MyUser(
          id: result.user?.uid ?? '',
          firstName: firstName,
          lastName: lastName,
          userName: userName,
          email: email);
      var dataUser = await DatabaseUtils.registerUser(user);
      //hide loading
      navigator.hideLoading();
      //show message
      navigator.showMessage('Register Successfully');
      navigator.navigateToHome(user);
      print('FireBase user id: ${result.user!.uid}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        //hide loading
        navigator.hideLoading();
        //show message
        navigator.showMessage('The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        //hide loading
        navigator.hideLoading();
        //show message
        navigator.showMessage('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      //hide loading
      navigator.hideLoading();
      //show message
      navigator.showMessage('Somthing went wrong ');
      print(e);
    }
}

}