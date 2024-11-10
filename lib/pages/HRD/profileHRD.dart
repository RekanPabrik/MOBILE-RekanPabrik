part of '../page.dart';

class Profilehrd extends StatefulWidget {
  const Profilehrd({super.key});

  @override
  State<Profilehrd> createState() => _ProfilehrdState();
}

class _ProfilehrdState extends State<Profilehrd> {
  // TextEditingControllers untuk input data pengguna
  final TextEditingController namaPerusahaanController =
      TextEditingController();
  final TextEditingController alamatPerusahaanController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController tentangPerusahaanController =
      TextEditingController();
  final String defaultFotoIMG = 'assets/img/defaultPict.png';
  final ImagePicker _picker = ImagePicker();
  final LoginAPI loginapi = LoginAPI();
  final meAPI meapi = meAPI();
  final PerusahaanAPI perusahaanapi = PerusahaanAPI();
  File? _imageFile;
  var user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  Future<void> initUser() async {
    var response = await meapi.getUserProfile();

    if (response['status'] == true && response['data'] != null) {
      setState(() {
        user = response['data'];
        namaPerusahaanController.text =
            user[0][0]['nama_perusahaan'].toString();
        alamatPerusahaanController.text = user[0][0]['alamat'].toString();
        emailController.text = user[0][0]['email'].toString();
        tentangPerusahaanController.text = user[0][0]['about_me'].toString();
      });
    } else {
      print("Failed to retrieve user data: ${response['message']}");
    }
  }

  Future<void> _updateProfilePict() async {
    final success = await perusahaanapi.updateProfilePicture(
      idperusahaan: user[0][0]['id_perusahaan'].toString(),
      imagePath: _imageFile?.path ?? user[0][0]['profile_pict'],
    );
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('foto profile berhasil diperbarui!')));
      Navigator.pushNamed(context, '/pageHRD');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui foto profile')));
    }
  }

  Future<void> _updateProfileData() async {
    final success = await perusahaanapi.updateProfileData(
        idperusahaan: user[0][0]['id_perusahaan'],
        email: emailController.text,
        namaPerusahaan: namaPerusahaanController.text,
        tentangPerusahaan: tentangPerusahaanController.text,
        alamatPerusahaan: alamatPerusahaanController.text);

    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('foto berhasil diperbarui!')));
      Navigator.pushNamed(context, '/pageHRD');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal memperbarui foto ')));
    }
  }

  void updateProfile() {
    _updateProfilePict;
    _updateProfileData;
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
                  ? (user?[0][0]['profile_pict'] != null
                      ? NetworkImage(user[0][0]['profile_pict'])
                          as ImageProvider
                      : AssetImage(defaultFotoIMG) as ImageProvider)
                  : FileImage(_imageFile!),
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
                border: OutlineInputBorder(),
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
                onPressed: () {
                  updateProfile();
                },
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
