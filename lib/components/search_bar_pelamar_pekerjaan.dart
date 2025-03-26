import 'package:flutter/material.dart';
import 'package:rekanpabrik/api/meAPI.dart';
import 'package:rekanpabrik/api/posting_pekerjaan_API.dart';
import 'package:rekanpabrik/models/dataPelamarPekerjaan.dart';
import 'package:rekanpabrik/pages/HRD/detailPelamar.dart';
import 'package:rekanpabrik/pages/page.dart';
import 'package:rekanpabrik/shared/shared.dart';

class SearchBarPelamarPekerjaan extends StatefulWidget {
  const SearchBarPelamarPekerjaan({Key? key}) : super(key: key);

  @override
  _SearchBarPelamarPekerjaanState createState() =>
      _SearchBarPelamarPekerjaanState();
}

class _SearchBarPelamarPekerjaanState extends State<SearchBarPelamarPekerjaan> {
  String query = '';
  List<pelamarPekerjaan> dataDitampilkan = [];
  List<Map<String, dynamic>> resultsPelamar = [];
  dynamic user;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      var response = await meAPI().getUserProfile();

      if (response['status'] == true && response['data'] != null) {
        if (!mounted) return;
        setState(() {
          user = response['data'];
        });

        await _fetchPelamar();
      } else {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _errorMessage = 'Anda Tidak Login';
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Terjadi kesalahan: ${e.toString()}';
      });
    }
  }

  Future<void> _fetchPelamar() async {
    try {
      int? companyId;
      if (user is List && user.isNotEmpty && user[0][0].isNotEmpty) {
        companyId = user[0][0]['id_perusahaan'];
      }

      if (companyId == null) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'ID Perusahaan tidak ditemukan';
        });
        return;
      }

      var data = await Postingpekerjaanapi().getPelamarByCompanyId(companyId);

      setState(() {
        _isLoading = false;
        if (data != null && data.isNotEmpty) {
          resultsPelamar = data;
          dataDitampilkan = resultsPelamar.take(5).map((user) {
            return pelamarPekerjaan(
              namaPerusahaan: user['nama_perusahaan'].toString(),
              idPelamar: user['id_pelamar'],
              firstName: user['first_name'].toString(),
              lastName: user['last_name'].toString(),
              email: user['email'].toString(),
              linkCv: user['link_cv'].toString(),
              fotoProfil: user['foto_profil'].toString(),
              statusLamaran: user['status_lamaran'].toString(),
              posisiDilamar: user['posisi_dilamar'].toString(),
            );
          }).toList();
        } else {
          _errorMessage = 'Anda belum mendapatkan pelamar';
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage =
            'Terjadi kesalahan saat mengambil data: ${e.toString()}';
      });
    }
  }

  Color statusColors(String status) {
    switch (status) {
      case "diproses":
        return Colors.grey;
      case "ditolak":
        return dangerColor;
      case "diterima":
        return succesColor;
      default:
        return primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
          child: CircularProgressIndicator(
        color: thirdColor,
      ));
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Text(
          _errorMessage,
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            onChanged: (value) {
              setState(() {
                query = value;
                dataDitampilkan = cariDataPelamar(value);
              });
            },
            decoration: InputDecoration(
              hintText: "Search here...",
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.search, color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: thirdColor),
              ),
            ),
          ),
        ),
        resultsPelamar.isEmpty
            ? Center(
                child: Text(
                  'Pelamar Not Found',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: dataDitampilkan.map((pelamar) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: ListTile(
                        title: Text('${pelamar.firstName} ${pelamar.lastName}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pelamar.posisiDilamar),
                            SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColors(pelamar.statusLamaran),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                pelamar.statusLamaran,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detailpelamar(
                                    idPelamar: pelamar.idPelamar)),
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
      ],
    );
  }

  List<pelamarPekerjaan> cariDataPelamar(String query) {
    if (query.isEmpty) {
      return resultsPelamar.take(5).map((user) {
        return pelamarPekerjaan(
          namaPerusahaan: user['nama_perusahaan'].toString(),
          idPelamar: user['id_pelamar'],
          firstName: user['first_name'].toString(),
          lastName: user['last_name'].toString(),
          email: user['email'].toString(),
          linkCv: user['link_cv'].toString(),
          fotoProfil: user['foto_profil'].toString(),
          statusLamaran: user['status_lamaran'].toString(),
          posisiDilamar: user['posisi_dilamar'].toString(),
        );
      }).toList();
    }

    return resultsPelamar.where((user) {
      var nama = user['first_name'] ?? '';
      return nama.toLowerCase().contains(query.toLowerCase());
    }).map((user) {
      return pelamarPekerjaan(
        namaPerusahaan: user['nama_perusahaan'].toString(),
        idPelamar: user['id_pelamar'],
        firstName: user['first_name'].toString(),
        lastName: user['last_name'].toString(),
        email: user['email'].toString(),
        linkCv: user['link_cv'].toString(),
        fotoProfil: user['foto_profil'].toString(),
        statusLamaran: user['status_lamaran'].toString(),
        posisiDilamar: user['posisi_dilamar'].toString(),
      );
    }).toList();
  }
}
