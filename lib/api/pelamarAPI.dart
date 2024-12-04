import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mime/mime.dart';

class Pelamarapi {
  final String apiUrl = dotenv.env['API_URL'].toString();

  Future<bool> updateDataPelamar({
    required int idpelamar,
    required String firstname,
    required String lastname,
    required String email,
    required String aboutme,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      return false;
    }

    var url = Uri.parse('$apiUrl/pelamar//updateDataPelamar/$idpelamar');

    final response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'first_name': firstname,
          'last_name': lastname,
          'email': email,
          'aboutMe': aboutme,
        }));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProfilePicture({
    required int idpelamar,
    required File imagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      return false;
    }

    var request = http.MultipartRequest(
      'PATCH',
      Uri.parse('$apiUrl/pelamar/updateProfilePelamar/$idpelamar'),
    );

    request.headers['Authorization'] = 'Bearer $token';

    if (await imagePath.exists()) {
      final mimeType = lookupMimeType(imagePath.path);
      print(mimeType);
      request.files.add(await http.MultipartFile.fromPath(
          'profile_pict', imagePath.path,
          contentType: MediaType.parse(mimeType ?? 'image/*')));
    } else {
      return false;
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
