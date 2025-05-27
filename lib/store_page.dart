import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../data/dummy_products.dart'; // Pastikan di sini sudah List<Product>
import 'search_page.dart';
import 'product_detail_page.dart';
import 'main.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cart_model.dart';

import 'CartPage.dart';
=======
import '../data/dummy_products.dart';
import 'search_page.dart';
import 'product_detail_page.dart';
import 'main.dart';
>>>>>>> b6e7478ddba09568659a861adec3d706e16e5b8b

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

<<<<<<< HEAD
  // Ubah ke List<Product>
  List<Product> get filteredProducts {
    return _searchQuery.isEmpty
        ? products
        : products.where((product) =>
        product.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }


=======
  // Filter produk berdasarkan input pencarian
  List<Map<String, dynamic>> get filteredProducts {
    return _searchQuery.isEmpty
        ? products
        : products
        .where((product) =>
        product['name'].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

>>>>>>> b6e7478ddba09568659a861adec3d706e16e5b8b
  @override
  Widget build(BuildContext context) {
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
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
<<<<<<< HEAD
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
=======
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cart diklik!')),
>>>>>>> b6e7478ddba09568659a861adec3d706e16e5b8b
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row Filter & Search
              Row(
                children: [
                  // Tombol Filter
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.filter_list, color: Colors.white),
                        SizedBox(width: 6),
                        Text(
                          'Filter',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Search Box
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                hintText: 'Cari produk...',
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.search, color: Colors.orange),
<<<<<<< HEAD
                            onPressed: () {},
=======
                            onPressed: () {
                              // Aksi pencarian sudah ditangani dengan onChanged pada TextField
                            },
>>>>>>> b6e7478ddba09568659a861adec3d706e16e5b8b
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Menampilkan produk yang sudah difilter
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.7,
                children: List.generate(filteredProducts.length, (index) {
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(product: product),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              child: Image.asset(
<<<<<<< HEAD
                                product.image,
=======
                                product['image'],
>>>>>>> b6e7478ddba09568659a861adec3d706e16e5b8b
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
<<<<<<< HEAD
                                  product.name,
=======
                                  product['name'],
>>>>>>> b6e7478ddba09568659a861adec3d706e16e5b8b
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
<<<<<<< HEAD
                                  product.desc,
=======
                                  product['desc'],
>>>>>>> b6e7478ddba09568659a861adec3d706e16e5b8b
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: 100,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 8),
                                      child: Text(
<<<<<<< HEAD
                                        product.price.toString(),
=======
                                        product['price'],
>>>>>>> b6e7478ddba09568659a861adec3d706e16e5b8b
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
<<<<<<< HEAD

=======
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            // Pindah ke halaman utama (HomePage)
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()),
            );
          } else if (index == 1) {
            // Pindah ke halaman SearchPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
          } else if (index == 2) {
            // Pindah ke halaman StorePage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StorePage()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tab ke-$index ditekan')),
            );
          }
        },
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
>>>>>>> b6e7478ddba09568659a861adec3d706e16e5b8b
    );
  }
}
