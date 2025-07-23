import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic >> apiLogin(
  String login,
  String pswd) async {
    var response = await http.post(
      Uri.parse('https://developerthai.com/flutter/login.php'),
      headers:<String, String> {
        'Content-Type': 'application/json'},
      body: jsonEncode(<String, String> {
        'login': login,
        'pswd': pswd,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to login');
    }
  }