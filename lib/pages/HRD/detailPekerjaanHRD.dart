part of '../page.dart';

class DetailPekerjaanHRD extends StatefulWidget {
  final int jobId;
  const DetailPekerjaanHRD({Key? key, required this.jobId}) : super(key: key);

  @override
  _DetailPekerjaanHRDState createState() => _DetailPekerjaanHRDState();
}

class _DetailPekerjaanHRDState extends State<DetailPekerjaanHRD> {
  final Postingpekerjaanapi postingpekerjaanapi = Postingpekerjaanapi();
  final meAPI meapi = meAPI();
  Map<String, dynamic>? selectedJob;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchJobDetails();
  }

  Future<void> _fetchJobDetails() async {
    try {
      List<Map<String, dynamic>> jobDetails =
          await postingpekerjaanapi.detailsJob(widget.jobId);
      if (jobDetails.isNotEmpty) {
        setState(() {
          selectedJob = jobDetails.first;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error loading job details: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> ubahStatus(int idPostPekerjaan) async {
    bool status =
        await postingpekerjaanapi.ubahStatusPekerjaann(idPostPekerjaan);

    if (status) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status pekerjaan diubah')),
      );

      Navigator.pushNamed(context, '/pageHRD');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saats mengubah status pekerjaan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Detail Pekerjaan")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (selectedJob == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Detail Pekerjaan")),
        body: Center(child: Text("Pekerjaan tidak ditemukan.")),
      );
    }

    Color statusColor =
        selectedJob!['status'] == 'terbuka' ? Colors.green : Colors.red;
    String statusText =
        selectedJob!['status'] == 'terbuka' ? "terbuka" : "ditutup";

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
            SizedBox(height: 30),
            Align(
              child: Text(
                selectedJob!['posisi'],
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Align(
              child: Column(
                children: [
                  Text("Lokasi: ${selectedJob!['lokasi']}",
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text(
                    _formatTanggal(selectedJob!['createdAt']),
                    style: TextStyle(fontSize: 13),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Status: $statusText",
                      style: TextStyle(fontSize: 16, color: Colors.white),
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
              selectedJob!['job_details'] ?? "Tidak ada deskripsi pekerjaan.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "Persyaratan:",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              selectedJob!['requirements'] ?? "Tidak ada persyaratan.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 50),
            Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (selectedJob!['status'] == 'ditutup')
                    ElevatedButton(
                      onPressed: () {
                        ubahStatus(selectedJob!['id_post_pekerjaan']);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: Text('Buka pekerjaan',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  if (selectedJob!['status'] == 'terbuka')
                    ElevatedButton(
                      onPressed: () {
                        ubahStatus(selectedJob!['id_post_pekerjaan']);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: Text('Tutup pekerjaan',
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTanggal(String createdAt) {
    final date = DateTime.parse(createdAt);
    return DateFormat('dd MMM yyyy').format(date);
  }
}
