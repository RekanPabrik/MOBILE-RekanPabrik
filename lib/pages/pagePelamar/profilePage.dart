part of '../page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // TextEditingControllers untuk input data pengguna
  final TextEditingController firstNameController =
      TextEditingController(text: "Rafif");
  final TextEditingController lastNameController =
      TextEditingController(text: "Purnomo");
  final TextEditingController emailController =
      TextEditingController(text: "rafif.purnomo@example.com");
  final TextEditingController aboutMeController = TextEditingController(
      text: "Saya seorang Software Engineer dengan 2+ tahun pengalaman.");
  final String fotoIMG =
      "https://firebasestorage.googleapis.com/v0/b/proyek-tingkat.appspot.com/o/foto-profile-user%2F1727209252774_.png?alt=media&token=f572040b-895b-449b-bdc1-d4f52badc483";

  String cvStatus = '';

  String existingCV =
      //"https://firebasestorage.googleapis.com/v0/b/proyek-tingkat.appspot.com/o/curriculum-vitae%2F1727209251974_.pdf?alt=media&token=0e6fe89c-4c6a-42c5-a965-f66c699af0ec";
      "";
  Uri? _cvURL;

  String? selectedCV;

  void cekCV(String? existingCV) {
    if (existingCV == null || existingCV.isEmpty) {
      setState(() {
        cvStatus = "Anda Belum Mengupload CV";
      });
    } else {
      setState(() {
        cvStatus =
            "CV saat ini: ${firstNameController.text}${lastNameController.text}";
      });
    }
  }

  // Fungsi untuk memilih CV baru
  Future<void> pickCV() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          selectedCV = result.files.single.name;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('CV "${result.files.single.name}" dipilih!')),
        );
      }
    } catch (e) {
      debugPrint("Error saat memilih CV: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memilih CV: $e')),
      );
    }
  }

  // Fungsi untuk mengunduh CV
  Future<void> _launchCV() async {
    if (_cvURL != null) {
      await launchUrl(_cvURL!, mode: LaunchMode.externalApplication);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mengunduh CV...')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('CV TIDAK ADA...')),
      );
    }
  }

  // Fungsi untuk menyimpan perubahan profil
  void saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil berhasil diperbarui!')),
    );
  }

  @override
  void initState() {
    super.initState();
    _cvURL = Uri.parse(existingCV);
    cekCV(existingCV);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: true,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: [
            SizedBox(
              height: 30,
            ),
            // Foto profil
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(fotoIMG), // Ganti dengan foto asli
            ),
            const SizedBox(height: 20),

            // Input Nama Depan
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                labelText: "Nama Depan",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Input Nama Belakang
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                labelText: "Nama Belakang",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Input Email
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Input About Me
            TextField(
              controller: aboutMeController,
              decoration: const InputDecoration(
                labelText: "Tentang Saya",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            // Menampilkan CV Saat Ini atau Pesan "CV Tidak Tersedia"
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    cvStatus,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (existingCV.isNotEmpty)
                        ElevatedButton.icon(
                          onPressed: _launchCV,
                          icon: const Icon(Icons.download),
                          label: const Text("Unduh CV"),
                        ),
                      ElevatedButton.icon(
                        onPressed: pickCV,
                        icon: const Icon(Icons.attach_file),
                        label: const Text("Pilih CV Baru"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Tombol untuk memilih CV baru

            // Tampilkan nama CV baru yang dipilih (jika ada)
            if (selectedCV != null)
              Text(
                "CV Baru: $selectedCV",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

            const SizedBox(height: 16),

            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: dangerColor),
                onPressed: () {
                  Navigator.pushNamed(context, '/reserPass');
                },
                child: Text(
                  "Reset Password",
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: succesColor),
                onPressed: saveProfile,
                child: Text(
                  "Simpan Perubahan",
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ]),
            SizedBox(
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}
