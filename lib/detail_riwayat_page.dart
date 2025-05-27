import 'package:flutter/material.dart';
import 'models/cart_model.dart'; // Pastikan ini mengandung CartItem dan Product

class DetailRiwayatPage extends StatelessWidget {
  final CartItem item;

  const DetailRiwayatPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    final int hargaBarang = int.parse(product.price) * item.quantity;
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
                Image.asset(product.image, width: 80, height: 80),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Jumlah: ${item.quantity}'),
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
            buildActionButton(context, 'Beli Lagi', Colors.orange),
            buildActionButton(context, 'Batalkan', Colors.grey),
            buildActionButton(context, 'Kembalikan Barang', Colors.red),

            const SizedBox(height: 24),

            // Kirim Review
            const Text('Kirim Review',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
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
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Review berhasil dikirim!')),
                  );
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

  Widget buildActionButton(BuildContext context, String label, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white, // Teks putih
        ),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$label diklik')),
          );
        },
        child: Text(label),
      ),
    );
  }
}
