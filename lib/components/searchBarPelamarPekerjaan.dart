import 'package:flutter/material.dart';
import 'package:rekanpabrik/models/dataPelamarPekerjaan.dart';
import 'package:rekanpabrik/models/postingPekerjaan.dart';
import 'package:rekanpabrik/pages/page.dart';
import 'package:rekanpabrik/shared/shared.dart';
import 'package:rekanpabrik/utils/dataDummyPelamar.dart';
import 'package:rekanpabrik/utils/dummyPostinganPekerjaan.dart';

class searchBarPelamarPekerjaan extends StatefulWidget {
  const searchBarPelamarPekerjaan({super.key});

  @override
  _searchBarPelamarPekerjaan createState() => _searchBarPelamarPekerjaan();
}

class _searchBarPelamarPekerjaan extends State<searchBarPelamarPekerjaan> {
  String query = '';
  List<pelamarPekerjaan> results = []; // For storing search results

  @override
  void initState() {
    super.initState();
    // Initialize results with the first 5 dummy jobs
    results = dummyDataPelamarPekerjaaan.take(5).map((user) {
      return pelamarPekerjaan(
          idPelamar: user['idPelamar'],
          firstName: user['firstName'],
          lastName: user['lastName'],
          CV: user['CV'],
          IMG: user['IMG'],
          posisisDilamar: user['posisiDilamar'],
          statusLamaran: user['statusLamaran']);
    }).toList();
  }

  Color statusColors(String status) {
    if (status == "diproses") {
      return Colors.grey;
    } else if (status == "ditolak") {
      return dangerColor;
    } else if (status == "diterima") {
      return succesColor;
    } else {
      return primaryColor;
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
                results = cariDataPelamar(query); // Update search results
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
                        'Pelamar Not Found',
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
                          border:
                              Border.all(color: Colors.grey), // Border color
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
                                builder: (context) => Detailpelamar(
                                  idPelamar: results[index].idPelamar,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              "${results[index].firstName} ${results[index].lastName}",
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(results[index]
                                    .posisisDilamar), // Posisi yang dilamar
                                const SizedBox(
                                    height:
                                        5), // Space between position and status
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical:
                                          4), // Padding for the status container
                                  decoration: BoxDecoration(
                                    color: statusColors(
                                        results[index].statusLamaran),
                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded corners
                                  ),
                                  child: Text(
                                    results[index]
                                        .statusLamaran, // Status lamaran
                                    style: const TextStyle(
                                      color: Colors.white, // Text color
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
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

  List<pelamarPekerjaan> cariDataPelamar(String query) {
    if (query.isEmpty) {
      // Return first 5 jobs if query is empty
      return dummyDataPelamarPekerjaaan.take(5).map((user) {
        return pelamarPekerjaan(
            idPelamar: user['idPelamar'],
            firstName: user['firstName'],
            lastName: user['lastName'],
            CV: user['CV'],
            IMG: user['IMG'],
            posisisDilamar: user['posisiDilamar'],
            statusLamaran: user['statusLamaran'].toString());
      }).toList();
    }

    // List for found jobs
    List<pelamarPekerjaan> foundPelamar = [];
    for (var user in dummyDataPelamarPekerjaaan) {
      // Memeriksa apakah user['posisi'] tidak null
      var posisi = user['posisi'];
      if (posisi != null &&
          posisi.toLowerCase().contains(query.toLowerCase())) {
        foundPelamar.add(pelamarPekerjaan(
          idPelamar: user['idPelamar'],
          firstName: user['firstName'],
          lastName: user['lastName'],
          CV: user['CV'],
          IMG: user['IMG'],
          posisisDilamar: user['posisiDilamar'],
          statusLamaran: user['statusLamaran'],
        ));
      }
    }
    return foundPelamar; // Kembalikan daftar pelamar yang cocok
  }
}
