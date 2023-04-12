import 'package:flutter/cupertino.dart';
import 'package:flutter_login/flutter_login.dart';
const users = const {
  'zyu': '12345',
};
class classfy{
  Duration get loginTime => Duration(milliseconds: 1000);
  String? usernameValidator(String? data){
    return null;
  }
  Future<String?> authUser(LoginData data) async{
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }
  Future<String?> signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }
  Future<String> recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return 'ok';
    });
  }
}