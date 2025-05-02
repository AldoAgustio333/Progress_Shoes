import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eiger Footwear - Checkout',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        hintColor: Colors.grey.shade400,
        fontFamily: 'Roboto', // Anda mungkin perlu menyesuaikan font
      ),
      home: CheckoutPage(),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // Contoh data produk yang dibeli (ganti dengan data sebenarnya)
  final Map<String, dynamic> _product = {
    'image':
        'assets/images/bryce_lowcut.png', // Ganti dengan path gambar produk
    'name': 'BRYCE LOWCUT',
    'stock': 1,
    'color': 'TAN',
    'selectedSize': 39,
    'price': 529000,
  };

  // Contoh data alamat pengiriman (ganti dengan data pengguna sebenarnya)
  final String _shippingAddress =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown';

  // Contoh metode pembayaran yang tersedia
  final List<String> _paymentMethods = [
    'Transfer Bank',
    'COD',
    'Sea Bank',
    'Dana',
    'OVO',
  ];
  String? _selectedPaymentMethod;

  // Contoh metode pengiriman yang tersedia
  final String _shippingMethod = 'JNE Reguler';
  final String _estimatedDelivery = '18 - 20 Mar';
  final double _shippingCost = 0; // Contoh biaya pengiriman
  final double _adminFee = 0; // Contoh biaya admin

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Image.asset(
            'assets/images/eiger_logo_white.png', // Ganti dengan path logo Eiger putih Anda
            height: 30,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {
              // Tambahkan logika keranjang belanja
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Alamat Tujuan
            Text(
              'Alamat Tujuan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _shippingAddress,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Tambahkan logika untuk mengubah alamat
                  },
                  child: Text('Ubah', style: TextStyle(color: Colors.orange)),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Detail Produk
            Text(
              'Detail Produk',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    _product['image'],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _product['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Stok: ${_product['stock']}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        Text(
                          'Warna: ${_product['color']}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        Text(
                          'Ukuran: ${_product['selectedSize']}',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Rp. ${_product['price'].toStringAsFixed(0)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Metode Pembayaran
            Text(
              'Metode Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children:
                  _paymentMethods.map((method) {
                    return OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _selectedPaymentMethod = method;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color:
                              _selectedPaymentMethod == method
                                  ? Colors.orange
                                  : Colors.grey.shade400,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        method,
                        style: TextStyle(
                          color:
                              _selectedPaymentMethod == method
                                  ? Colors.orange
                                  : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
            ),
            if (_adminFee > 0)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Admin Bank:',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Rp. ${_adminFee.toStringAsFixed(0)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 24),

            // Metode Pengiriman
            Text(
              'Metode Pengiriman',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Icon(Icons.local_shipping_outlined, color: Colors.orange),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _shippingMethod,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Garansi tiba: $_estimatedDelivery',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Tambahkan logika untuk mengubah metode pengiriman
                    },
                    child: Text('Ubah', style: TextStyle(color: Colors.orange)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Total Pembayaran
            Text(
              'Total Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            _buildPaymentSummary('Subtotal untuk produk', _product['price']),
            _buildPaymentSummary('Subtotal pengiriman', _shippingCost),
            _buildPaymentSummary('Admin Bank', _adminFee),
            Divider(color: Colors.grey.shade300, thickness: 1),
            _buildPaymentSummary(
              'Total Pembayaran',
              _product['price'] + _shippingCost + _adminFee,
              isTotal: true,
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total Harga',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
                Text(
                  'Rp. ${(_product['price'] + _shippingCost + _adminFee).toStringAsFixed(0)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk melakukan pembayaran
                if (_selectedPaymentMethod != null) {
                  print(
                    'Melakukan pembayaran dengan metode: $_selectedPaymentMethod',
                  );
                  // Navigasi ke halaman pembayaran atau proses pembayaran lainnya
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Pilih metode pembayaran terlebih dahulu.'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text('Bayar Sekarang', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummary(
    String label,
    double value, {
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            'Rp. ${value.toStringAsFixed(0)}',
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
