part of '../page.dart';

class Detailpelamar extends StatelessWidget {
  final int idPelamar;
  const Detailpelamar({super.key, required this.idPelamar});

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
    Map<String, dynamic> pelamar = dummyDataPelamarPekerjaaan.firstWhere(
      (item) => item['idPelamar'] == idPelamar,
      orElse: () => {
        'id': 0,
        'firstName': null,
        'lastName': null,
        'CV': null,
        'IMG': null,
        'posisiDilamar': null,
        'statusLamaran': null,
      },
    );

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text('Detail Pelamar'),
        backgroundColor: primaryColor,
      ),
      body: pelamar['idPelamar'] != null
          ? SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: pelamar['IMG'] != null
                          ? NetworkImage(pelamar['IMG'])
                          : const AssetImage(
                              'assets/images/default_avatar.png'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 100,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: statusColors(pelamar['statusLamaran']),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      pelamar['statusLamaran'].toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Input area untuk first name
                  TextField(
                    controller:
                        TextEditingController(text: pelamar['firstName']),
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Input area untuk last name
                  TextField(
                    controller:
                        TextEditingController(text: pelamar['lastName']),
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller:
                        TextEditingController(text: pelamar['posisiDilamar']),
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Posisi yang di lamar',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tombol untuk mendownload CV
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: thirdColor),
                    onPressed: () => _launchCV(pelamar['CV'], context),
                    child: const Text(
                      'Download CV',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          bool? confirm =
                              await _showConfirmationDialogDiTolak(context);
                          if (confirm ?? false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Lamaran ditolak')),
                            );
                            // Tambahkan logika untuk update status di database atau API di sini
                          }
                          Navigator.pushNamed(context, '/pageHRD');
                        },
                        child: const Text('Tolak Pelamar'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          bool? confirm =
                              await _showConfirmationDialogDiterima(context);
                          if (confirm ?? false) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Lamaran diterima')),
                            );
                            // Tambahkan logika untuk update status di database atau API di sini
                          }
                          Navigator.pushNamed(context, '/pageHRD');
                        },
                        child: const Text('Terima Pelamar'),
                      ),
                    ],
                  )
                ],
              ),
            )
          : Center(child: const Text('Pelamar tidak ditemukan')),
    );
  }

  Future<void> _launchCV(String? cvUrl, BuildContext context) async {
    if (cvUrl != null) {
      final Uri uri = Uri.parse(cvUrl); // Ubah menjadi Uri
      if (await canLaunchUrl(uri)) {
        // Ganti canLaunch dengan canLaunchUrl
        await launchUrl(uri,
            mode: LaunchMode
                .externalApplication); // Ganti launch dengan launchUrl
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mengunduh CV...')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('CV tidak tersedia')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('CV tidak tersedia')),
      );
    }
  }
}

Future<bool?> _showConfirmationDialogDiterima(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin menerima pelamar ini?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Kembali tanpa update
            },
            child: const Text('Tidak'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Konfirmasi update
            },
            child: const Text('Ya'),
          ),
        ],
      );
    },
  );
}

Future<bool?> _showConfirmationDialogDiTolak(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Apakah Anda yakin ingin menolak pelamar ini?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Kembali tanpa update
            },
            child: const Text('Tidak'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Konfirmasi update
            },
            child: const Text('Ya'),
          ),
        ],
      );
    },
  );
}
