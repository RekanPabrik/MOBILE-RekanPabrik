import 'package:flutter/material.dart';
import 'package:rekanpabrik/models/melamarPekerjaan.dart';
import 'package:rekanpabrik/models/postingPekerjaan.dart';
import 'package:rekanpabrik/pages/page.dart';
import 'package:rekanpabrik/shared/shared.dart';
import 'package:rekanpabrik/utils/dummyMelamarPekerjaan.dart';
import 'package:rekanpabrik/utils/dummyPerusahaan.dart';
import 'package:rekanpabrik/utils/dummyPostinganPekerjaan.dart';

class searchBarRiwayatLamaran extends StatefulWidget {
  const searchBarRiwayatLamaran({super.key});

  @override
  _searchBarRiwayatLamaran createState() => _searchBarRiwayatLamaran();
}

class _searchBarRiwayatLamaran extends State<searchBarRiwayatLamaran> {
  String query = '';
  List<MelamarPekerjaan> results = []; // For storing search results

  @override
  void initState() {
    super.initState();
    results = dummyLamaranPekerjaan.take(5).map((lamaran) {
      return MelamarPekerjaan(
        idLamaranPekerjaan: lamaran['idLamaranPekerjaan'],
        idPostPekerjaan: lamaran['idPostPekerjaan'],
        status: lamaran['status'],
        createdAt: lamaran['createdAt'],
      );
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'diproses':
        return Colors.grey; // Background abu-abu
      case 'diterima':
        return Colors.green; // Background hijau
      case 'ditolak':
        return Colors.red; // Background merah
      default:
        return Colors.black; // Warna default jika status tidak dikenal
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                query = value;
                results = cariPekerjaan(query); // Update search results
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
          SizedBox(height: 10), // Space between search bar and results

          // Cek apakah hasil pencarian kosong
          results.isEmpty
              ? Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                          child: Text(
                        'No jobs found',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      )) // Tampilkan pesan jika kosong
                    ],
                  ),
                )
              : Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  height: 600,
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 5), // Space between items
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey), // Color of the border
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                          color: Colors.white, // Background color
                        ),
                        child: InkWell(
                          onTap: () {
                            // Navigate to the detail page with the job ID
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => detailHistoryLamaran(
                                    idLamaranPekerjaan:
                                        results[index].idLamaranPekerjaan),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                                results[index].idLamaranPekerjaan.toString()),
                            subtitle:
                                Text(results[index].idPostPekerjaan.toString()),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(results[index].status),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                results[index]
                                    .status, // Tampilkan status ('diproses', 'diterima', 'ditolak')
                                style: TextStyle(
                                  color: Colors.white, // Warna teks putih
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  List<MelamarPekerjaan> cariPekerjaan(String query) {
    if (query.isEmpty) {
      // Return first 5 jobs if query is empty
      results = dummyLamaranPekerjaan.take(5).map((lamaran) {
        return MelamarPekerjaan(
          idLamaranPekerjaan: lamaran['idLamaranPekerjaan'],
          idPostPekerjaan: lamaran['idPostPekerjaan'],
          status: lamaran['status'],
          createdAt: lamaran['createdAt'],
        );
      }).toList();
    }

    // List for found jobs
    List<MelamarPekerjaan> foundPekerjaan = [];
    for (var lamaran in dummyPostPekerjaan) {
      if (lamaran['idLamaranPekerjaan']
          .toLowerCase()
          .contains(query.toLowerCase())) {
        foundPekerjaan.add(MelamarPekerjaan(
          idLamaranPekerjaan: lamaran['idLamaranPekerjaan'],
          idPostPekerjaan: lamaran['idPostPekerjaan'],
          status: lamaran['status'],
          createdAt: lamaran['createdAt'],
        ));
      }
    }
    return foundPekerjaan; // Return the list of matching jobs
  }
}
