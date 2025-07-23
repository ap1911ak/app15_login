import 'package:flutter/material.dart';
import 'appbar.dart';
import 'share.dart';
import 'alert.dart';
import 'api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final  _ctrlLogin = TextEditingController();
  final  _ctrlPswd = TextEditingController();
  var _apiCalling = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (!Share.isLoggedIn) 
        ? buildAppbar(context, 'Login') 
        : AppBar(title: const Text('Login')),
      body: Container(
        padding: EdgeInsets.only(
          left: 20.0, 
          right: 20.0, 
          top: 20.0, 
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.0,
        ),
        alignment: Alignment.topCenter,

        child: (!Share.isLoggedIn) 
          ? columnLogin()
          : Text('Yor are already logged in',textScaler: TextScaler.linear(1.7),),
            
          ) 

      );
  }

  Widget columnLogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        textFieldLogin(),
        const SizedBox(height: 20.0),
        textFieldPassword(),
        const SizedBox(height: 20.0),
        btnOK(),
        const SizedBox(height: 30.0),
        Text(
          'Login to continue',
          textScaler: TextScaler.linear(1.5),
          style: TextStyle(color: Colors.grey,
            fontStyle: FontStyle.italic,),
        ),
      ],
    );
  }
  OutlineInputBorder ontlineBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
        color: Colors.grey,
        width: 2.0,
      ),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(
      color: Colors.indigo,
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
    );
  }

  Widget textFieldLogin() {
    return TextField(
      controller: _ctrlLogin,
      decoration: const InputDecoration(
        labelText: 'Login',
        hintText: 'Enter your login',
      ),
      style: textStyle(),
    );
  }
  Widget textFieldPassword() {
    return TextField(
      controller: _ctrlPswd,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
      ),
      style: textStyle(),
    );
  }
  Widget btnOK() {
    return ElevatedButton(
      onPressed: _apiCalling ? null : () => btnOK_pressed(),
      child: (_apiCalling) 
        ? const CircularProgressIndicator() 
        : const Text('Login', textScaler: TextScaler.linear(1.7)),
    );
  }


  // ignore: non_constant_identifier_names
  void btnOK_pressed() {
    setState(()=> _apiCalling = true );
    late Future<Map<String, dynamic>> futureLogin;
    futureLogin = apiLogin(
      _ctrlLogin.text, 
      _ctrlPswd.text,
    );

    futureLogin.then((value) {
      setState(() {
        if(value['result'] == true){
          Share.isLoggedIn = true;
          Share.updateState(Share.isLoggedIn);
          // Navigator.of(context).pop(true);
        } else {
          Share.isLoggedIn = false;
          Share.updateState(Share.isLoggedIn);
          alert(
            context,
            title: 'Login Failed',
            content: 'Username or password is incorrect.',
            okAction: () {
              Navigator.of(context).pop();
              _ctrlLogin.clear();
              _ctrlPswd.clear();
            },
            showCancel: false,
          );
        }
        _apiCalling = false;
      });
    });
  }
}