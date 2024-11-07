part of '../page.dart';

class savedJobs extends StatefulWidget {
  const savedJobs({super.key});

  @override
  State<savedJobs> createState() => _savedJobsState();
}

class _savedJobsState extends State<savedJobs> {

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
                        "Your Saved Jobs",
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
                                    "Keep Track of Opportunities That Matter", // Teks yang di-bold
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.bold, // Membuat teks bold
                                  color: thirdColor,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "The jobs you've saved are right here, ready for when you’re ready to take the next step. At",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: thirdColor,
                                ),
                              ),
                              TextSpan(
                                text: " RekanPabrik", // Teks yang di-bold
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.bold, // Membuat teks bold
                                  color: thirdColor,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ", we understand how important it is to stay organized in your job search. With your saved jobs, you can easily return to the opportunities that catch your eye.",
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
                    searchBarSavedJobs(),
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
