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
  final ImagePicker _picker = ImagePicker();
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
        alamatPerusahaanController.text = user[0][0]['alamat'].toString();
        emailController.text = user[0][0]['email'].toString();
        tentangPerusahaanController.text = user[0][0]['about_me'].toString();
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

  Future<void> _updateProfileData() async {
    final success = await perusahaanapi.updateProfileData(
        idperusahaan: user[0][0]['id_perusahaan'],
        email: emailController.text,
        namaPerusahaan: namaPerusahaanController.text,
        tentangPerusahaan: tentangPerusahaanController.text,
        alamatPerusahaan: alamatPerusahaanController.text);

    if (success) {
      showProfileUpdatedNotification();
      Navigator.pushNamed(context, '/pageHRD');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Gagal memperbarui foto ')));
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
                            _updateProfileData();
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
