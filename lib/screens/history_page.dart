// history_page.dart
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 2; // Menandai Riwayat aktif

  // Contoh data riwayat pesanan (ganti dengan data sebenarnya dari API atau state aplikasi Anda)
  final List<Map<String, dynamic>> _orderHistory = [
    {
      'status': 'Semua',
      'date': '16 Maret 2025',
      'image':
          'assets/images/bryce_lowcut.png', // Ganti dengan path gambar produk
      'name': 'BRYCE LOWCUT',
      'stock': 1,
      'color': 'TAN',
      'size': 43,
      'price': 529000,
      'deliveryStatus': 'Barang Telah Sampai Lokasi Pengiriman',
    },
    // Tambahkan riwayat pesanan lainnya di sini dengan berbagai status
    {
      'status': 'Belum Bayar',
      'date': '10 Maret 2025',
      'image': 'assets/images/bryce_lowcut.png', // Contoh gambar lain
      'name': 'SEPATU OUTDOOR X',
      'stock': 1,
      'color': 'HITAM',
      'size': 41,
      'price': 499000,
      'deliveryStatus': 'Menunggu Pembayaran',
    },
  ];

  List<Map<String, dynamic>> get _allOrders => _orderHistory;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 5,
      vsync: this,
    ); // Sesuaikan length dengan jumlah tab
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pop(
          context,
        ); // Kembali ke halaman sebelumnya (Home atau Search)
      } else if (index == 1) {
        Navigator.pushNamed(context, '/search');
      }
      // index 2 tetap di halaman riwayat, index 3 ke profile (jika ada)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Image.asset(
          'assets/images/eiger_logo_white.png', // Ganti dengan path logo Eiger putih Anda
          height: 30,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Cari riwayat...',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (value) {
                      // Implementasikan logika pencarian riwayat pesanan
                    },
                  ),
                ),
                SizedBox(height: 8),
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.orange, width: 2.0),
                    ),
                  ),
                  labelColor: Colors.orange,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: 'Semua'),
                    Tab(text: 'Belum Bayar'),
                    Tab(text: 'Sedang Dikemas'),
                    Tab(text: 'Dikirim'),
                    Tab(text: 'Selesai'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(_allOrders),
          Center(child: Text('Belum Bayar')),
          Center(child: Text('Sedang Dikemas')),
          Center(child: Text('Dikirim')),
          Center(child: Text('Selesai')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Riwayat'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<Map<String, dynamic>> orders) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  order['date'],
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Image.asset(
                      order['image'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            order['name'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Warna: ${order['color']}, Ukuran: ${order['size']}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            order['deliveryStatus'],
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Rp. ${order['price'].toStringAsFixed(0)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/order_detail',
                          arguments: order,
                        ); // Kirim data pesanan
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.orange),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Review Sekarang',
                        style: TextStyle(color: Colors.orange),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Tambahkan item ke keranjang dan/atau navigasi ke halaman produk
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text('Beli Lagi'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
