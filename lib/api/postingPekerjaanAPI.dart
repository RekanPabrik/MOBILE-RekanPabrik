import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Postingpekerjaanapi {
  final String apiUrl = dotenv.env['API_URL'].toString();

  Future<List<Map<String, dynamic>>> getPostPekerjaan(int idPerusahaan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse('$apiUrl/postPekerjaan/getPost/$idPerusahaan'),
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

  Future<List<Map<String, dynamic>>> detailsJob(int idPostingan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse('$apiUrl/postPekerjaan/detailPost/$idPostingan'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> jobs = data['data'];

      return jobs.map((job) => Map<String, dynamic>.from(job)).toList();
    } else {
      throw Exception('Gagal mengambil data postingan pekerjaan');
    }
  }
}
