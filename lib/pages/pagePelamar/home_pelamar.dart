part of '../page.dart';

class home_pelamar extends StatefulWidget {
  const home_pelamar({super.key});

  @override
  State<home_pelamar> createState() => _homePelamar();
}

class _homePelamar extends State<home_pelamar> {
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
            Container(
              child: Text(
                "Find your next company!",
                style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              child: Text(
                "Browse company profiles to find the right workplace for you. Learn about jobs, reviews, company culture, benefits and perks.",
                style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Carousel(
              dummyPerusahaan: dummyPerusahaan,
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cariPabrik');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.white, // Warna background tombol menjadi putih
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 30,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Membuat border radius
                    side: BorderSide(
                      color: Colors.black, // Warna border menjadi hitam
                      width: 2.0, // Ketebalan border
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min, // Agar Row tidak memenuhi lebar penuh
                  children: [
                    Text(
                      'See More',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black, // Warna teks tetap hitam
                        fontFamily: 'poppins',
                      ),
                    ),
                    SizedBox(width: 8), // Jarak antara teks dan ikon panah
                    Icon(
                      Icons.arrow_forward, // Panah ke kanan
                      color: Colors.black, // Warna panah hitam
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Containerhomepelamar(
                textSatu: "“Hello” Better career!",
                textDua: "Get your dream career here",
                imgLinkk: 'assets/img/Image1.png'),
            SizedBox(
              height: 20,
            ),
            Containerhomepelamar(
                textSatu: "“Hello” Better matching candidate!",
                textDua: "Get your company's employee candidates here",
                imgLinkk: 'assets/img/Image2.png'),
            SizedBox(
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}
