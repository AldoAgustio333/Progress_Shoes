// cart_page.dart
import 'package:flutter/material.dart';
import 'checkout.dart'; // Import halaman checkout

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Contoh data item keranjang (ganti dengan data sebenarnya dari state aplikasi Anda)
  final List<Map<String, dynamic>> _cartItems = [
    {
      'image':
          'assets/images/bryce_lowcut.png', // Ganti dengan path gambar produk
      'name': 'BRYCE LOWCUT',
      'price': 529000,
      'quantity': 1,
    },
    {
      'image': 'assets/images/bryce_lowcut.png', // Contoh gambar lain
      'name': 'SEPATU ADVENTURE Z',
      'price': 479000,
      'quantity': 2,
    },
  ];

  double get _totalPrice {
    double total = 0;
    for (var item in _cartItems) {
      total += (item['price'] as num) * (item['quantity'] as num);
    }
    return total;
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity > 0) {
        _cartItems[index]['quantity'] = newQuantity;
      } else {
        // Jika kuantitas menjadi 0, hapus item dari keranjang
        _cartItems.removeAt(index);
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Keranjang Belanja', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.white),
            onPressed: () {
              // Tambahkan logika untuk mengosongkan keranjang
              setState(() {
                _cartItems.clear();
              });
            },
          ),
        ],
      ),
      body:
          _cartItems.isEmpty
              ? Center(
                child: Text(
                  'Keranjang Anda Kosong',
                  style: TextStyle(fontSize: 16),
                ),
              )
              : ListView.builder(
                itemCount: _cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = _cartItems[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            cartItem['image'],
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
                                  cartItem['name'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Rp. ${(cartItem['price'] as num).toStringAsFixed(0)}',
                                ),
                                Row(
                                  children: <Widget>[
                                    Text('Jumlah: '),
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        _updateQuantity(
                                          index,
                                          (cartItem['quantity'] as int) - 1,
                                        );
                                      },
                                    ),
                                    Text('${cartItem['quantity']}'),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        _updateQuantity(
                                          index,
                                          (cartItem['quantity'] as int) + 1,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              _removeItem(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      bottomNavigationBar:
          _cartItems.isNotEmpty
              ? Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total Belanja:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Rp. ${_totalPrice.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Tambahkan logika lain yang mungkin kamu butuhkan sebelum checkout
                        print('Tombol Checkout Ditekan');

                        // Kode untuk navigasi ke halaman CheckoutPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text('Checkout', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              )
              : null,
    );
  }
}
