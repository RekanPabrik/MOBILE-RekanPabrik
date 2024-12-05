class MelamarPekerjaan {
  String namaPerusahaan;
  String posisi;
  String statusLamaran;
  DateTime createdAt;
  int idLamaranpPekerjaan;
  String namaDepanPelamar;
  String namaBelakangPelamar;

  MelamarPekerjaan({
    required this.namaPerusahaan,
    required this.posisi,
    required this.statusLamaran,
    required this.createdAt,
    required this.idLamaranpPekerjaan,
    required this.namaDepanPelamar,
    required this.namaBelakangPelamar,
  });

  factory MelamarPekerjaan.fromJson(Map<String, dynamic> json) {
    return MelamarPekerjaan(
      namaPerusahaan: json['nama_perusahaan'],
      posisi: json['posisi'],
      statusLamaran: json['status_lamaran'],
      createdAt: DateTime.parse(json['createdAt']),
      idLamaranpPekerjaan: json['id_lamaran_pekerjaan'],
      namaDepanPelamar: json['nama_depan_pelamar'],
      namaBelakangPelamar: json['nama_belakang_pelamar'],
    );
  }
}
