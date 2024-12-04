// class MelamarPekerjaan {
//   int idLamaranPekerjaan;
//   int idPostPekerjaan;
//   // int idPelamar;
//   String status;
//   DateTime createdAt;

//   MelamarPekerjaan({
//     required this.idLamaranPekerjaan,
//     required this.idPostPekerjaan,
//     // required this.idPelamar,
//     required this.status,
//     required this.createdAt,
//   });
// }

class MelamarPekerjaan {
  String namaPerusahaan;
  String posisi;
  String statusLamaran;
  int idLamaranpPekerjaan;
  String namaDepanPelamar;
  String namaBelakangPelamar;

  MelamarPekerjaan({
    required this.namaPerusahaan,
    required this.posisi,
    required this.statusLamaran,
    required this.idLamaranpPekerjaan,
    required this.namaDepanPelamar,
    required this.namaBelakangPelamar,
  });

  factory MelamarPekerjaan.fromJson(Map<String, dynamic> json) {
    return MelamarPekerjaan(
      namaPerusahaan: json['nama_perusahaan'],
      posisi: json['posisi'],
      statusLamaran: json['status_lamaran'],
      idLamaranpPekerjaan: json['id_lamaran_pekerjaan'],
      namaDepanPelamar: json['nama_depan_pelamar'],
      namaBelakangPelamar: json['nama_belakang_pelamar'],
    );
  }
}
