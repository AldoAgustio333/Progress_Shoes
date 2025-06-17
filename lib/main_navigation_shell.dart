import 'package:flutter/material.dart';
import 'home_page_content.dart'; // Import halaman Home
import 'search_page_content.dart'; // Import halaman Search
import 'store_page_content.dart'; // Import halaman Store
// Tambahkan import untuk halaman Riwayat dan Profile jika sudah ada
// import 'history_page.dart';
// import 'profile_page.dart';

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0; // Index halaman yang sedang aktif

  // Daftar halaman yang akan ditampilkan di body
  final List<Widget> _pages = [
    const HomePageContent(), // Konten Home yang asli (akan kita buat di bawah)
    const SearchPageContent(), // Konten Search (akan kita buat di bawah)
    const StorePageContent(), // Konten Store (akan kita buat di bawah)
    const Center(child: Text('Halaman Riwayat')), // Placeholder Riwayat
    const Center(child: Text('Halaman Profil')), // Placeholder Profil
  ];

  // Fungsi yang dipanggil saat item BottomNavigationBar ditekan
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar akan diatur di setiap "konten" halaman jika berbeda, atau bisa di sini jika sama
      // Untuk kesederhanaan, kita bisa biarkan AppBar di dalam HomePageContent, SearchPageContent, dan StorePageContent
      // Atau bisa juga memindahkan AppBar ke sini jika AppBarnya selalu sama di semua tab utama.
      // Untuk kasus ini, karena AppBar Anda berbeda (misal, ada search bar di search_page), kita biarkan di halaman masing-masing.

      body: IndexedStack( // Menggunakan IndexedStack untuk mempertahankan state halaman
        index: _currentIndex,
        children: _pages,
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Mengatur item yang aktif
        onTap: _onItemTapped, // Ketika item ditekan, panggil fungsi ini
        selectedItemColor: Colors.orange, // Warna item yang terpilih
        unselectedItemColor: Colors.grey, // Warna item yang tidak terpilih
        showUnselectedLabels: true, // Tampilkan label untuk item yang tidak terpilih
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          // Tombol "Store" dengan lingkaran kuning
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (_currentIndex == 2) ? Colors.orange : Colors.transparent, // Warna kuning jika aktif
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.store,
                color: (_currentIndex == 2) ? Colors.white : Colors.grey, // Warna ikon putih jika aktif, abu-abu jika tidak
                size: 35,
              ),
            ),
            label: 'Toko', // Tambahkan label untuk kejelasan
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