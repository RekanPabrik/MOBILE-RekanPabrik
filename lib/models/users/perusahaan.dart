class Perusahaan {
  int idPerusahaan;
  String email;
  String password;
  String role; // 'perusahaan'
  String namaPerusahaan;
  String? aboutMe;
  String? profilePict; // Firebase link
  String? alamat;

  Perusahaan({
    required this.idPerusahaan,
    required this.email,
    required this.password,
    required this.role,
    required this.namaPerusahaan,
    this.aboutMe,
    this.profilePict,
    this.alamat,
  });
}
