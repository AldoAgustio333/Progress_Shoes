import 'package:flutter/material.dart';

class HalamanToko extends StatelessWidget {
  const HalamanToko({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'EIGER',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView( // Menggunakan SingleChildScrollView untuk memungkinkan scrolling

        child: Column(
          children: [
            // Banner Gambar
            Image.asset(
              'assets/images/toko.png', // Menggunakan gambar dari assets/images
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),

            // Nama Toko
            const Text(
              'EIGER Store',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Kolom pertama (Gambar di kiri, Teks di kanan)

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                // Gambar Kiri
                Image.asset(
                  'assets/images/toko.png', // Menggunakan gambar dari assets/images
                  width: 120,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                // Teks Kanan
                const Expanded(

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Where Outdoor Passion Meets Experiential Customer Satisfaction Where Outdoor Passion Meets Experiential Customer Satisfaction Take a look inside PT Eigerindo MPI and revel in the fun of exploring. Uniting our passionfor outdoor adventure and commitment to provide ',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Kolom kedua (Teks di kiri, Gambar di kanan)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Teks Kiri
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Where Outdoor Passion Meets Experiential Customer Satisfaction Where Outdoor Passion Meets Experiential Customer Satisfaction Take a look inside PT Eigerindo MPI and revel in the fun of exploring. Uniting our passionfor outdoor adventure and commitment to provide ',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                // Gambar Kanan
                Image.asset(
                  'assets/images/toko.png', // Menggunakan gambar dari assets/images
                  width: 120,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Konten lainnya bisa ditambahkan di sini
          ],
        ),
      ),
    );
  }
}
