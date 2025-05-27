import 'package:flutter/material.dart';

class HalamanChatToko extends StatelessWidget {
  final TextEditingController _chatController = TextEditingController();

  HalamanChatToko({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chat',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Nama Pengguna',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),

            // Area chat abu-abu
            Container(
              height: 200,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const SingleChildScrollView(
                child: Text(
                  'Ini adalah isi chat yang panjang. '
                'Duduklah dengan nyaman dan baca pesan ini dengan saksama. '
                  'Lorem ipsum telah diganti untuk menjelaskan bagaimana sebuah paragraf panjang dapat ditampilkan dalam kotak chat. '
                  'Kami sangat menghargai setiap pertanyaan dan akan berusaha menjawab secepat mungkin. '
                  'Jika Anda memiliki kendala atau membutuhkan bantuan, jangan ragu untuk menghubungi kami. '
                  'Terima kasih atas kepercayaan Anda kepada toko kami.'
                  ,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Chat Toko',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Input chat + tombol submit
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    decoration: const InputDecoration(
                      hintText: 'Tulis pesan...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Aksi saat tombol diklik, bisa disesuaikan
                    String pesan = _chatController.text;
                    if (pesan.isNotEmpty) {
                      // Untuk sekarang, tampilkan snackbar sebagai dummy
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Pesan terkirim: $pesan')),
                      );
                      _chatController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
