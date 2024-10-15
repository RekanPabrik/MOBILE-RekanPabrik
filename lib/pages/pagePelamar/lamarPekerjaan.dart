part of '../page.dart';

class LamarPekerjaan extends StatelessWidget {
  final int jobId;

  const LamarPekerjaan({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    final selectedJob = dummyPostPekerjaan.firstWhere(
      (job) => job['id_post_pekerjaan'] == jobId,
      orElse: () => {'id_post_pekerjaan': 0},
    );

    // Handle the case where the job is not found
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

    // Determine the job status and corresponding color
    if (selectedJob['status'] == 'tersedia') {
      statusColor = Colors.green; // Green for 'available'
      statusText = "Tersedia";
    } else {
      statusColor = Colors.red; // Red for 'closed'
      statusText = "Berakhir";
    }

    // Sample user data (you can replace this with actual user data)
    final userData = {
      'first_name': 'John',
      'last_name': 'Doe',
      'img': 'assets/img/dapa.png'
    };

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text("Lamar Pekerjaan"),
      ),
      body: SafeArea(
        bottom: true,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
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
                      color: statusColor, // Using color based on status
                      borderRadius:
                          BorderRadius.circular(10), // Border radius 10
                    ),
                    child: Text(
                      "Status: $statusText",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white), // White text color
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80),

            // Job details
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
                child: Text(
              "Deskripsi Pelamar",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            )),
            SizedBox(height: 10),
            Align(
                alignment: Alignment.center,
                child: Text(
                  "Pastikan Anda mengecek persyartan pekerjaan dan semua data diri Anda sebelum melamar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            SizedBox(height: 40),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Use min to prevent it from taking extra space
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.green,
                    backgroundImage: AssetImage(
                      userData['img'] ??
                          'assets/img/default.png', // Default image if the path is null
                    ),
                    child: userData['img'] == null
                        ? Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey,
                          )
                        : null, // Show icon if there is no image
                  ),

                  SizedBox(
                      height: 10), // Use height for spacing instead of width
                  Container(
                    width: 300, // Set your desired width here
                    child: TextField(
                      controller: TextEditingController(
                          text:
                              userData['first_name'] ?? 'Nama tidak tersedia'),
                      readOnly: true, // Makes the field non-editable
                      decoration: InputDecoration(
                        labelText: 'Nama Depan',
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Space between text fields
                  // Non-editable TextField for last name
                  Container(
                    width: 300, // Set your desired width here
                    child: TextField(
                      controller: TextEditingController(
                          text: userData['last_name'] ?? ''),
                      readOnly: true, // Makes the field non-editable
                      decoration: InputDecoration(
                        labelText: 'Nama Belakang',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80),
            Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "I agree to follow the application rules set by the company.",
                  style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: greyColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Align(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Lamaran Anda telah diajukan!')),
                      );
                      Navigator.pushNamed(context, '/pagePelamar');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: thirdColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: Text(
                      'Ajukan Lamaran',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
