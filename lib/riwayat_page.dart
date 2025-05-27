import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/history_model.dart';
import 'detail_riwayat_page.dart';


class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  @override
  Widget build(BuildContext context) {
    // Ambil history dari Provider di sini
    final history = Provider.of<HistoryModel>(context).history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pembelian'),
        backgroundColor: Colors.orange,
      ),
      body: history.isEmpty
          ? const Center(
        child: Text(
          'Belum ada riwayat pembelian.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: Image.asset(item.product.image, width: 50),
              title: Text(item.product.name),
              subtitle: Text('Jumlah: ${item.quantity}'),
              trailing: Text(
                'Rp ${int.parse(item.product.price) * item.quantity}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailRiwayatPage(item: item),
                  ),
                );
              },
            ),

          );
        },
      ),
    );
  }
}
