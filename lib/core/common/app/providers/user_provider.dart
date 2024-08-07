import 'package:flutter/cupertino.dart';
import 'package:pacola_quiz/src/auth/data/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void initUser(UserModel? user) {
    if (_user != user) _user = user;
  }

  set user(UserModel? user) {
    if (_user != user) {
      _user = user;
      Future.delayed(Duration.zero, notifyListeners);
    }
  }
}
