import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rekanpabrik/components/HRDnavbarComponent.dart';
import 'package:rekanpabrik/components/navbarComponent.dart';
import 'package:rekanpabrik/components/resetPass.dart';
import 'package:rekanpabrik/pages/page.dart';
import 'package:rekanpabrik/pages/testAPI.dart';
import 'package:rekanpabrik/shared/shared.dart';


void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'poppins',
          canvasColor: thirdColor,
          primaryColor: primaryColor,
          appBarTheme: AppBarTheme(backgroundColor: primaryColor),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor:
                Colors.transparent, // Atur coklat sesuai kebutuhanmu
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white,
          )),
      initialRoute: '/',
      routes: {
        '/': (context) => const WellcomePage(),
        '/login': (context) => login_page(),
        '/registerPelamar': (context) => register_pelamar(),
        '/pagePelamar': (context) => navbarComponent(),
        '/cariPabrik': (context) => CariPabrik(),
        '/reserPass': (context) => Resetpass(),
        '/pageHRD': (context) => HRDnavbarComponent(),
        '/cekPelamar': (context) => Cekpelamar(),
      },
    );
  }
}
