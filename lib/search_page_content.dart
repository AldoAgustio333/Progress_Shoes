// lib/search_page_content.dart
import 'package:flutter/material.dart';
import '../models/product.dart'; // Import Product model
import 'product_detail_page.dart'; // Import ProductDetailPage
// Tidak perlu mengimpor dummy_products.dart jika Anda ingin menggunakan data lokal di sini
// Tetapi, disarankan untuk konsistensi data dari dummy_products.dart

class SearchPageContent extends StatefulWidget {
  const SearchPageContent({super.key});

  @override
  State<SearchPageContent> createState() => _SearchPageContentState();
}

class _SearchPageContentState extends State<SearchPageContent> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Mengubah data produk agar menggunakan model Product
  // Sebaiknya, data ini juga diambil dari dummy_products.dart untuk konsistensi
  // Tapi untuk tujuan demonstrasi, kita bisa biarkan di sini dengan tipe Product
  final List<Product> products = [
    Product(
      image: 'assets/images/product1.png',
      name: 'Sepatu Gunung',
      desc: 'Sepatu tahan air dan kokoh untuk pendakian gunung.',
      price: 499000.0,
      imageSide: 'assets/images/sepatu_side.png', // Tambahkan jika ada
      imageBack: 'assets/images/sepatu_back.png', // Tambahkan jika ada
      imageTop: 'assets/images/sepatu_atas.png', // Tambahkan jika ada
      imageBottom: 'assets/images/sepatu_bottom.png', // Tambahkan jika ada
    ),
    Product(
      image: 'assets/images/product2.png',
      name: 'Sneaker Kasual',
      desc: 'Sepatu santai untuk aktivitas sehari-hari.',
      price: 399000.0,
      imageSide: 'assets/images/sepatu_side.png',
      imageBack: 'assets/images/sepatu_back.png',
      imageTop: 'assets/images/sepatu_atas.png',
      imageBottom: 'assets/images/sepatu_bottom.png',
    ),
    Product(
      image: 'assets/images/product3.png',
      name: 'Boots Eiger',
      desc: 'Boots tangguh untuk petualangan outdoor.',
      price: 629000.0,
      imageSide: 'assets/images/sepatu_side.png',
      imageBack: 'assets/images/sepatu_back.png',
      imageTop: 'assets/images/sepatu_atas.png',
      imageBottom: 'assets/images/sepatu_bottom.png',
    ),
    Product(
      image: 'assets/images/product4.png',
      name: 'Sepatu Hiking',
      desc: 'Sepatu ringan dan nyaman untuk hiking jalur ringan.',
      price: 579000.0,
      imageSide: 'assets/images/sepatu_side.png',
      imageBack: 'assets/images/sepatu_back.png',
      imageTop: 'assets/images/sepatu_atas.png',
      imageBottom: 'assets/images/sepatu_bottom.png',
    ),
    Product(
      image: 'assets/images/product5.png',
      name: 'Trail Runner',
      desc: 'Sepatu khusus lari di jalur off-road.',
      price: 459000.0,
      imageSide: 'assets/images/sepatu_side.png',
      imageBack: 'assets/images/sepatu_back.png',
      imageTop: 'assets/images/sepatu_atas.png',
      imageBottom: 'assets/images/sepatu_bottom.png',
    ),
    Product(
      name: 'Tas Eiger 1',
      price: 500000.0,
      desc: 'Tas kuat untuk hiking',
      image: 'assets/images/sepatu_atas.png', // Asumsi ada gambar tas
      imageSide: 'assets/images/sepatu_side.png',
      imageBack: 'assets/images/sepatu_back.png',
      imageTop: 'assets/images/sepatu_atas.png',
      imageBottom: 'assets/images/sepatu_bottom.png',
    ),
    Product(
      name: 'Sepatu Nike Air',
      price: 1500000.0,
      desc: 'Sepatu nyaman untuk olahraga',
      image: 'assets/images/sepatu_back.png', // Asumsi ada gambar sepatu lain
      imageSide: 'assets/images/sepatu_side.png',
      imageBack: 'assets/images/sepatu_back.png',
      imageTop: 'assets/images/sepatu_atas.png',
      imageBottom: 'assets/images/sepatu_bottom.png',
    ),
    Product(
      image: 'assets/images/product1.png',
      name: 'Sepatu Tactical',
      desc: 'Kuat & awet untuk medan berat.',
      price: 549000.0,
      imageSide: 'assets/images/sepatu_side.png',
      imageBack: 'assets/images/sepatu_back.png',
      imageTop: 'assets/images/sepatu_atas.png',
      imageBottom: 'assets/images/sepatu_bottom.png',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    // Filter produk berdasarkan input
    final List<Product> filteredProducts = _searchQuery.isEmpty
        ? []
        : products
            .where((product) =>
                product.name.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
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
                  const Icon(Icons.search, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: filteredProducts.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    const Text(
                      'Masukkan nama produk untuk mencari.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Misalnya: Sepatu Gunung, Tas Eiger, Jaket.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return GestureDetector( // <-- Pembungkus GestureDetector ditambahkan di sini
                    onTap: () {
                      // Logika navigasi ke halaman detail produk
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(product: product),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                product.image, // Menggunakan product.image
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name, // Menggunakan product.name
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    product.desc, // Menggunakan product.desc
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 2, // Batasi jumlah baris deskripsi
                                    overflow: TextOverflow.ellipsis, // Tambahkan ellipsis
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rp${product.price.toStringAsFixed(0)}', // Menggunakan product.price
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}