// main.dart
import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/history_page.dart';
import 'screens/order_detail_page.dart';
import 'screens/cart_page.dart';
import 'screens/checkout.dart';
import 'screens/catalog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eiger Footwear App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        hintColor: Colors.grey.shade400,
        fontFamily: 'Roboto',
      ),
      home: LoadingPage(), // Halaman loading sebagai halaman awal
      routes: {
        '/home': (context) => HomePage(),
        '/history': (context) => HistoryPage(),
        '/order_detail': (context) => OrderDetailPage(),
        '/cart': (context) => CartPage(),
        '/checkout': (context) => CheckoutPage(),
        '/catalog': (context) => CatalogPage(),
      },
    );
  }
}

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/eiger_logo_full.png', // Ganti dengan path logo Eiger full Anda
              height: 150,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  '/home',
                ); // Beralih ke halaman beranda
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text('Get Started', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
