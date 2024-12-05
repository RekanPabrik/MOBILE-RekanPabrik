part of '../page.dart';

class Profilehrd extends StatefulWidget {
  const Profilehrd({super.key});

  @override
  State<Profilehrd> createState() => _ProfilehrdState();
}

class _ProfilehrdState extends State<Profilehrd> {
  final TextEditingController namaPerusahaanController =
      TextEditingController();
  final TextEditingController alamatPerusahaanController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController tentangPerusahaanController =
      TextEditingController();
  final String defaultFotoIMG = 'assets/img/defaultPict.png';
  final LoginAPI loginapi = LoginAPI();
  final meAPI meapi = meAPI();
  final PerusahaanAPI perusahaanapi = PerusahaanAPI();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  File? _imageFile;
  var user;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initUser();
    _initializeNotifications();
    _requestNotificationPermission();
  }

  Future<void> initUser() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });

    var response = await meapi.getUserProfile();

    if (response['status'] == true && response['data'] != null) {
      if (!mounted) return;
      setState(() {
        user = response['data'];
        namaPerusahaanController.text =
            user[0][0]['nama_perusahaan'].toString();
        if (user[0][0]['alamat'] != null && user[0][0]['alamat'].isNotEmpty) {
          alamatPerusahaanController.text = user[0][0]['alamat'].toString();
        }
        emailController.text = user[0][0]['email'].toString();
        if (user[0][0]['about_me'] != null) {
          tentangPerusahaanController.text = user[0][0]['about_me'].toString();
        }
        isLoading = false;
      });
    } else {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      print("Failed to retrieve user data: ${response['message']}");
    }
  }

  void _requestNotificationPermission() async {
    final bool? granted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    if (granted != null && !granted) {
      print("Izin notifikasi ditolak oleh pengguna");
    }
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showProfileUpdatedNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'profile_channel',
      'Profile Update Notifications',
      channelDescription: 'Notifications for profile updates',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Profile Updated',
      'Your profile has been updated successfully!',
      platformChannelSpecifics,
    );
  }

  Future<void> _updateProfileData(String email, String namaPerusahaan,
      String tentangPerusahaan, String alamatPerusahaan) async {
    if (email.isEmpty ||
        namaPerusahaan.isEmpty ||
        tentangPerusahaan.isEmpty ||
        alamatPerusahaan.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Semua kolom harus diisi!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      final success = await perusahaanapi.updateProfileData(
          idperusahaan: user[0][0]['id_perusahaan'],
          email: email,
          namaPerusahaan: namaPerusahaan,
          tentangPerusahaan: tentangPerusahaan,
          alamatPerusahaan: alamatPerusahaan);

      if (success) {
        showProfileUpdatedNotification();
        Navigator.pushNamed(context, '/pageHRD');
      } else {
        SnackBar(
          content: const Text("Gagal memperbarui profile"),
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      SnackBar(
        content: const Text("Error memperbarui profile"),
        backgroundColor: Colors.red,
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
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: true,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Color.fromARGB(255, 168, 97, 8),
              ))
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: [
                  const SizedBox(height: 30),
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: (user?[0][0]['profile_pict'] != null &&
                                user[0][0]['profile_pict'].isNotEmpty)
                            ? NetworkImage(user[0][0]['profile_pict'])
                            : AssetImage('assets/default_profile.png'),
                      ),
                    ),
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
                          builder: (context) =>
                              const Changeprofilepageperusahaan(),
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
                  TextField(
                    controller: namaPerusahaanController,
                    decoration: const InputDecoration(
                      labelText: "Nama Perusahaan",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
                  TextField(
                    controller: tentangPerusahaanController,
                    decoration: const InputDecoration(
                      labelText: "Tentang Perusahaan",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 30),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: thirdColor),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const Resetpassperusahaan(),
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
                          style: ElevatedButton.styleFrom(
                              backgroundColor: succesColor),
                          onPressed: () {
                            String email = emailController.text;
                            String namaPerusahaan =
                                namaPerusahaanController.text;
                            String tentangPerusahaan =
                                tentangPerusahaanController.text;
                            String alamatPerusahaan =
                                alamatPerusahaanController.text;
                            _updateProfileData(email, namaPerusahaan,
                                tentangPerusahaan, alamatPerusahaan);
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
                    height: 50,
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: dangerColor),
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
                  )
                ],
              ),
      ),
    );
  }
}
