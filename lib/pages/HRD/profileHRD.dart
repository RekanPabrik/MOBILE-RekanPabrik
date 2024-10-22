part of '../page.dart';


class Profilehrd extends StatefulWidget {
  const Profilehrd({super.key});

  @override
  State<Profilehrd> createState() => _ProfilehrdState();
}

class _ProfilehrdState extends State<Profilehrd> {
  // TextEditingControllers untuk input data pengguna
  final TextEditingController namaPerusahaanController =
      TextEditingController(text: "PT.RekanKerja");
  final TextEditingController alamatPerusahaanController =
      TextEditingController(text: "Jln.kita bersama No. 77");
  final TextEditingController emailController =
      TextEditingController(text: "rekanKerjaBersama@example.com");
  final TextEditingController tentangPerusahaanController = TextEditingController(
      text:
       "PT Rekan Kerja adalah perusahaan teknologi yang bergerak di bidang pengembangan aplikasi dan solusi digital. Sejak didirikan pada tahun 2024, kami berkomitmen untuk memberikan layanan inovatif dan transformasi digital yang mendukung kebutuhan informasi pekerjaan di Indonesia."
      );
  final String fotoIMG =
      "https://firebasestorage.googleapis.com/v0/b/proyek-tingkat.appspot.com/o/foto-profile-user%2F1727209252774_.png?alt=media&token=f572040b-895b-449b-bdc1-d4f52badc483";
  final String defaultFotoIMG =
      "https://firebasestorage.googleapis.com/v0/b/proyek-tingkat.appspot.com/o/foto-profile-user%2F1727209252774_.png?alt=media&token=f572040b-895b-449b-bdc1-d4f52badc483";
  

  
  String cvStatus = '';

  String existingCV = "";
  Uri? _cvURL;

  String? selectedCV;

File? _imageFile; // Variabel untuk menyimpan file gambar yang dipilih
  final ImagePicker _picker = ImagePicker(); // Inisialisasi ImagePicker

  @override
  void initState() {
    super.initState();
  }

   // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path); // Simpan gambar yang dipilih
      });
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: true,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: [
      const SizedBox(height: 30),
            // Foto profil
            CircleAvatar(
              radius: 80,
              backgroundImage: _imageFile == null
                  ? NetworkImage(defaultFotoIMG) // Jika belum ada file gambar yang dipilih, gunakan URL default
                  : FileImage(_imageFile!) as ImageProvider, // Jika sudah ada, gunakan gambar yang dipilih
            ),
            const SizedBox(height: 20),
            // Button lingkaran untuk mengganti foto profil
            InkWell(
              onTap: _pickImage, // Fungsi untuk memilih foto dari galeri
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Input Nama Perusahaan
            TextField(
              controller: namaPerusahaanController,
              decoration: const InputDecoration(
                labelText: "Nama Perusahaan",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Input Nama Belakang
            TextField(
              controller: alamatPerusahaanController,
              decoration: const InputDecoration(
                labelText: "Alamat Perusahaan",
                border:OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            // Input Email
            const SizedBox(height: 16),

            // Input Visi Misi Perusahaan
            TextField(
              controller: tentangPerusahaanController,
              decoration: const InputDecoration(
                labelText: "Tentang Perusahaan",
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),

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
