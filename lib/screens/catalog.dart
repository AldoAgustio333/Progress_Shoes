import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eiger Footwear - Katalog',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        hintColor: Colors.grey.shade400,
        fontFamily: 'Roboto', // Anda mungkin perlu menyesuaikan font
      ),
      home: CatalogPage(),
    );
  }
}

class CatalogPage extends StatefulWidget {
  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _products =
      []; // Daftar untuk menyimpan data produk

  // Contoh data produk (ganti dengan data sebenarnya dari API atau sumber data Anda)
  final List<Map<String, dynamic>> _dummyProducts = [
    {
      'image':
          'assets/images/bryce_lowcut.png', // Ganti dengan path gambar produk
      'name': 'BRY LOWCUT',
      'description': 'Alas Kaki - Sepatu',
      'price': 'Rp. 520.000',
    },
    {
      'image': 'assets/images/bryce_lowcut.png',
      'name': 'SALVAGE SLIP ON',
      'description': 'Alas Kaki - Sepatu',
      'price': 'Rp. 520.000',
    },
    {
      'image': 'assets/images/bryce_lowcut.png',
      'name': 'FREYR',
      'discount': '20%',
      'description': 'Alas Kaki - Sepatu',
      'price': 'Rp. 520.000',
    },
    {
      'image': 'assets/images/bryce_lowcut.png',
      'name': 'SERVAL MID MEN',
      'description': 'Alas Kaki - Sepatu',
      'price': 'Rp. 520.000',
    },
    // Tambahkan lebih banyak data produk dummy di sini
  ];

  String? _selectedFilter; // Untuk menyimpan filter yang dipilih

  @override
  void initState() {
    super.initState();
    _products = _dummyProducts; // Inisialisasi daftar produk
  }

  void _applyFilter(String? filter) {
    setState(() {
      _selectedFilter = filter;
      // Implementasikan logika pemfilteran produk berdasarkan _selectedFilter di sini
      // Contoh sederhana (Anda perlu menyesuaikannya):
      if (filter == 'Pria') {
        _products =
            _dummyProducts.where((p) => p['name'].contains('MEN')).toList();
      } else {
        _products = _dummyProducts; // Reset ke semua produk
      }
    });
  }

  void _performSearch(String query) {
    setState(() {
      _products =
          _dummyProducts
              .where(
                (product) =>
                    product['name'].toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
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
              // Tambahkan logika keranjang belanja
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        // Tambahkan logika filter
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  title: Text('Semua Kategori'),
                                  onTap: () {
                                    _applyFilter(null);
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: Text('Pria'),
                                  onTap: () {
                                    _applyFilter('Pria');
                                    Navigator.pop(context);
                                  },
                                ),
                                // Tambahkan opsi filter lainnya di sini
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.tune_outlined, color: Colors.orange),
                      label: Text(
                        'Filter',
                        style: TextStyle(color: Colors.orange),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.orange),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: TextField(
                          controller: _searchController,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Search here',
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          onChanged: (value) {
                            _performSearch(value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                if (_selectedFilter != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Chip(
                          label: Text(_selectedFilter!),
                          onDeleted: () {
                            _applyFilter(null);
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(product['image'], fit: BoxFit.cover),
                      ),
                    ),
                    if (product['discount'] != null)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${product['discount']}',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        product['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product['description'],
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        product['price'],
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        currentIndex:
            0, // Menandai item "Home" sebagai aktif (sesuaikan jika ini bukan halaman utama)
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
