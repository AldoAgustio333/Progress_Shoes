import 'package:flutter/material.dart';
import 'home_page_content.dart'; 
import 'search_page_content.dart'; 
import 'store_page_content.dart'; 

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0; 

  final List<Widget> _pages = [
    const HomePageContent(), 
    const SearchPageContent(), 
    const StorePageContent(), 
    const Center(child: Text('Halaman Riwayat')), 
    const Center(child: Text('Halaman Profil')), 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: IndexedStack( 
        index: _currentIndex,
        children: _pages,
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, 
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
                color: (_currentIndex == 2) ? Colors.orange : Colors.transparent, 
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.store,
                color: (_currentIndex == 2) ? Colors.white : Colors.grey, 
                size: 35,
              ),
            ),
            label: 'Toko', 
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