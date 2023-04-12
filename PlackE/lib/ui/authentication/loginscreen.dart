import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:placke/common/Global.dart';
import 'package:placke/index.dart';
import 'package:placke/ui/authentication/auth.dart';
import 'dart:async';

import '../homepage/homepage.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    classfy test=new classfy();
    return FlutterLogin(
      title: 'Plack',
      userType: LoginUserType.name,
      onLogin: test.authUser,
      onSignup: test.signupUser,
      userValidator: test.usernameValidator,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
      },
      onRecoverPassword: test.recoverPassword,
      messages: LoginMessages(
        userHint: '用户名',
        passwordHint: 'Pass',
        confirmPasswordHint: 'Confirm',
        loginButton: 'LOG IN',
        signupButton: 'REGISTER',
        forgotPasswordButton: 'Forgot huh?',
        recoverPasswordButton: 'HELP ME',
        goBackButton: 'GO BACK',
        confirmPasswordError: 'Not match!',
        recoverPasswordDescription:
        'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        recoverPasswordSuccess: 'Password rescued successfully',
      ),
    );
  }

}

