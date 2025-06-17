// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // <-- DITAMBAHKAN: Import Firebase Core
import 'firebase_options.dart';                   // <-- DITAMBAHKAN: Import file konfigurasi Firebase

// Import model Anda
import 'models/cart_model.dart';
import 'models/history_model.dart';
import 'models/product.dart';

// Impor halaman-halaman dari root lib/
import 'CartPage.dart';
import 'checkout_page.dart';
import 'detail_riwayat_page.dart';
import 'halaman_chat_toko.dart';
import 'halaman_toko.dart'; // Jika masih ada dan digunakan
import 'product_detail_page.dart';
import 'riwayat_page.dart';
import 'profile_page.dart';

// Impor halaman-halaman konten yang baru (tanpa BottomNavigationBar)
import 'home_page_content.dart'; // HomePageContent
import 'search_page_content.dart'; // SearchPageContent
import 'store_page_content.dart'; // StorePageContent

// Impor halaman-halaman dari screens/
import 'catalog.dart'; // Jika ini adalah file catalog.dart
import 'order_detail_page.dart';


// <-- DITAMBAHKAN: 'async' agar bisa menggunakan 'await'
void main() async {
  // <-- DITAMBAHKAN: Memastikan Flutter siap sebelum menjalankan kode async
  WidgetsFlutterBinding.ensureInitialized();
  
  // <-- DITAMBAHKAN: Menginisialisasi Firebase dengan konfigurasi platform saat ini
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartModel()),
        ChangeNotifierProvider(create: (_) => HistoryModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eiger Footwear',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        hintColor: Colors.grey.shade400,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const MyHomePage(),
        '/cart': (context) => CartPage(),
        '/checkout': (context) => CheckoutPage(),
        '/riwayat': (context) => RiwayatPage(),
        '/detail_riwayat': (context) => DetailRiwayatPage(item: ModalRoute.of(context)!.settings.arguments as CartItem),
        '/halaman_chat_toko': (context) => HalamanChatToko(),
        '/catalog': (context) => CatalogPage(),
        '/order_detail': (context) => OrderDetailPage(),
        '/profile': (context) => const ProfilePage(),

        '/product_detail': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is Product) {
            return ProductDetailPage(product: args);
          }
          return const Text('Error: Product detail not found');
        },
      },
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
              Color(0xFFFF9800),
              Color(0xFFFFB74D),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/eiger_logo_full.png',
                height: 80,
              ),
              const SizedBox(height: 16),
              const Text(
                'EIGER',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const Text(
                'FOOTWEAR',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 24,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
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

// MyHomePage (Shell Navigasi Utama)
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePageContent(),
    const SearchPageContent(),
    const StorePageContent(),
    RiwayatPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: (_selectedIndex == 0) ? Colors.orange : Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: (_selectedIndex == 1) ? Colors.orange : Colors.grey),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.store,
                color: Colors.white,
                size: 35,
              ),
            ),
            label: 'Toko',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, color: (_selectedIndex == 3) ? Colors.orange : Colors.grey),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: (_selectedIndex == 4) ? Colors.orange : Colors.grey),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}