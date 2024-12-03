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

  Future<bool> postingPekerjaann(int idPerusahaan, String posisi, String lokasi,
      String jobDetails, String requirements) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      return false;
    }

    var url = Uri.parse('$apiUrl/postPekerjaan/newPostPekerjaan');

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'idPerusahaan': idPerusahaan,
          'posisi': posisi,
          'lokasi': lokasi,
          'jobDetails': jobDetails,
          'requirements': requirements,
        }));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> ubahStatusPekerjaann(int idPostPekerjaan) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    const status = "ditutup";

    if (token == null) {
      return false;
    }

    var url = Uri.parse(
        '$apiUrl/postPekerjaan//updateStatusPostingan/$idPostPekerjaan');

    final response = await http.patch(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'idPerusahaan': idPostPekerjaan,
          'status': status,
        }));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getPelamarByCompanyId(
      int idPerusahaan) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    const status = "ditutup";

    if (token == null) {
      throw Exception("Terjadi kesalahan:");
    }

    final url = Uri.parse('$apiUrl/perusahaan/$idPerusahaan/cekPelamar');
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
          throw Exception("Tidak ada data pelamar.");
        }
      } else {
        throw Exception(
            "Gagal mengambil data. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan: $e");
    }
  }

  Future<Map<String, dynamic>> getDetailPelamar(int idPelamar) async {
    try {
      final url =
          Uri.parse('$apiUrl/postPekerjaan/getDetailPelamar/$idPelamar');

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null && data['data'].isNotEmpty) {
          var pelamar = data['data'][0];

          print('Data Pelamar: $pelamar');

          return pelamar;
        } else {
          throw Exception('Data pelamar tidak ditemukan.');
        }
      } else {
        throw Exception(
            'Gagal memuat data pelamar. Status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllPostPekerjaan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    final response = await http.get(
      Uri.parse('$apiUrl/postPekerjaan/getPostAllPostingan'),
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
}
