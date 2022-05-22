import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiAccessor {
  static Future<String> verifyLogin(String email, String password) async {
    Uri url = Uri.http("10.0.2.2:4000", "/api/login");

    http.Response response = await http.post(url,
        headers: {"Content-type": "application/json"},
        body: "{\"email\": \"$email\", \"password\": \"$password\"}");

    print(response.body);
    dynamic res = const JsonDecoder().convert(response.body);
    if (res["status"] == "Login success") {
      return "Success";
    } else {
      return "Wrong credentials";
    }
  }
}
