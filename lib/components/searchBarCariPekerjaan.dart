import 'package:flutter/material.dart';
import 'package:rekanpabrik/models/postingPekerjaan.dart';
import 'package:rekanpabrik/pages/page.dart';
import 'package:rekanpabrik/shared/shared.dart';
import 'package:rekanpabrik/utils/dummyPerusahaan.dart';
import 'package:rekanpabrik/utils/dummyPostinganPekerjaan.dart';

class searchBarCariPekerjaan extends StatefulWidget {
  const searchBarCariPekerjaan({super.key});

  @override
  _searchBarCariPekerjaan createState() => _searchBarCariPekerjaan();
}

class _searchBarCariPekerjaan extends State<searchBarCariPekerjaan> {
  String query = '';
  List<PostingPekerjaan> results = []; // For storing search results

  @override
  void initState() {
    super.initState();
    // Initialize results with the first 5 dummy jobs
    results = dummyPostPekerjaan.take(5).map((job) {
      return PostingPekerjaan(
        idPostPekerjaan: job['id_post_pekerjaan'],
        idPerusahaan: job['id_perusahaan'],
        posisi: job['posisi'],
        lokasi: job['lokasi'],
        jobDetails: job['job_details'],
        requirements: job['requirements'],
        status: job['status'],
        createdAt: job['createdAt'],
      );
    }).toList();
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
                                builder: (context) => detailPekerjaan(
                                    jobId: results[index].idPostPekerjaan),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(results[index].posisi),
                            subtitle: Text(results[index].lokasi),
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

  List<PostingPekerjaan> cariPekerjaan(String query) {
    if (query.isEmpty) {
      // Return first 5 jobs if query is empty
      return dummyPostPekerjaan.take(5).map((job) {
        return PostingPekerjaan(
          idPostPekerjaan: job['id_post_pekerjaan'],
          idPerusahaan: job['id_perusahaan'],
          posisi: job['posisi'],
          lokasi: job['lokasi'],
          jobDetails: job['job_details'],
          requirements: job['requirements'],
          status: job['status'],
          createdAt: job['createdAt'],
        );
      }).toList();
    }

    // List for found jobs
    List<PostingPekerjaan> foundPekerjaan = [];
    for (var job in dummyPostPekerjaan) {
      if (job['posisi'].toLowerCase().contains(query.toLowerCase())) {
        foundPekerjaan.add(PostingPekerjaan(
          idPostPekerjaan: job['id_post_pekerjaan'],
          idPerusahaan: job['id_perusahaan'],
          posisi: job['posisi'],
          lokasi: job['lokasi'],
          jobDetails: job['job_details'],
          requirements: job['requirements'],
          status: job['status'],
          createdAt: job['createdAt'],
        ));
      }
    }
    return foundPekerjaan; // Return the list of matching jobs
  }
}
