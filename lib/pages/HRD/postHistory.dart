part of '../page.dart';

class Posthistory extends StatefulWidget {
  const Posthistory({super.key});

  @override
  State<Posthistory> createState() => _PosthistoryState();
}

class _PosthistoryState extends State<Posthistory> {
  final meAPI meapi = meAPI();
  final Postingpekerjaanapi postpekerjaanapi = Postingpekerjaanapi();
  var user;

  List<Map<String, dynamic>> resultsJob = [];
  String selectedFilter = 'Tanggal Terbaru';
  bool isLoading = true; // Variabel untuk melacak status loading

  @override
  void initState() {
    super.initState();
    _fetchPostPekerjaan();
  }

  Future<void> initUser() async {
    var response = await meapi.getUserProfile();

    if (response['status'] == true && response['data'] != null) {
      setState(() {
        user = response['data'];
      });
    } else {
      print("Failed to retrieve user data: ${response['message']}");
    }
  }

  Future<void> _fetchPostPekerjaan() async {
    setState(() {
      isLoading = true; // Mulai loading
    });

    await initUser();
    if (user == null || user.isEmpty) {
      print("User data belum tersedia");
    }
    try {
      final data =
          await postpekerjaanapi.getPostPekerjaan(user[0][0]['id_perusahaan']);

      setState(() {
        resultsJob = data;
      });

      _sortResults(); // Panggil fungsi sort setelah mendapatkan data
    } catch (e) {
      print("Error fetching job postings: $e");
    } finally {
      setState(() {
        isLoading = false; // Akhiri loading setelah data diambil
      });
    }
  }

  void _sortResults() {
    setState(() {
      if (selectedFilter == 'Tanggal Terbaru') {
        resultsJob.sort((a, b) => DateTime.parse(b['createdAt'])
            .compareTo(DateTime.parse(a['createdAt'])));
      } else if (selectedFilter == 'Status Tersedia') {
        resultsJob.sort((a, b) {
          if (a['status'] == 'tersedia' && b['status'] != 'tersedia') {
            return -1;
          } else if (a['status'] != 'tersedia' && b['status'] == 'tersedia') {
            return 1;
          } else {
            return 0;
          }
        });
      } else if (selectedFilter == 'Status berakhir') {
        resultsJob.sort((a, b) {
          if (a['status'] == 'berakhir' && b['status'] != 'berakhir') {
            return -1;
          } else if (a['status'] != 'berakhir' && b['status'] == 'berakhir') {
            return 1;
          } else {
            return 0;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: [
              const SizedBox(height: 50),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Job Post History",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: thirdColor),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 350,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Track and Manage Your Job Listings ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: thirdColor,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "With Rekan Pabrik, you have full visibility of all your past and current job postings. Easily access your job post history to review performance, track applications, and manage the status of each listing. Keep your hiring process organized and efficient with a comprehensive view of your recruitment efforts.",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: thirdColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Dropdown untuk mengurutkan
                  DropdownButton<String>(
                    value: selectedFilter,
                    items: [
                      'Tanggal Terbaru',
                      'Status Tersedia',
                      'Status berakhir',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFilter = newValue!;
                        _sortResults(); // Update the sorting based on selection
                      });
                    },
                    dropdownColor: Colors.white,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: thirdColor,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    hint: Text(
                      'Pilih Filter',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    height: 400,
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                            color: thirdColor,
                          ))
                        : ListView.builder(
                            itemCount: resultsJob.length,
                            itemBuilder: (context, index) {
                              final job = resultsJob[index];
                              final date = DateTime.parse(job['createdAt']);
                              final formattedDate =
                                  DateFormat('dd-MM-yyyy').format(date);
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailPekerjaanHRD(
                                                jobId:
                                                    job['id_post_pekerjaan']),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(job['posisi']),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Lokasi: ${job['lokasi']}"),
                                        Text("Status: ${job['status']}"),
                                        Text("Tanggal:$formattedDate"),
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
              const SizedBox(height: 100),
            ],
          )),
    );
  }
}
