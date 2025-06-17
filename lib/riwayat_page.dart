// lib/riwayat_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_shoes/models/history_model.dart';
import 'package:e_shoes/models/cart_model.dart'; // Impor CartModel untuk definisi CartItem
import 'detail_riwayat_page.dart';
import 'CartPage.dart'; // Import CartPage untuk navigasi

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  @override
  Widget build(BuildContext context) {
    // Ambil HistoryModel dari Provider
    final historyProvider = Provider.of<HistoryModel>(context);
    final orders = historyProvider.orders; // Mengakses getter 'orders' dari HistoryModel

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'EIGER', // Mengubah judul menjadi 'EIGER'
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true, // Membuat judul di tengah
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()), // Navigasi ke CartPage
              );
            },
          ),
        ],
      ),
      body: orders.isEmpty // Menggunakan 'orders' di sini
          ? const Center(
              child: Text(
                'Belum ada riwayat pembelian.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: orders.length, // Jumlah pesanan
              itemBuilder: (context, orderIndex) {
                final order = orders[orderIndex]; // Setiap 'order' adalah List<CartItem>

                // Hitung total harga untuk pesanan ini
                double totalOrderPrice = 0.0;
                for (var item in order) {
                  totalOrderPrice += item.product.price * item.quantity;
                }

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ExpansionTile( // Menggunakan ExpansionTile untuk setiap pesanan
                    title: Text(
                      'Pesanan #${orderIndex + 1} - Total: Rp${totalOrderPrice.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: order.map((item) {
                      // Ini adalah item individual dalam pesanan
                      return ListTile(
                        leading: Image.asset(item.product.image, width: 50),
                        title: Text(item.product.name),
                        subtitle: Text('Jumlah: ${item.quantity}'),
                        trailing: Text(
                          'Rp ${(item.product.price * item.quantity).toStringAsFixed(0)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          // Navigasi ke DetailRiwayatPage untuk item ini
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailRiwayatPage(item: item),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                );
              },
            ),
    );
  }
}