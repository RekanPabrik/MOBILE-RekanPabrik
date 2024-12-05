part of '../page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String defaultFotoIMG = 'assets/img/defaultPict.png';
  String cvStatus = '';
  Uri? _cvURL;
  var user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  Future<void> initUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      var response = await meAPI().getUserProfile();

      if (response['status'] == true && response['data'] != null) {
        setState(() {
          user = response['data'];
          firstNameController.text = user[0][0]['first_name'].toString();
          lastNameController.text = user[0][0]['last_name'].toString();
          if (user[0][0]['about_me'] != null &&
              user[0][0]['about_me'].isNotEmpty) {
            aboutMeController.text = user[0][0]['about_me'];
          }
          emailController.text = user[0][0]['email'].toString();
          _cvURL = Uri.parse(user[0][0]['curriculum_vitae'] ?? "");
          cvStatus = _cvURL == null || _cvURL.toString().isEmpty
              ? "Anda belum mengupload CV"
              : "CV telah diunggah.";
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Gagal memuat data pengguna: ${response['message']}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error memuat data pengguna: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _launchCV() async {
    if (_cvURL != null && _cvURL!.toString().isNotEmpty) {
      try {
        bool canLaunch = await canLaunchUrl(_cvURL!);
        if (canLaunch) {
          await launchUrl(_cvURL!, mode: LaunchMode.externalApplication);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mengunduh CV...')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Tidak ada aplikasi untuk membuka URL ini.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal membuka CV: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('CV TIDAK ADA...')),
      );
    }
  }

  Future<void> saveProfile(int idPelamar, String firstname, String lastname,
      String email, String aboutme) async {
    try {
      bool status = await Pelamarapi().updateDataPelamar(
          idpelamar: idPelamar,
          firstname: firstname,
          lastname: lastname,
          email: email,
          aboutme: aboutme);

      if (status) {
        Navigator.pushNamed(context, '/pagePelamar');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil berhasil diperbarui!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal memperbarui Profil')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error memperbarui Profil')),
      );
    }
  }

  Future<void> logout() async {
    bool result = await LoginAPI().logout();
    if (result) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => login_page()),
        (route) => false, // Menghapus semua halaman sebelumnya di stack
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Anda sudah log out")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.transparent),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.support_agent, // Ikon customer service
              color: thirdColor,
              size: 50,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Pengaduan(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: true,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: [
            const SizedBox(height: 30),
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey[200],
              backgroundImage: (user?[0][0]['profile_pict'] != null &&
                      user[0][0]['profile_pict'].isNotEmpty)
                  ? NetworkImage(user[0][0]['profile_pict'])
                  : null,
              child: (user?[0][0]['profile_pict'] == null ||
                      user[0][0]['profile_pict'].isEmpty)
                  ? Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.grey,
                    )
                  : null,
            ),

            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangeProfilePagePelamar(),
                  ),
                );
              },
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

            // Input Fields
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                labelText: "Nama Depan",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                labelText: "Nama Belakang",
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
            const SizedBox(height: 16),
            TextField(
              controller: aboutMeController,
              decoration: const InputDecoration(
                labelText: "Tentang Saya",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),

            // CV Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    cvStatus,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: cvStatus == "Anda belum mengupload CV"
                          ? Colors.red
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _launchCV,
                        icon: const Icon(Icons.download),
                        label: const Text("Unduh CV"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UploadCv(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.upload_file),
                        label: const Text("Upload CV Baru"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Save Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: dangerColor),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Resetpasspelamar(),
                      ),
                    );
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
                    int idpelamar = user[0][0]['id_pelamar'];
                    saveProfile(
                      idpelamar,
                      firstNameController.text,
                      lastNameController.text,
                      emailController.text,
                      aboutMeController.text,
                    );
                  },
                  child: Text(
                    "Simpan Perubahan",
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: dangerColor),
              onPressed: () {
                logout();
              },
              child: Text(
                "log out",
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
