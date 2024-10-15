class PostingPekerjaan {
  int idPostPekerjaan;
  int idPerusahaan;
  String posisi;
  String lokasi;
  String jobDetails;
  String requirements;
  String status; // 'tersedia' or 'berakhir'
  DateTime createdAt;

  PostingPekerjaan({
    required this.idPostPekerjaan,
    required this.idPerusahaan,
    required this.posisi,
    required this.lokasi,
    required this.jobDetails,
    required this.requirements,
    required this.status,
    required this.createdAt,
  });
}
