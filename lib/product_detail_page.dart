import 'package:flutter/material.dart';
import 'halaman_toko.dart';
import 'halaman_chat_toko.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/cart_model.dart';
import 'CartPage.dart';


class ProductDetailPage extends StatefulWidget {


  final Product product;


  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late String selectedImage;
  late List<String> previewImages;

  @override
  void initState() {
    super.initState();
    selectedImage = widget.product.image;
    previewImages = [
      widget.product.image,
      widget.product.imageSide,
      widget.product.imageBack,
      widget.product.imageTop,
      widget.product.imageBottom,
    ];
  }

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar utama
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.asset(
                selectedImage,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            // Preview thumbnail
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: previewImages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedImage = previewImages[index];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 75,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedImage == previewImages[index]
                              ? Colors.orange
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          previewImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Nama produk dan harga
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.product.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.product.price.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ),

              ],
            ),

            const SizedBox(height: 16),

            // Deskripsi pendek (3 kata)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.product.desc
                    .split(' ')
                    .take(3)
                    .join(' ') + '...',
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),

            ),

            const SizedBox(height: 16),

            // Nama toko + icon
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: const [
                  Icon(Icons.local_fire_department, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'BANDUNG SEPATU',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Section Deskripsi Produk
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Deskripsi Produk',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sepatu ini dirancang untuk memberikan kenyamanan maksimal dalam berbagai aktivitas sehari-hari. '
                        'Dengan material berkualitas tinggi dan desain ergonomis, sepatu ini cocok digunakan untuk jalan-jalan, '
                        'berolahraga, maupun kegiatan kasual lainnya. Bagian dalam sepatu dilapisi dengan bahan yang lembut dan '
                        'menyerap keringat, sementara sol luar terbuat dari karet anti-selip yang tahan lama. '
                        'menyerap keringat, sementara sol luar terbuat dari karet anti-selip yang tahan lama. '
                        'menyerap keringat, sementara sol luar terbuat dari karet anti-selip yang tahan lama. '
                        'menyerap keringat, sementara sol luar terbuat dari karet anti-selip yang tahan lama. '
                        'Tersedia dalam berbagai ukuran dan warna, sepatu ini tidak hanya nyaman tapi juga tampil stylish untuk segala usia.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16), // Menambahkan ruang antara section Deskripsi Produk dan bagian berikutnya

// Section Informasi Toko dan Chat Toko
        // Section Informasi Toko dan Chat Toko
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Kolom pertama: Informasi Toko
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HalamanToko()),
                      );
                    },
                    child: const Text(
                      'Lihat Toko',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.orange,

                      ),
                    ),
                  ),
                ],
              ),

              // Kolom kedua: Chat Toko
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HalamanChatToko()),
                      );
                    },
                    child: const Text(
                      'Chat Toko',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.orange,

                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                ],
              ),
            ],
          ),
            ),




            const SizedBox(height: 16),

          // Detail Produk
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detail Produk',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text('Kode Produk'), Text('236424765243')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text('Stok'), Text('100')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text('Bahan'), Text('Karet')],
                  ),
                ],
              ),
            ),
            const Divider(height: 16, thickness: 1),

            // Detail Sepatu
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detail Sepatu',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text('Ukuran'), Text('s, m, xl, xxl')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Text('Warna'), Text('hitam')],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Harga'),
                      Text('${widget.product.price}')
                    ],
                  ),
                ],
              ),
            ),

            const Divider(height: 16, thickness: 1),

            // Pengiriman
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pengiriman',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Produk ini akan dikirim menggunakan jasa pengiriman terpercaya dengan estimasi waktu 2-4 hari kerja. '
                        'Pastikan alamat pengiriman Anda lengkap dan jelas untuk menghindari keterlambatan.',
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),

            const Divider(height: 16, thickness: 1),

            // Rating
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kolom kiri: angka dan bintang besar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        '5',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          Icon(Icons.star, color: Colors.orange, size: 20),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(width: 24),

                  // Kolom kanan: distribusi rating
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('⭐                    10%   ...........................1'),
                        SizedBox(height: 4),
                        Text('⭐⭐                 20%   ........................ 2'),
                        SizedBox(height: 4),
                        Text('⭐⭐⭐             30%   ....................... 3'),
                        SizedBox(height: 4),
                        Text('⭐⭐⭐⭐        10%   ....................... 4'),
                        SizedBox(height: 4),
                        Text('⭐⭐⭐⭐⭐    30%   ....................... 5'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            // Section Profil Pengguna
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // Kolom 1: Foto Profil
                  ClipOval(
                    child: Image.asset(
                      'assets/images/profile.png', // Ganti dengan gambar profil pengguna
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Kolom 2: Nama dan Rating Pengguna
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nama Pengguna', // Ganti dengan nama pengguna
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          Icon(Icons.star, color: Colors.orange, size: 16),
                          Icon(Icons.star, color: Colors.grey, size: 16),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),


            // Section Foto Produk dari User (PAP)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // Gambar Produk 1
                  Expanded(
                    child: Image.asset(
                      'assets/images/sepatu_back.png', // Ganti dengan gambar produk 1
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Gambar Produk 2
                  Expanded(
                    child: Image.asset(
                      'assets/images/product2.png', // Ganti dengan gambar produk 2
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Section Review Pengguna
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Produk ini sangat nyaman digunakan dan berkualitas tinggi. Saya sangat puas dengan pembelian ini. '
                    'Bahan yang digunakan sangat nyaman di kaki, dan desainnya juga sangat keren. Saya pasti akan membeli lagi!',
                style: TextStyle(fontSize: 14, color: Colors.black87),
                textAlign: TextAlign.justify,
              ),
            ),

            const SizedBox(height: 24),

// Section: Tombol Beli Sekarang
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Kolom kiri - Harga Total
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Harga Total',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.product.price,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Kolom kanan - Tombol Beli & Cart
                  Row(
                    children: [
                      // Tombol Beli Sekarang
                      ElevatedButton(
                        onPressed: () {

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Beli Sekarang diklik!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Beli Sekarang',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Icon Cart
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.shopping_cart, color: Colors.orange),
                          onPressed: () {
                            Provider.of<CartModel>(context, listen: false).add(widget.product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Berhasil di tambahkan')),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
