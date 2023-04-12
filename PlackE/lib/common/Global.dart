import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:placke/models/profile.dart';
import 'package:placke/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 *   author:zyu
 */
class Global{
  //持久化工具
  static late SharedPreferences _prefs;
  static Profile profile = Profile();
  //持久化
  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));

}
class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}
class UserModel extends ProfileChangeNotifier {
  // User get user => _profile.user!;
  //
  // // APP是否登录(如果有用户信息，则证明登录过)
  // bool get isLogin => user != null;
  //
  // //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  // set user(User user) {
  //   if (user!.login != _profile.user?.login) {
  //     _profile.lastLogin = _profile.user?.login;
  //     _profile.user = user;
  //     notifyListeners();
  //   }
  // }
}