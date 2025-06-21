import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/cart_model.dart';
import 'product_detail_page.dart';

class DetailRiwayatPage extends StatefulWidget {
  final CartItem item;

  const DetailRiwayatPage({super.key, required this.item});

  @override
  State<DetailRiwayatPage> createState() => _DetailRiwayatPageState();
}

class _DetailRiwayatPageState extends State<DetailRiwayatPage> {
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.item.product;
    final int hargaBarang = int.parse(product.price) * widget.item.quantity;
    final int hargaJasaKirim = 10000;
    final int total = hargaBarang + hargaJasaKirim;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Riwayat'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Produk
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  product.image,
                  width: 80,
                  height: 80,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 80);
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Jumlah: ${widget.item.quantity}'),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),

            // Ringkasan Harga
            buildPriceRow('Harga Barang', hargaBarang),
            buildPriceRow('Harga Jasa Kirim', hargaJasaKirim),
            buildPriceRow('Total', total, isBold: true),
            const Divider(),

            // Alamat Tujuan
            const Text('Alamat Tujuan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'Jl. Mawar No.123, Jakarta, Indonesia',
              style: TextStyle(fontSize: 14),
            ),
            const Divider(),

            // Tombol-tombol Aksi
            const SizedBox(height: 12),
            buildActionButton(context, 'Beli Lagi', Colors.orange, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: product),
                ),
              );
            }),
            buildActionButton(context, 'Batalkan', Colors.grey, () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Pesanan dibatalkan')),
              );
            }),
            buildActionButton(context, 'Kembalikan Barang', Colors.red, () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Permintaan pengembalian dikirim')),
              );
            }),

            const SizedBox(height: 24),

            // Form Kirim Review
            const Text('Kirim Review',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _reviewController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Tulis review kamu di sini...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  final String reviewText = _reviewController.text.trim();
                  if (reviewText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Review tidak boleh kosong')),
                    );
                    return;
                  }

                  try {
                    await FirebaseFirestore.instance.collection('reviews').add({
                      'productName': product.name,
                      'review': reviewText,
                      'timestamp': Timestamp.now(),
                    });

                    _reviewController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Review berhasil dikirim!')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Gagal kirim review: $e')),
                    );
                  }
                },
                child: const Text('Kirim'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPriceRow(String label, int value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text('Rp $value',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget buildActionButton(
      BuildContext context,
      String label,
      Color color,
      VoidCallback onPressed,
      ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
