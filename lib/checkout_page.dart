import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import '../models/history_model.dart';

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

  // Contoh biaya admin bank
  int adminBankFee = 5000;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    final items = cart.items;

    // Hitung subtotal produk
    int subtotalProduk = 0;
    for (var item in items) {
      subtotalProduk += int.parse(item.product.price) * item.quantity;
    }

    // Contoh biaya pengiriman (bisa diupdate sesuai pilihan)
    int shippingCost = 0;

    // Hitung total pembayaran
    int totalHarga = subtotalProduk + shippingCost + adminBankFee;

    // Contoh alamat
    final alamat = 'Jl. Merdeka No. 123, Bandung, Jawa Barat';

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
                itemCount: items.length + 1, // +1 buat section metode pembayaran
                itemBuilder: (context, index) {
                  if (index < items.length) {
                    final cartItem = items[index];
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
                              'Rp ${int.parse(product.price) * cartItem.quantity}',
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
                  final historyProvider = Provider.of<HistoryModel>(context, listen: false);
                  historyProvider.addToHistory(cart.items); // simpan semua item pembelian ke history

                  cart.clearCart(); // kosongkan cart setelah beli

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pembayaran dikonfirmasi!')),
                  );

                  // Pindah ke halaman riwayat
                  Navigator.pushNamed(context, '/riwayat');
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

  Widget _buildPriceRow(String label, int amount, {bool isTotal = false}) {
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
            'Rp $amount',
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
