import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class API {

  String? fact;
  String? url;

  API();

  Future<void> getAge() async {
    try {
      //Setting up the api URL
      String apiurl = 'https://catfact.ninja/fact?max_length=140';
      url = apiurl;
      final Uri url2 = Uri.parse(apiurl);
      Response response = await get(url2);
      Map data = jsonDecode(response.body);

      //get properties from data
      fact = data['fact'];
    }

    catch (e) {
      print('caught error: $e');
    }

  }

}