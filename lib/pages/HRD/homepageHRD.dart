part of '../page.dart';

class Homepagehrd extends StatefulWidget {
  const Homepagehrd({super.key});

  @override
  State<Homepagehrd> createState() => _HomepagehrdState();
}

class _HomepagehrdState extends State<Homepagehrd> {
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
              height: 30,
            ),
            Center(
              child: Container(
                width: 350,
                height: 120, // Sesuaikan tinggi untuk menampung teks tambahan
                decoration: BoxDecoration(
                  color: thirdColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 30,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Membuat kolom di sebelah kiri untuk teks "Welcome" dan nama user
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Agar teks rata kiri
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Vertikal di tengah
                      children: [
                        Text(
                          "Welcome back!",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'poppins',
                            fontSize:
                                14, // Ukuran font lebih kecil untuk "Welcome"
                            fontWeight:
                                FontWeight.w400, // Berat font lebih ringan
                          ),
                        ),
                        SizedBox(
                            height: 5), // Jarak antara "Welcome" dan nama user
                        Text(
                          "Nama User",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // Avatar berada di kanan
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.green,
                      backgroundImage: AssetImage('assets/img/dapa.png'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: primaryColor, // Background color grey
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: thirdColor, // Warna border
                  width: 2.0, // Ketebalan border
                ), // Border radius 10
              ),
              child: Column(
                children: [
                  // Foto di dalam container
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        8), // Membuat foto berbentuk rounded
                    child: Image.asset(
                      'assets/img/Image1.png', // Path ke foto Anda
                      height: 200, // Tinggi foto
                      width: 500, // Lebar foto
                      fit: BoxFit.fill, // Menjaga proporsi foto
                    ),
                  ),
                  SizedBox(height: 30), // Jarak antara foto dan teks
                  // Tulisan di bawah foto
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 250,
                      child: Text(
                        "look for suitable candidates",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'poppins',
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 250,
                      child: Text(
                        "get applicants easily",
                        style: TextStyle(
                          color: greyColor,
                          fontFamily: 'poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: thirdColor,
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 50,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'post application',
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: primaryColor, // Background color grey
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: thirdColor, // Warna border
                  width: 2.0, // Ketebalan border
                ), // Border radius 10
              ),
              child: Column(
                children: [
                  // Foto di dalam container
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        8), // Membuat foto berbentuk rounded
                    child: Image.asset(
                      'assets/img/Image2.png', // Path ke foto Anda
                      height: 200, // Tinggi foto
                      width: 500, // Lebar foto
                      fit: BoxFit.fill, // Menjaga proporsi foto
                    ),
                  ),
                  SizedBox(height: 30), // Jarak antara foto dan teks
                  // Tulisan di bawah foto
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 250,
                      child: Text(
                        "check your application",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'poppins',
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 250,
                      child: Text(
                        "check to see if there are interested candidates",
                        style: TextStyle(
                          color: greyColor,
                          fontFamily: 'poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: thirdColor,
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 50,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'applicant post',
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ),
                  ),
                ],
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
