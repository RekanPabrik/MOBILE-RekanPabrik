import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mime/mime.dart';

class PerusahaanAPI {
  final String apiUrl = dotenv.env['API_URL'].toString();

  Future<bool> updateProfilePicture({
    required int idperusahaan,
    required File imagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      return false;
    }

    var request = http.MultipartRequest(
      'PATCH',
      Uri.parse('$apiUrl/perusahaan/updateProfilePict/$idperusahaan'),
    );

    request.headers['Authorization'] = 'Bearer $token';

    if (await imagePath.exists()) {
      final mimeType = lookupMimeType(imagePath.path);
      request.files.add(await http.MultipartFile.fromPath(
          'profile_pict', imagePath.path,
          contentType: MediaType.parse(mimeType ?? 'image/png')));
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

  Future<bool> updateProfileData({
    required int idperusahaan,
    required String email,
    required String namaPerusahaan,
    required String tentangPerusahaan,
    required String alamatPerusahaan,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      return false;
    }

    var url = Uri.parse('$apiUrl/perusahaan/updateDataPerusahaan');

    final response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'idPerusahaan': idperusahaan,
          'email': email,
          'nama_perusahaan': namaPerusahaan,
          'aboutMe': tentangPerusahaan,
          'alamat': alamatPerusahaan,
        }));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> changePassword(
      {required int idperusahaan, required String newPassword}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      return false;
    }

    var url = Uri.parse('$apiUrl/perusahaan/changePassword/$idperusahaan');

    final response = await http.patch(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'newPass': newPassword,
        }));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
