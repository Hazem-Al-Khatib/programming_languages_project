// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class AuthService {
  // Replace this with your backend base URL
  static const String baseUrl = "http://10.0.2.2:8000/api";

  /// Register user
  static Future<Map<String, dynamic>> signup({
    required String firstName,
    required String lastName,
    required String phone,
    required String birthDate,
    required File idImage,
    required File personalImage,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/register");
      var request = http.MultipartRequest('POST', uri);
      request.headers['Accept'] = 'application/json';

      // Add text fields
      request.fields['first_name'] = firstName;
      request.fields['last_name'] = lastName;
      request.fields['phone'] = phone;
      request.fields['birth_date'] = birthDate;

      // Add images
      request.files.add(
        await http.MultipartFile.fromPath(
          'id_image',
          idImage.path,
          filename: basename(idImage.path),
        ),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          personalImage.path,
          filename: basename(personalImage.path),
        ),
      );

      // Send request
      var response = await request.send();
      var resBody = await response.stream.bytesToString();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(resBody);
      } else {
        return {"success": false, "message": "Server error", "raw": resBody};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// Login user using username (first name) + phone
  static Future<Map<String, dynamic>> login({
    required String username,
    required String phone,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/login");
      var response = await http.post(
        uri,
        headers: {'Accept': 'application/json'},
        body: {'username': username, 'phone': phone},
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// Logout user (requires token)
  static Future<Map<String, dynamic>> logout(String token) async {
    try {
      var uri = Uri.parse("$baseUrl/logout");
      var response = await http.post(
        uri,
        headers: {'Authorization': 'Bearer $token'},
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
