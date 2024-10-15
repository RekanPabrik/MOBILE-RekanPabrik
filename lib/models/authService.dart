import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final String apiUrl = dotenv.env['API_URL'] ?? 'http://localhost:4000';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$apiUrl/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          //'token', tokenapi,
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse; // Make sure to return the response here
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return {
          'status': false,
          'message': 'Login failed',
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': 'Error: $e',
      };
    }
  }
}
