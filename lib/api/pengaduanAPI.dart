import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Pengaduanapi {
  final String apiUrl = dotenv.env['API_URL'].toString();

  Future<bool> kirimPengaduan(String firstName, String lastName, String email,
      String phone, String message) async {
    var url = Uri.parse('$apiUrl/pengaduan/addPengaduan');

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "nomor_telpon": phone,
          "pesan": message
        }));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
