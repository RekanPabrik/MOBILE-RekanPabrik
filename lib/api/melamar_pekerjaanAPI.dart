import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MelamarPekerjaanapi {
  final String apiUrl = dotenv.env['API_URL'].toString();

  Future<List<Map<String, dynamic>>> gethistoryLamaran(int idpelamar) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      throw Exception("Terjadi kesalahan:");
    }

    final url = Uri.parse(
        '$apiUrl/melamarPekerjaan/getDataMelamarPekarjaan/$idpelamar');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        if (jsonResponse['data'] != null) {
          return List<Map<String, dynamic>>.from(jsonResponse['data']);
        } else {
          throw Exception("Tidak ada data riwayat.");
        }
      } else {
        throw Exception(
            "Gagal mengambil data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan: $e");
    }
  }
}
