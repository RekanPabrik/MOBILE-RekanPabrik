part of '../page.dart';

class detailSavedJobs extends StatelessWidget {
  final int jobId;

  const detailSavedJobs({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    final selectedJob = dummyPostPekerjaan.firstWhere(
      (job) => job['id_post_pekerjaan'] == jobId,
      orElse: () => {'id_perusahaan': 0},
    );

    if (selectedJob['id_post_pekerjaan'] == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Detail Pekerjaan"),
        ),
        body: Center(
          child: Text("Pekerjaan tidak ditemukan."),
        ),
      );
    }

    Color statusColor;
    String statusText;

    if (selectedJob['status'] == 'tersedia') {
      statusColor = Colors.green; // Warna hijau untuk 'tersedia'
      statusText = "Tersedia";
    } else {
      statusColor = Colors.red; // Warna merah untuk 'berakhir'
      statusText = "Berakhir";
    }

    void simpanPekerjaan(int idPostPekerjaan) {
      if (idPostPekerjaan == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Harap pilih pekerjaan')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pekerjaan tersimpan')),
        );
        Navigator.pushNamed(context, '/pagePelamar');
      }
    }

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text("Detail Pekerjaan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Align(
              child: Text(
                selectedJob['posisi'],
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              child: Column(
                children: [
                  Text(
                    "Lokasi: ${selectedJob['lokasi']}",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color:
                          statusColor, // Menggunakan warna berdasarkan status
                      borderRadius:
                          BorderRadius.circular(10), // Border radius 10
                    ),
                    child: Text(
                      "Status: $statusText",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white), // Warna teks putih
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Text(
              "Deskripsi Pekerjaan:",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              selectedJob['job_details'] ?? "Tidak ada deskripsi pekerjaan.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "Persyaratan:",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              selectedJob['requirements'] ?? "Tidak ada persyaratan.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 50),
            Align(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LamarPekerjaan(
                          jobId: selectedJob[
                              'id_post_pekerjaan'], // Pastikan ID yang benar
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: thirdColor, // Latar belakang biru
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Border radius 10
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10), // Padding tombol
                  ),
                  child: Text(
                    'Lamar Pekerjaan',
                    style: TextStyle(
                        fontSize: 16, color: Colors.white), // Teks tombol
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
