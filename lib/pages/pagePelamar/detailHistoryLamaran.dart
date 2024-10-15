part of '../page.dart';

class detailHistoryLamaran extends StatelessWidget {
  final int idLamaranPekerjaan;

  const detailHistoryLamaran({super.key, required this.idLamaranPekerjaan});

  @override
  Widget build(BuildContext context) {
    final selectedHistory = dummyLamaranPekerjaan.firstWhere(
      (history) => history['idLamaranPekerjaan'] == idLamaranPekerjaan,
      orElse: () => {'idLamaranPekerjaan': 0},
    );

    // Handle the case where the job is not found
    if (selectedHistory['idLamaranPekerjaan'] == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Detail Riwayat Lamaran"),
        ),
        body: Center(
          child: Text("Pekerjaan tidak ditemukan."),
        ),
      );
    }

    Color statusColor;
    String statusText;

    // Determine the job status and corresponding color
    if (selectedHistory['status'] == 'diterima') {
      statusColor = Colors.green; // Green for 'available'
      statusText = "diterima";
    } else if (selectedHistory['status'] == 'ditolak') {
      statusColor = Colors.red; // Red for 'closed'
      statusText = "ditolak";
    } else if (selectedHistory['status'] == 'diproses') {
      statusColor = Colors.grey; // Red for 'closed'
      statusText = "diproses";
    } else {
      statusColor = Colors.black; // Red for 'closed'
      statusText = "null";
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
                selectedHistory['createdAt'].toString(),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 50),
            Align(
              child: Column(
                children: [
                  Text(
                    "id postingan pekerjaan: ${selectedHistory['idPostPekerjaan']}",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: statusColor,
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
            SizedBox(height: 80),
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
            Align(
                alignment: Alignment.center,
                child: Text(
                  "Lamaran anda sedang di proses oleh HRD perusahaan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
