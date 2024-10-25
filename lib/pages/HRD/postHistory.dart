part of '../page.dart';

class Posthistory extends StatefulWidget {
  const Posthistory({super.key});

  @override
  State<Posthistory> createState() => _PosthistoryState();
}

class _PosthistoryState extends State<Posthistory> {
  List<PostingPekerjaan> results = [];
  String selectedFilter = 'Tanggal Terbaru'; // Default filter option

  @override
  void initState() {
    super.initState();
    results = dummyPostPekerjaan.map((job) {
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
    _sortResults(); // Sort default by date
  }

  void _sortResults() {
    setState(() {
      if (selectedFilter == 'Tanggal Terbaru') {
        results.sort(
            (a, b) => b.createdAt.compareTo(a.createdAt)); // Descending by date
      } else if (selectedFilter == 'Status Tersedia') {
        results.sort((a, b) {
          if (a.status == 'tersedia' && b.status != 'tersedia') {
            return -1; // 'tersedia' comes first
          } else if (a.status != 'tersedia' && b.status == 'tersedia') {
            return 1; // 'tersedia' comes first
          } else {
            return 0; // status is the same
          }
        });
      } else if (selectedFilter == 'Status berakhir') {
        results.sort((a, b) {
          if (a.status == 'berakhir' && b.status != 'berakhir') {
            return -1; // 'berakhir' comes first
          } else if (a.status != 'berakhir' && b.status == 'berakhir') {
            return 1; // 'berakhir' comes first
          } else {
            return 0; // status is the same
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
                    dropdownColor: Colors.white, // Background color dropdown
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: thirdColor, // Font color dropdown
                    ),
                    borderRadius:
                        BorderRadius.circular(12), // Border radius dropdown
                    hint: Text(
                      'Pilih Filter',
                      style: TextStyle(color: Colors.grey), // Gaya teks hint
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
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
                                  builder: (context) => detailPekerjaanHRD(
                                      jobId: results[index].idPostPekerjaan),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(results[index].posisi),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Lokasi: ${results[index].posisi}"),
                                  Text("Status: ${results[index].status}"),
                                  Text(
                                      "Tanggal: ${results[index].createdAt.toLocal()}"),
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
              const SizedBox(height: 200),
            ],
          )),
    );
  }
}
