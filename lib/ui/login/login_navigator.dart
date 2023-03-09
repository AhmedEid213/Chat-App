import 'package:chat_app/model/my_user.dart';

abstract class LoginNavigator{
  void showLoading();
  void hideLoading();
  void showMessage(String message);
  void navigateToHome(MyUser user);
}