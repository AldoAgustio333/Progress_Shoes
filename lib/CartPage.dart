// lib/CartPage.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart'; // Mengimpor CartModel (yang berisi CartItem)
import 'checkout_page.dart'; // Pastikan ini mengarah ke checkout_page.dart yang benar

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Mengubah totalHarga menjadi double
  double totalHarga = 0.0;

  @override
  void initState() {
    super.initState();
    // Panggil _hitungTotalHarga di initState setelah widget siap
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hitungTotalHarga();
    });
  }

  // Metode ini akan dipanggil saat keranjang berubah
  void _hitungTotalHarga() {
    final cart = Provider.of<CartModel>(context, listen: false);
    setState(() {
      totalHarga = cart.totalPrice; // Menggunakan getter totalPrice dari CartModel
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    // Tambahkan listener untuk memperbarui totalHarga saat keranjang berubah
    // Pastikan untuk menghapus listener di dispose untuk mencegah memory leak
    cart.removeListener(_hitungTotalHarga); // Hapus listener lama jika ada (untuk safety)
    cart.addListener(_hitungTotalHarga); // Tambahkan listener baru

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty
                ? const Center(child: Text('Keranjang kosong'))
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = cart.items[index];
                      final product = cartItem.product;

                      return ListTile(
                        leading: Image.asset(product.image, width: 50),
                        title: Text(product.name),
                        // Menampilkan harga produk sebagai double dan format string
                        subtitle: Text('Harga: Rp${product.price.toStringAsFixed(0)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                // Panggil remove dengan Product, bukan CartItem
                                cart.remove(product); // Sesuai dengan CartModel.remove(Product product)
                                // Tidak perlu panggil _hitungTotalHarga() secara eksplisit karena notifyListeners() di CartModel akan memicunya
                              },
                            ),
                            Text('${cartItem.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                cart.add(product); // Sesuai dengan CartModel.add(Product product)
                                // Tidak perlu panggil _hitungTotalHarga() secara eksplisit karena notifyListeners() di CartModel akan memicunya
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          // Footer section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.orange[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Total harga
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Rp ${totalHarga.toStringAsFixed(0)}', // Format sebagai string tanpa desimal
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                // Tombol beli
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    // Hanya izinkan checkout jika keranjang tidak kosong
                    if (cart.items.isNotEmpty) {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckoutPage(), // Pastikan CheckoutPage bisa const atau hapus const
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Keranjang Anda kosong!')),
                      );
                    }
                  },
                  child: const Text('Beli Sekarang'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Penting: Hapus listener saat widget dibuang untuk mencegah memory leak
    Provider.of<CartModel>(context, listen: false).removeListener(_hitungTotalHarga);
    super.dispose();
  }
}