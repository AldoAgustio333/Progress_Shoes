import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cart_model.dart';
import 'checkout_page.dart';
import '../models/voucher.dart';
import '../services/voucher_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalHarga = 0.0;

  final TextEditingController _voucherController = TextEditingController();
  String? _voucherMessage;
  double _discountAmount = 0.0;
  String? _appliedVoucherCode;

  final VoucherService _voucherService = VoucherService();

  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeUserAndCart();
    });
  }

  Future<void> _initializeUserAndCart() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
        user = userCredential.user;
        print('Signed in anonymously with UID: ${user?.uid}');
      } catch (e) {
        print('Error signing in anonymously: $e');
      }
    }
    setState(() {
      _currentUserId = user?.uid;
    });
    _hitungTotalHarga();
  }

  void _hitungTotalHarga() {
    final cart = Provider.of<CartModel>(context, listen: false);
    setState(() {
      totalHarga = cart.totalPrice;
      totalHarga -= _discountAmount;
      if (totalHarga < 0) totalHarga = 0;
    });
  }

  Future<void> _applyVoucher() async {
    String voucherCode = _voucherController.text.trim().toUpperCase();
    final cart = Provider.of<CartModel>(context, listen: false); 

    if (voucherCode.isEmpty) {
      setState(() {
        _voucherMessage = 'Kode voucher tidak boleh kosong.';
        _discountAmount = 0.0;
        _appliedVoucherCode = null;
      });
      cart.setVoucherDiscount(0.0, null); 
      _hitungTotalHarga();
      return;
    }

    if (_currentUserId == null) {
      setState(() {
        _voucherMessage = 'Gagal mengidentifikasi pengguna. Harap coba lagi atau restart aplikasi.';
        _discountAmount = 0.0;
        _appliedVoucherCode = null;
      });
      cart.setVoucherDiscount(0.0, null); 
      _hitungTotalHarga();
      return;
    }

    if (_appliedVoucherCode != null && _appliedVoucherCode == voucherCode) {
      setState(() {
        _voucherMessage = 'Voucher "$voucherCode" sudah diterapkan.';
      });
      return;
    }

    setState(() {
      _voucherMessage = 'Mencari voucher...';
    });

    Voucher? fetchedVoucher = await _voucherService.getVoucherByCode(voucherCode);

    if (fetchedVoucher != null) {
      final now = DateTime.now();
      if (fetchedVoucher.expiryDate != null && fetchedVoucher.expiryDate!.isBefore(now)) {
        setState(() {
          _discountAmount = 0.0;
          _voucherMessage = 'Voucher "$voucherCode" sudah kedaluwarsa.';
          _appliedVoucherCode = null;
        });
        cart.setVoucherDiscount(0.0, null); 
      } else if (fetchedVoucher.isOneTimeUse) {
        final voucherDoc = await FirebaseFirestore.instance.collection('vouchers').doc(fetchedVoucher.id).get();
        final List<dynamic> usersUsed = voucherDoc.data()?['usersUsed'] ?? [];

        if (usersUsed.contains(_currentUserId!)) {
          setState(() {
            _discountAmount = 0.0;
            _voucherMessage = 'Voucher "$voucherCode" sudah pernah digunakan oleh Anda.';
            _appliedVoucherCode = null;
          });
          cart.setVoucherDiscount(0.0, null); 
        } else {
          final double discount = fetchedVoucher.discountAmount;
          final cartTotalBeforeDiscount = cart.totalPrice; 
          final finalDiscount = discount > cartTotalBeforeDiscount ? cartTotalBeforeDiscount : discount;

          setState(() {
            _discountAmount = finalDiscount;
            _voucherMessage = 'Voucher "$voucherCode" berhasil diterapkan! Diskon Rp${finalDiscount.toStringAsFixed(0)}.';
            _appliedVoucherCode = voucherCode;
          });
          
          cart.setVoucherDiscount(finalDiscount, voucherCode);

          await _voucherService.markVoucherAsUsed(fetchedVoucher.id, _currentUserId!);
        }
      } else { 
        final double discount = fetchedVoucher.discountAmount;
        final cartTotalBeforeDiscount = cart.totalPrice; 
        final finalDiscount = discount > cartTotalBeforeDiscount ? cartTotalBeforeDiscount : discount;

        setState(() {
          _discountAmount = finalDiscount;
          _voucherMessage = 'Voucher "$voucherCode" berhasil diterapkan! Diskon Rp${finalDiscount.toStringAsFixed(0)}.';
          _appliedVoucherCode = voucherCode;
        });
        
        cart.setVoucherDiscount(finalDiscount, voucherCode);
      }
    } else {
      setState(() {
        _discountAmount = 0.0;
        _voucherMessage = 'Kode voucher "$voucherCode" tidak valid.';
        _appliedVoucherCode = null;
      });
      cart.setVoucherDiscount(0.0, null); 
    }
    _hitungTotalHarga();
  }

  void _removeVoucher() {
    final cart = Provider.of<CartModel>(context, listen: false); 
    setState(() {
      _discountAmount = 0.0;
      _voucherMessage = null;
      _appliedVoucherCode = null;
      _voucherController.clear();
    });
    
    cart.setVoucherDiscount(0.0, null);
    _hitungTotalHarga();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

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
                        subtitle: Text('Harga: Rp${product.price.toStringAsFixed(0)}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                cart.remove(product);
                              },
                            ),
                            Text('${cartItem.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                cart.add(product);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Punya Voucher?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _voucherController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan kode voucher',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        onSubmitted: (value) => _applyVoucher(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _applyVoucher,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text('Terapkan'),
                    ),
                  ],
                ),
                if (_voucherMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Text(
                          _voucherMessage!,
                          style: TextStyle(
                            color: _discountAmount > 0 ? Colors.green : Colors.red,
                            fontSize: 14,
                          ),
                        ),
                        if (_appliedVoucherCode != null)
                          IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            color: Colors.red,
                            onPressed: _removeVoucher,
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.grey[50],
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Subtotal Produk',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Rp ${Provider.of<CartModel>(context).totalPrice.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                if (_discountAmount > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Diskon Voucher',
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                        Text(
                          '-Rp ${_discountAmount.toStringAsFixed(0)}',
                          style: const TextStyle(fontSize: 16, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                const Divider(height: 20, thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Pembayaran',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rp ${totalHarga.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.orange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Rp ${totalHarga.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    if (cart.items.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckoutPage(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Keranjang Anda kosong!')),
                      );
                    }
                  },
                  child: const Text(
                    'Beli Sekarang',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
    _voucherController.dispose();
    Provider.of<CartModel>(context, listen: false).removeListener(_hitungTotalHarga);
    super.dispose();
  }
}