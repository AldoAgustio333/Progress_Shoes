import 'package:flutter/material.dart';
import 'store_page.dart';
import 'search_page.dart';
import 'riwayat_page.dart';
import 'package:provider/provider.dart';
import 'models/cart_model.dart';
import 'models/history_model.dart';

void main() {
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<String> produkUtama = [
    'Tas Gunung Eiger',
    'Sepatu Hiking',
    'Jaket Waterproof',
    'Kacamata Polarized',
    'Kompas Digital',
  ];

  final List<String> produkRekomendasi = [
    'Carrier 45L',
    'Tenda Dome 2P',
    'Senter LED Tahan Air',
    'Sarung Tangan Outdoor',
    'Kaos Quick Dry',
  ];

  final List<Widget> _pages = [
    HomeContent(),
    SearchPage(),
    StorePage(),
    RiwayatPage(),
    Center(child: Text('Profile Page')), // Ganti dengan halaman profil jika ada
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _selectedIndex == 2 ? Colors.orange : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.store,
                color: _selectedIndex == 2 ? Colors.white : Colors.grey,
                size: 30,
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final produkUtama = [
      'Tas Gunung Eiger',
      'Sepatu Hiking',
      'Jaket Waterproof',
      'Kacamata Polarized',
      'Kompas Digital',
    ];

    final produkRekomendasi = [
      'Carrier 45L',
      'Tenda Dome 2P',
      'Senter LED Tahan Air',
      'Sarung Tangan Outdoor',
      'Kaos Quick Dry',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'EIGER',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cart diklik!')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/banner.png', width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 20),

            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: produkUtama.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/product${index + 1}.png',
                                fit: BoxFit.contain,
                                height: 80,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            produkUtama[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Rekomendasi produk untukmu',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    'Lihat lainnya',
                    style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            SizedBox(
              height: 210,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: produkRekomendasi.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 160,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[200],
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/popular${index + 1}.png',
                                fit: BoxFit.contain,
                                height: 80,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            produkRekomendasi[index],
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Produk original berkualitas',
                            style: TextStyle(fontSize: 8, color: Colors.grey),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Rp 150.000',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
            Image.asset('assets/images/banner2.png', width: double.infinity, fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}
