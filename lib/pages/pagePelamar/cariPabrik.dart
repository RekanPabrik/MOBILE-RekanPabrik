part of '../page.dart';

class CariPabrik extends StatefulWidget {
  const CariPabrik({super.key});

  @override
  State<CariPabrik> createState() => _CariPabrik();
}

class _CariPabrik extends State<CariPabrik> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(''),
      ),
      body: SafeArea(
          bottom: true,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Find the Right Factory Job for You",
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
                      child: Text(
                        "Looking for the perfect factory job? Whether you're a skilled laborer or just starting your career, finding the right opportunity can be challenging. Our platform makes it easier by connecting job seekers with top manufacturing companies in the industry.",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: thirdColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              searchBarCariPabrik(),
              SizedBox(
                height: 30,
              ),
            ],
          )),
      //bottomNavigationBar: navbarComponent(),
    );
  }
}
