import 'package:flutter/material.dart';
import 'login.dart';
import 'share.dart';
import 'alert.dart';

AppBar buildAppbar(BuildContext context,String title) {
  var loggedIn = Share.isLoggedIn;

  // ignore: prefer_function_declarations_over_variables
  Function login = () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage()),
    ).then((value) {
      if (value != null && value is bool) {
      
        Share.updateState(
          Share.isLoggedIn
        );
      }
    });
  };

  // ignore: prefer_function_declarations_over_variables
  Function logout = () {
      Share.updateState(false);
      Navigator.of(context).popUntil(
        (route) => route.isFirst,
      );
  };
  
  return AppBar(
    title: Text(title),
    actions: [
      (!loggedIn) ? IconButton(
        icon: const Icon(Icons.login, size: 30.0),
        onPressed: login(),
      ) 
      : IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () {
          alert(
            context,
            title: '',
            content: 'Are you sure you want to logout?',
            okAction: logout(),
            showCancel: true,
          );
        },
      ),
    ],
  );
}