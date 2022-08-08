import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  late String _token;
  late DateTime _expiryDate;
  late String _userId;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBnmUA24cP4V8uBbcq1nqEnEQYiMMA1Rlk');
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body);
      if (responseData['errors'] != null) {
        throw HttpException(responseData['errors']['message']);
      }
      print(json.decode(response.body));
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');

    // final url = Uri.parse(
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBnmUA24cP4V8uBbcq1nqEnEQYiMMA1Rlk');
    // final response = await http.post(url,
    //     body: json.encode(
    //         {'email': email, 'password': password, 'returnSecureToken': true}));
    // print(json.decode(response.body));
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');

    // final url = Uri.parse(
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBnmUA24cP4V8uBbcq1nqEnEQYiMMA1Rlk');
    // final response = await http.post(url,
    //     body: json.encode(
    //         {'email': email, 'password': password, 'returnSecureToken': true}));
  }
}
