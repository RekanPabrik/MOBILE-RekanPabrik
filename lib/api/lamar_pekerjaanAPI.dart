import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LamarPekerjaanapi {
  final String apiUrl = dotenv.env['API_URL'].toString();

  Future<bool> lamarPekerjaan(int idPostPekerjaan, int idpelamar) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      return false;
    }

    var url = Uri.parse('$apiUrl/melamarPekerjaan/melamar');

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
            {"idPostPekerjaan": idPostPekerjaan, "idPelamar": idpelamar}));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
