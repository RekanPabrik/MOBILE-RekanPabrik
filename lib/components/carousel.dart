import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rekanpabrik/shared/shared.dart';

class Carousel extends StatefulWidget {
  final List<Map<String, dynamic>> dummyPerusahaan;

  const Carousel({super.key, required this.dummyPerusahaan});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentSlideIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Memastikan hanya 5 data yang ditampilkan meskipun lebih banyak di dummyPerusahaan
    List<Map<String, dynamic>> perusahaanTerbatas =
        widget.dummyPerusahaan.length > 5
            ? widget.dummyPerusahaan.sublist(0, 5)
            : widget.dummyPerusahaan;

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            enlargeCenterPage: false,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayInterval: Duration(seconds: 3),
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              setState(() {
                _currentSlideIndex = index; // Menyimpan indeks slide aktif
              });
            },
          ),
          items: perusahaanTerbatas.map((company) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: thirdColor, // Warna border
                      width: 2.0, // Ketebalan border
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          company['img'],
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          company['nama'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        // Container untuk jumlah lowongan dengan background dan border radius
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 6.0),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(
                                217, 217, 217, 100), // Warna latar belakang
                            borderRadius: BorderRadius.circular(10), // Radius
                          ),
                          child: Text(
                            "${company['jumlahLowongan']} Lowongan",
                            style: TextStyle(
                              fontSize: 14,
                              color: blackColor, // Warna teks
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        // Indikator Slide
      ],
    );
  }
}
