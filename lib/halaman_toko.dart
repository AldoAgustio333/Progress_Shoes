import 'package:flutter/material.dart';

class HalamanToko extends StatelessWidget {
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
      body: SingleChildScrollView( 
        child: Column(
          children: [

            Image.asset(
              'assets/images/toko.png', 
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),

            const Text(
              'EIGER Store',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/toko.png', 
                  width: 120,
                  height: 200,
                  fit: BoxFit.cover,
                ),

                const Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Temukan berbagai produk outdoor berkualitas di EIGER. Kami menyediakan perlengkapan hiking, camping, dan banyak lagi.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Jelajahi koleksi kami untuk mendapatkan perlengkapan outdoor yang tepat untuk petualangan Anda. Semua produk kami dirancang untuk kenyamanan dan ketahanan.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),

                Image.asset(
                  'assets/images/toko.png', 
                  width: 120,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}
