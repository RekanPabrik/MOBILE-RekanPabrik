import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SavedJobsApi {
  final String apiUrl = dotenv.env['API_URL'].toString();

  Future<List<Map<String, dynamic>>> getSavedJobsByIDPelamar(
      int idpelamar) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse('$apiUrl/saveJobs/getSavedJobs/$idpelamar'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> postings = data['data'];

      return postings.map((post) => Map<String, dynamic>.from(post)).toList();
    } else {
      throw Exception('Gagal mengambil data postingan pekerjaan');
    }
  }

  Future<bool> savedJobs(int idpostpekerjaan, int idpelamar) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      return false;
    }

    var url = Uri.parse('$apiUrl/saveJobs/addJobs');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
            {"idPelamar": idpelamar, "idPostPekerjaan": idpostpekerjaan}));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
