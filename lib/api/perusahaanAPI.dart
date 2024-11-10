import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PerusahaanAPI {
  final String apiUrl = dotenv.env['API_URL'].toString();

  Future<bool> updateProfilePicture({
    required String idperusahaan,
    String? imagePath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      return false;
    }

    var request = http.MultipartRequest(
      'PATCH',
      Uri.parse('$apiUrl/perusahaan/updateProfilePict'),
    );

    request.headers['Authorization'] = 'Bearer $token';
    request.fields['idPerusahaan'] = idperusahaan.toString();

    if (imagePath != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'profile_pict',
        imagePath,
      ));
    }

    final response = await request.send();

    if (response.statusCode == 201) {
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

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
