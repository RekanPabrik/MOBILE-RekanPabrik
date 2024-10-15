part of '../page.dart';

class riwayatLamaran extends StatefulWidget {
  const riwayatLamaran({super.key});

  @override
  State<riwayatLamaran> createState() => _riwayatLamaranState();
}

class _riwayatLamaranState extends State<riwayatLamaran> {
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
                        "Application History",
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
                        width: 350, // Sesuaikan dengan kebutuhan
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "Your application history gives you a complete overview of the jobs you've applied for on Rekan Pabrik. Stay organized and up-to-date by reviewing the status of each application, from submission to final decision. We’re here to help you stay on top of your job search and keep moving forward.",
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
                    SizedBox(
                      height: 30,
                    ),
                    searchBarRiwayatLamaran(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          )),
      //bottomNavigationBar: navbarComponent(),
    );
  }
}
