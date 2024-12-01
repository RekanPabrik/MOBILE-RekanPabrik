part of '../page.dart';

class Postjob extends StatefulWidget {
  const Postjob({super.key});

  @override
  State<Postjob> createState() => _PostjobState();
}

class _PostjobState extends State<Postjob> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final TextEditingController posisiController = TextEditingController();
  final TextEditingController lokasiPekerjaanController =
      TextEditingController();
  final TextEditingController jobDetailsController = TextEditingController();
  final TextEditingController requirementsController = TextEditingController();
  var user;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _requestNotificationPermission();
    initUser();
  }

  Future<void> initUser() async {
    var response = await meAPI().getUserProfile();

    if (response['status'] == true && response['data'] != null) {
      if (!mounted) return;
      setState(() {
        user = response['data'];
      });
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Anda tidak login ')));
      print("Failed to retrieve user data: ${response['message']}");
    }
  }

  void _requestNotificationPermission() async {
    final bool? granted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    if (granted != null && !granted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Izin notifikasi ditolak oleh pengguna ')));
      // print("Izin notifikasi ditolak oleh pengguna");
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

  void showJobPostedNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'job_channel',
      'Job Posting Notifications',
      channelDescription: 'Notifications for new job postings',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Job Posted',
      'Your job has been posted successfully!',
      platformChannelSpecifics,
    );
  }

  Future<void> postJob(int idPerusahaan, String posisi, String lokasi,
      String jobDetails, String requirements) async {
    try {
      bool status = await Postingpekerjaanapi().postingPekerjaann(
          idPerusahaan, posisi, lokasi, jobDetails, requirements);

      if (status) {
        showJobPostedNotification();
        Navigator.pushNamed(context, '/pageHRD');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal memposting pekerjaan ')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error memposting pekerjaan ')));
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
              SizedBox(
                height: 50,
              ),
              Container(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Post a Job",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: thirdColor),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 350,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "Find the Perfect Candidate for Your Team",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: thirdColor,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "At Rekan Pabrik, we make it easy for you to post job listings and connect with top talent in the industry. Whether you're looking to fill one role or expand your entire team, our platform gives you the tools to attract qualified candidates quickly and efficiently.",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: thirdColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: posisiController,
                decoration: const InputDecoration(
                  labelText: 'Posisi',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: lokasiPekerjaanController,
                decoration: const InputDecoration(
                  labelText: 'Lokasi Pekerjaan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: jobDetailsController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Job Details',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: requirementsController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Requirements',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    int idPerusahaan = user[0][0]['id_perusahaan'];
                    String posisi = posisiController.text;
                    String lokasi = lokasiPekerjaanController.text;
                    String jobDetails = jobDetailsController.text;
                    String requirements = requirementsController.text;

                    postJob(
                        idPerusahaan, posisi, lokasi, jobDetails, requirements);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: succesColor,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 50,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'post job',
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontFamily: 'poppins',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 200),
            ],
          )),
    );
  }
}
