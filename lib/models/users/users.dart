import 'package:rekanpabrik/models/users/pelamar.dart';
import 'package:rekanpabrik/models/users/perusahaan.dart';

class User {
  int id;
  String email;
  String role; // 'pelamar', 'admin', atau 'perusahaan'
  String firstName;
  String lastName;
  String? aboutMe;
  String? profilePict; // Firebase link
  String token;

  User({
    required this.id,
    required this.email,
    required this.role,
    required this.firstName,
    required this.lastName,
    this.aboutMe,
    this.profilePict,
    required this.token,
  });

  factory User.fromPelamar(Pelamar pelamar, String token) {
    return User(
      id: pelamar.idPelamar,
      email: pelamar.email,
      role: pelamar.role,
      firstName: pelamar.firstName,
      lastName: pelamar.lastName,
      aboutMe: pelamar.aboutMe,
      profilePict: pelamar.profilePict,
      token: token,
    );
  }

  factory User.fromPerusahaan(Perusahaan perusahaan, String token) {
    return User(
      id: perusahaan.idPerusahaan,
      email: perusahaan.email,
      role: perusahaan.role,
      firstName: perusahaan
          .namaPerusahaan, // Misalkan namaPerusahaan sebagai firstName
      lastName: '', // Kosongkan jika tidak ada
      aboutMe: perusahaan.aboutMe,
      profilePict: perusahaan.profilePict,
      token: token,
    );
  }
}
