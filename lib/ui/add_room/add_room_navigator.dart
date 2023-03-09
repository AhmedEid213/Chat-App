import 'package:chat_app/model/room.dart';

abstract class AddRoomNavigatort{
  void showLoading();
  void hideLoading();
  void showMessage(String message);
  void navigateToHome(Room room);
}