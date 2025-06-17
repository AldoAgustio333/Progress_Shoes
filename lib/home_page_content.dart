// lib/home_page_content.dart
import 'package:flutter/material.dart';
import 'CartPage.dart';
import '../data/dummy_products.dart'; // Import dummy_products.dart
import '../models/product.dart'; // Import Product model
import 'product_detail_page.dart'; // Import ProductDetailPage

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Kita akan menggunakan daftar produk dari dummy_products.dart
    // untuk memastikan konsistensi dan kemampuan navigasi ke detail produk.
    // Jika Anda ingin membedakan produk utama dan rekomendasi, Anda bisa membuat
    // list baru dari sebagian produk yang ada di dummy_products.dart atau
    // menambahkan properti kategori pada model Product.
    // Untuk contoh ini, kita ambil beberapa produk dari daftar dummy_products.dart.

    // Contoh pengambilan produk untuk "Produk Utama"
    final List<Product> produkUtama = products.sublist(0, 5); // Ambil 5 produk pertama

    // Contoh pengambilan produk untuk "Produk Rekomendasi"
    final List<Product> produkRekomendasi = products.sublist(5); // Ambil sisanya

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Agar judul dan banner rata kiri
          children: [
            Image.asset('assets/images/banner.png', width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 20),

            // Bagian Produk Utama
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Produk Pilihan EIGER',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180, // Tinggi disesuaikan agar gambar dan teks tidak terpotong
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: produkUtama.length,
                itemBuilder: (context, index) {
                  final product = produkUtama[index];
                  return GestureDetector( // Wrapper untuk membuat item dapat ditekan
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(product: product),
                        ),
                      );
                    },
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                        ],
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
                                  // Menggunakan image dari objek product
                                  product.image,
                                  fit: BoxFit.contain,
                                  height: 80,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              product.name, // Menggunakan nama dari objek product
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14, // Ukuran font disesuaikan
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1, // Batasi 1 baris
                              overflow: TextOverflow.ellipsis, // Tambahkan ellipsis jika terlalu panjang
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Rp${product.price.toStringAsFixed(0)}', // Tampilkan harga
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
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
                children: [
                  const Text(
                    'Rekomendasi produk untukmu',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  GestureDetector( // Menambahkan GestureDetector ke "Lihat lainnya"
                    onTap: () {
                      // Ini bisa diatur untuk navigasi ke StorePage atau halaman kategori
                      // Untuk contoh, kita akan navigasi ke StorePage (jika ada)
                      // Anda perlu mengimpor StorePageContent jika ingin ke sana.
                      // Import 'store_page_content.dart' di bagian atas jika ingin ini.
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const StorePageContent()));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Fitur "Lihat lainnya" belum diimplementasikan!')),
                      );
                    },
                    child: const Text(
                      'Lihat lainnya',
                      style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
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
                  final product = produkRekomendasi[index];
                  return GestureDetector( // Wrapper untuk membuat item dapat ditekan
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(product: product),
                        ),
                      );
                    },
                    child: Container(
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
                                  product.image, // Menggunakan image dari objek product
                                  fit: BoxFit.contain,
                                  height: 80,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              product.name, // Menggunakan nama dari objek product
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.desc, // Menggunakan deskripsi dari objek product
                              style: const TextStyle(fontSize: 10, color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Rp${product.price.toStringAsFixed(0)}', // Menampilkan harga dari objek product
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
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

            const SizedBox(height: 20),
            Image.asset('assets/images/banner2.png', width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 20), // Tambahkan sedikit padding di bawah
          ],
        ),
      ),
    );
  }
}