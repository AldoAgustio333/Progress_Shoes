// lib/checkout_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart'; // Mengimpor CartModel (yang berisi CartItem)
import '../models/history_model.dart'; // Mengimpor HistoryModel
import '../models/product.dart'; // Mengimpor Product

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // Pilihan metode pembayaran
  String selectedPaymentMethod = 'Transfer Bank';

  // Contoh metode pengiriman default
  String shippingMethod = 'JNE Regular';
  String shippingDateRange = '18-20 Mar';

  // Contoh biaya admin bank (ubah ke double)
  double adminBankFee = 5000.0; // Mengubah int menjadi double

  // Mengubah semua variabel harga menjadi double
  double subtotalProduk = 0.0;
  double shippingCost = 0.0; // Mengubah int menjadi double
  double totalHarga = 0.0;

  @override
  void initState() {
    super.initState();
    _hitungTotal();
  }

  void _hitungTotal() {
    final cart = Provider.of<CartModel>(context, listen: false);
    double tempSubtotal = 0.0;
    for (var item in cart.items) { // PERUBAHAN: Gunakan cart.items
      tempSubtotal += item.product.price * item.quantity; // Menghapus int.parse()
    }
    setState(() {
      subtotalProduk = tempSubtotal;
      totalHarga = subtotalProduk + shippingCost + adminBankFee;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context); // Ambil instance CartModel
    final history = Provider.of<HistoryModel>(context, listen: false); // Akses HistoryModel

    final alamat = 'Jl. Merdeka No. 123, Bandung, Jawa Barat'; // Contoh alamat

    // Daftar metode pembayaran
    final paymentMethods = [
      'Transfer Bank',
      'COD',
      'Sea Bank',
      'Dana',
      'Ovo',
    ];

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Section alamat tujuan
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Baris Alamat + Tombol Ubah
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Alamat Tujuan',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: aksi ubah alamat
                        },
                        child: const Text(
                          'Ubah',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    alamat,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Ringkasan Pesanan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            // List produk dengan metode pembayaran ditempel ke card produk
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length + 1, // PERUBAHAN: Gunakan cart.items
                itemBuilder: (context, index) {
                  if (index < cart.items.length) { // PERUBAHAN: Gunakan cart.items
                    final cartItem = cart.items[index]; // PERUBAHAN: Gunakan cart.items
                    final product = cartItem.product;

                    return Column(
                      children: [
                        Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Image.asset(product.image, width: 50),
                            title: Text(product.name),
                            subtitle: Text('Jumlah: ${cartItem.quantity}'),
                            trailing: Text(
                              'Rp ${(product.price * cartItem.quantity).toStringAsFixed(0)}', // Menghapus int.parse()
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const Divider(height: 1),
                      ],
                    );
                  } else {
                    // Section metode pembayaran setelah list produk
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        const Text(
                          'Metode Pembayaran',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: paymentMethods.map((method) {
                            final isSelected = selectedPaymentMethod == method;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedPaymentMethod = method;
                                  // Perbarui total pembayaran jika biaya admin berbeda per metode
                                  // Contoh: adminBankFee = (method == 'Transfer Bank' ? 5000.0 : 0.0);
                                  _hitungTotal();
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.orange
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.orange),
                                ),
                                child: Text(
                                  method,
                                  style: TextStyle(
                                    color:
                                    isSelected ? Colors.white : Colors.orange,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  }
                },
              ),
            ),

            const Divider(),

            // Section Metode Pengiriman
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Metode Pengiriman',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        shippingMethod,
                        style: const TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: aksi ubah metode pengiriman
                        },
                        child: const Text(
                          'Ubah',
                          style: TextStyle(color: Colors.orange),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Garansi Tiba : $shippingDateRange',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Section Total Pembayaran di bawah layar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.orange),
              ),
              child: Column(
                children: [
                  _buildPriceRow('Subtotal untuk produk', subtotalProduk),
                  _buildPriceRow('Subtotal Pengiriman', shippingCost),
                  _buildPriceRow('Admin Bank', adminBankFee),
                  const Divider(),
                  _buildPriceRow(
                    'Total Pembayaran',
                    totalHarga,
                    isTotal: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  if (cart.items.isNotEmpty) {
                    history.addOrder(cart.items); // simpan semua item pembelian ke history
                    cart.clearCart(); // kosongkan cart setelah beli

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pembayaran dikonfirmasi!')),
                    );

                    // Pindah ke halaman riwayat
                    Navigator.pushNamed(context, '/riwayat');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Keranjang Anda kosong, tidak dapat checkout.')),
                    );
                  }
                },
                icon: const Icon(Icons.payment),
                label: const Text('Konfirmasi Pembayaran'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Mengubah _buildPriceRow agar menerima double untuk amount
  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            'Rp ${amount.toStringAsFixed(0)}', // Format sebagai string tanpa desimal
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.orange : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}