// lib/detail_riwayat_page.dart
import 'package:flutter/material.dart';
import 'package:e_shoes/models/cart_model.dart'; // Pastikan ini mengandung CartItem dan Product

class DetailRiwayatPage extends StatefulWidget {
  final CartItem item;

  const DetailRiwayatPage({super.key, required this.item});

  @override
  State<DetailRiwayatPage> createState() => _DetailRiwayatPageState();
}

class _DetailRiwayatPageState extends State<DetailRiwayatPage> {
  // State untuk alamat tujuan
  String _alamatTujuan = 'Jl. Merdeka No. 123, Bandung, Jawa Barat';
  // State untuk metode pengiriman
  String _metodePengiriman = 'JNE Regular';
  String _garansiTiba = 'Garansi Tiba: 18-20 Mar';

  // Daftar opsi metode pengiriman
  final List<Map<String, String>> _deliveryOptions = [
    {'name': 'JNE Regular', 'eta': 'Garansi Tiba: 18-20 Mar'},
    {'name': 'SiCepat Ekspres', 'eta': 'Garansi Tiba: 19-21 Mar'},
    {'name': 'Anteraja', 'eta': 'Garansi Tiba: 20-22 Mar'},
  ];

  @override
  Widget build(BuildContext context) {
    final product = widget.item.product;
    final double hargaBarang = product.price * widget.item.quantity;
    final double hargaJasaKirim = 10000.0; // Ini tetap statis untuk contoh
    final double adminBank = 5000.0; // Ini tetap statis untuk contoh
    final double totalPembayaran = hargaBarang + hargaJasaKirim + adminBank;

    return Scaffold(
      resizeToAvoidBottomInset: true, // Biarkan Flutter menyesuaikan body saat keyboard muncul

      appBar: AppBar(
        title: const Text('Detail Riwayat'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian Alamat Tujuan
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Alamat Tujuan',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () async {
                            final newAddress = await _showAddressInputDialog(context, _alamatTujuan);
                            if (newAddress != null && newAddress.isNotEmpty) {
                              setState(() {
                                _alamatTujuan = newAddress;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Alamat berhasil diubah!')),
                              );
                            }
                          },
                          child: const Text('Ubah', style: TextStyle(color: Colors.orange)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _alamatTujuan,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

            // Ringkasan Pesanan (Header)
            const Text(
              'Ringkasan Pesanan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Item Produk
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(product.image, width: 80, height: 80, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('Jumlah: ${widget.item.quantity}', style: const TextStyle(color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text('Rp ${product.price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            // Metode Pengiriman
            Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Metode Pengiriman',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            _showDeliveryOptions(context);
                          },
                          child: const Text('Ubah', style: TextStyle(color: Colors.orange)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _metodePengiriman,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      _garansiTiba,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            // Rincian Pembayaran
            buildPriceRow('Subtotal untuk produk', hargaBarang),
            buildPriceRow('Subtotal Pengiriman', hargaJasaKirim),
            buildPriceRow('Admin Bank', adminBank),
            const SizedBox(height: 8),
            const Divider(),
            buildPriceRow('Total Pembayaran', totalPembayaran, isBold: true),
            const SizedBox(height: 8),
            const Divider(),

            // Bagian Tombol Aksi
            const SizedBox(height: 12),
            buildActionButton(context, 'Beli Lagi', Colors.orange, () {
              Navigator.pop(context); // Kembali ke halaman sebelumnya
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Beli Lagi diklik, kembali ke halaman sebelumnya.')),
              );
            }),
            buildActionButton(context, 'Batalkan', Colors.grey, () {
              Navigator.pop(context); // Kembali ke halaman sebelumnya
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Batalkan diklik, kembali ke halaman sebelumnya.')),
              );
            }),
            buildActionButton(context, 'Kembalikan Barang', Colors.red, () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Kembalikan Barang diklik')),
              );
            }),

            // Bagian Kirim Review
            const SizedBox(height: 24),
            const Text('Kirim Review',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const TextField(
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
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // Widget pembantu untuk baris harga
  Widget buildPriceRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text('Rp ${value.toStringAsFixed(0)}',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  // Widget pembantu untuk tombol aksi
  Widget buildActionButton(BuildContext context, String label, Color color, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
        onPressed: onPressed, // Menggunakan callback yang diberikan
        child: Text(label),
      ),
    );
  }

  // Fungsi untuk menampilkan dialog input alamat
  Future<String?> _showAddressInputDialog(BuildContext context, String currentAddress) {
    TextEditingController addressController = TextEditingController(text: currentAddress);
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ubah Alamat'),
          content: TextField(
            controller: addressController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Masukkan alamat baru',
              border: OutlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog tanpa menyimpan
              },
            ),
            ElevatedButton(
              child: const Text('Simpan'),
              onPressed: () {
                Navigator.of(context).pop(addressController.text); // Tutup dialog dengan menyimpan alamat baru
              },
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menampilkan opsi metode pengiriman
  void _showDeliveryOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih Metode Pengiriman',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ..._deliveryOptions.map((option) {
                return RadioListTile<String>(
                  title: Text(option['name']!),
                  subtitle: Text(option['eta']!),
                  value: option['name']!,
                  groupValue: _metodePengiriman,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        _metodePengiriman = value;
                        _garansiTiba = option['eta']!;
                      });
                      Navigator.pop(context); // Tutup bottom sheet
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Metode pengiriman diubah menjadi ${option['name']!}')),
                      );
                    }
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}