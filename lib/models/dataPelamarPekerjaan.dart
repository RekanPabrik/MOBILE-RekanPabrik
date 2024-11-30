class pelamarPekerjaan {
  String namaPerusahaan;
  int idPelamar;
  String firstName;
  String lastName;
  String email;
  String? fotoProfil;
  String? linkCv;
  String statusLamaran;
  String posisiDilamar;

  pelamarPekerjaan({
    required this.namaPerusahaan,
    required this.idPelamar,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.fotoProfil,
    this.linkCv,
    required this.statusLamaran,
    required this.posisiDilamar,
  });
}
