import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Pelamar {
  int idPelamar;
  String email;
  String password;
  String role; // 'pelamar'
  String firstName;
  String lastName;
  String? aboutMe;
  String? curriculumVitae; // Firebase link
  DateTime? dateBirth;
  String? profilePict; // Firebase link

  Pelamar({
    required this.idPelamar,
    required this.email,
    required this.password,
    required this.role,
    required this.firstName,
    required this.lastName,
    this.aboutMe,
    this.curriculumVitae,
    this.dateBirth,
    this.profilePict,
  });

  factory Pelamar.fromJson(Map<String, dynamic> json) {
    return Pelamar(
      idPelamar: json['id_pelamar'], // Menggunakan key yang benar
      email: json['email'],
      password: json['password'],
      role: json['role'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      aboutMe: json['about_me'],
      curriculumVitae: json['curriculum_vitae'],
      dateBirth: DateTime.parse(json['date_birth']),
      profilePict: json['profile_pict'],
    );
  }
}

class PelamarService {
  final String apiUrl = dotenv.env['API_URL'] ?? 'http://localhost:4000';
  Future<List<Pelamar>> getAllPelamar() async {
    try {
      final response = await http.get(
        Uri.parse('${dotenv.env['API_URL']}/pelamar/getAllPelamar'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> pelamarJsonList =
            jsonResponse['data']; // Ambil list pelamar
        return pelamarJsonList
            .map((pelamarJson) => Pelamar.fromJson(pelamarJson))
            .toList();
      } else {
        throw Exception('Failed to load pelamar');
      }
    } catch (e) {
      print('Error: $e'); // Cetak error untuk debugging
      return [];
    }
  }
}
