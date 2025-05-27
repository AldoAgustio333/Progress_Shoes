import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eiger Footwear',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF9800), // Warna oranye atas
              Color(0xFFFFB74D), // Warna oranye bawah
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo Eiger (Anda perlu menyediakan file aset gambar untuk logo)
              Image.asset(
                'assets/eiger_logo.png', // Ganti dengan path yang benar ke logo Anda
                height: 80,
              ),
              const SizedBox(height: 16),
              const Text(
                'EIGER',
                style: TextStyle(
                  fontFamily:
                      'Sans Serif', // Ganti dengan font yang sesuai jika ada
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const Text(
                'FOOTWEAR',
                style: TextStyle(
                  fontFamily:
                      'Sans Serif', // Ganti dengan font yang sesuai jika ada
                  fontSize: 24,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  // Tambahkan logika navigasi ke halaman berikutnya di sini
                  print('Get Started button pressed');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
