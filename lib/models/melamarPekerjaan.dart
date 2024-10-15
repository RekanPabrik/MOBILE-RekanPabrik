class MelamarPekerjaan {
  int idLamaranPekerjaan;
  int idPostPekerjaan;
  // int idPelamar;
  String status;
  DateTime createdAt;

  MelamarPekerjaan({
    required this.idLamaranPekerjaan,
    required this.idPostPekerjaan,
    // required this.idPelamar,
    required this.status,
    required this.createdAt,
  });
}
