import 'package:flutter/material.dart';
import 'package:e_shoes/models/cart_model.dart';

class DetailRiwayatPage extends StatelessWidget {

  final CartItem item;

  const DetailRiwayatPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    final double hargaBarang = product.price * item.quantity;
    const double hargaJasaKirim = 15000.0;
    const double adminBank = 5000.0;
    final double totalPembayaran = hargaBarang + hargaJasaKirim + adminBank;
    const String alamatTujuan = 'Jl. Merdeka No. 123, Bandung, Jawa Barat';
    const String metodePengiriman = 'JNE Regular';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Riwayat Pesanan'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _buildInfoCard(
              icon: Icons.local_shipping,
              iconColor: Colors.green,
              title: 'Telah Diterima',
              content: 'Pesanan telah sampai di alamat tujuan.',
            ),
            const SizedBox(height: 16),

            _buildInfoCard(
              icon: Icons.location_on,
              iconColor: Colors.orange,
              title: 'Alamat Pengiriman',
              content: alamatTujuan,
            ),
            const SizedBox(height: 24),
            
            const Text(
              'Rincian Produk',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(thickness: 1, height: 20),

            ListTile(
              leading: Image.asset(product.image, width: 60),
              title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Jumlah: ${item.quantity}'),
              trailing: Text('Rp${hargaBarang.toStringAsFixed(0)}'),
            ),
            const Divider(thickness: 1, height: 20),

            const Text(
              'Rincian Pembayaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildPriceRow('Subtotal Produk', hargaBarang),
            _buildPriceRow('Biaya Pengiriman', hargaJasaKirim),
            _buildPriceRow('Biaya Admin', adminBank),
            const Divider(height: 20, thickness: 1.5),
            _buildPriceRow('Total Pembayaran', totalPembayaran, isTotal: true),
            
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fitur "Beli Lagi" diklik!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Beli Lagi'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fitur "Hubungi Penjual" diklik!')),
                  );
                },
                child: const Text('Hubungi Penjual', style: TextStyle(color: Colors.orange)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required IconData icon, required Color iconColor, required String title, required String content}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(content, style: TextStyle(color: Colors.grey.shade700)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey.shade800)),
          Text(
            'Rp${amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.orange : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}