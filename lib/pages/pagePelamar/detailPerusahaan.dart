part of '../page.dart';

class detailPerusahaan extends StatelessWidget {
  final int companyId;

  const detailPerusahaan({Key? key, required this.companyId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Find the company using the ID
    Map<String, dynamic> company = dummyPerusahaan.firstWhere(
      (item) => item['id'] == companyId,
      orElse: () => {
        'id': 0, // or some default ID
        'img': 'assets/img/default_image.png', // path to a default image
        'nama': 'Company Not Found',
        'jumlahLowongan': 0,
      },
    );

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: company != null
          ? Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Align(
                      child: Column(
                    children: [
                      Image.asset(company['img']),
                      SizedBox(height: 20),
                      Text(
                        company['nama'],
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          '${company['alamat']} Lowongan',
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${company['about']}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 20),
                              // Container untuk jumlah lowongan
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5), // Padding di dalam Container
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(217, 217, 217,
                                      100), // Warna latar belakang
                                  borderRadius: BorderRadius.circular(
                                      10), // Border radius
                                ),
                                child: Text(
                                  '${company['jumlahLowongan']} Lowongan',
                                  style: TextStyle(
                                    color: Colors.black, // Warna teks
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          : Center(child: Text('Company not found')),
    );
  }
}
