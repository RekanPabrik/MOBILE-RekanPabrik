part of 'page.dart';

class WellcomePage extends StatelessWidget {
  const WellcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 30),
          children: [
            Image.asset(
              'assets/img/logoRekanPabrik.png',
              height: 300,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Wellcome",
              style: TextStyle(
                  color: thirdColor,
                  fontFamily:
                      'poppins', // Ganti dengan warna yang Anda inginkan
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,",
              style: TextStyle(
                  fontFamily: 'poppins', color: blackColor, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width - 2 * 23,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registerPelamar');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  backgroundColor: thirdColor,
                ),
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 20,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width - 2 * 23,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.transparent, // Latar belakang transparan
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: thirdColor, // Warna border coklat
                      width: 2, // Ketebalan border
                    ),
                  ),
                  elevation:
                      0, // Hilangkan bayangan agar benar-benar transparan
                ),
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 20,
                    color: thirdColor, // Warna teks tetap
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
