part of "../page.dart";

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  final String defaultFotoIMG =
      "https://firebasestorage.googleapis.com/v0/b/proyek-tingkat.appspot.com/o/foto-profile-user%2F1727209252774_.png?alt=media&token=f572040b-895b-449b-bdc1-d4f52badc483";

  File? _imageFile; // Variabel untuk menyimpan file gambar yang dipilih
  final ImagePicker _picker = ImagePicker(); // Inisialisasi ImagePicker

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);


    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path); // Simpan gambar yang dipilih
      });
    }
  }

  // Fungsi untuk mengambil gambar dari kamera
  Future<void> _takePicture() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path); // Simpan gambar yang diambil
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ganti dengan warna yang sesuai
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
            // Button untuk mengganti foto profil dari galeri
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo),
              label: const Text("Ambil dari Galeri"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            // Button untuk mengambil gambar dari kamera
            ElevatedButton.icon(
              onPressed: _takePicture,
              icon: const Icon(Icons.camera_alt),
              label: const Text("Ambil dari Kamera"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
