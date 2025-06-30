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
  String _alamatTujuan = 'Jl. Merdeka No. 123, Bandung, Jawa Barat';
  String _metodePengiriman = 'JNE Regular';
  String _estimasiTiba = '18-20 Mar';
  double _biayaPengiriman = 15000.0;
  String _metodePembayaran = 'Transfer Bank';

  double _currentDiscountAmount = 0.0; 
  String? _appliedVoucherCodeFromCart;

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadVoucherInfoFromCart();
    });
  }

  void _loadVoucherInfoFromCart() {
    final cart = Provider.of<CartModel>(context, listen: false);

    setState(() {
      _currentDiscountAmount = cart.appliedDiscountAmount; 
      _appliedVoucherCodeFromCart = cart.appliedVoucherCode; 
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    final history = Provider.of<HistoryModel>(context, listen: false);
    final double subtotalProduk = cart.totalPrice; 
    final double adminBank = 5000.0;
    final double totalPembayaranFinal = subtotalProduk - _currentDiscountAmount + _biayaPengiriman + adminBank;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionCard(
                    title: 'Alamat Tujuan',
                    onUbahPressed: () async {
                      final newAddress = await _showAddressInputDialog(context, _alamatTujuan);
                      if (newAddress != null && newAddress.isNotEmpty) {
                        setState(() {
                          _alamatTujuan = newAddress;
                        });
                      }
                    },
                    child: Text(_alamatTujuan, style: const TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(height: 16),

                  const Text('Ringkasan Pesanan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return Card(
                        elevation: 1,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: Image.asset(item.product.image, width: 50),
                          title: Text(item.product.name),
                          subtitle: Text('Jumlah: ${item.quantity}'),
                          trailing: Text(
                            'Rp${(item.product.price * item.quantity).toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  _buildSectionCard(
                    title: 'Metode Pengiriman',
                    onUbahPressed: () async {
                      final result = await _showShippingOptionsDialog(context, _metodePengiriman);
                      if (result != null) {
                        setState(() {
                          _metodePengiriman = result['name'];
                          _estimasiTiba = result['eta'];
                          _biayaPengiriman = result['cost'];
                        });
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_metodePengiriman, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                        Text('Estimasi tiba: $_estimasiTiba', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPriceRow('Subtotal Produk', subtotalProduk),
                
                if (_currentDiscountAmount > 0)
                  _buildPriceRow('Diskon Voucher', -_currentDiscountAmount), 
                _buildPriceRow('Biaya Pengiriman', _biayaPengiriman),
                _buildPriceRow('Biaya Admin', adminBank),
                const Divider(height: 20),
                _buildPriceRow('Total Pembayaran', totalPembayaranFinal, isTotal: true), 
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: cart.items.isEmpty ? null : () {
                      
                      history.addOrder(
                        cart.items,
                        subtotalProduk, 
                        _currentDiscountAmount, 
                        totalPembayaranFinal, 
                        _appliedVoucherCodeFromCart, 
                      );
                      cart.clearCart();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pesanan berhasil dibuat!')),
                      );

                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: const Text('Bayar Sekarang'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child, required VoidCallback onUbahPressed}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: onUbahPressed,
                  child: const Text('Ubah', style: TextStyle(color: Colors.orange)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    Color textColor = Colors.black87;
    if (isTotal) {
      textColor = Colors.orange;
    } else if (label.contains('Diskon')) { 
      textColor = Colors.red; 
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: textColor, 
            ),
          ),
          Text(
            'Rp ${amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: textColor, 
            ),
          ),
        ],
      ),
    );
  }

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
              hintText: 'Masukkan alamat lengkap',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Simpan'),
              onPressed: () => Navigator.of(context).pop(addressController.text),
            ),
          ],
        );
      },
    );
  }

  Future<Map<String, dynamic>?> _showShippingOptionsDialog(BuildContext context, String currentMethod) {
    final options = [
      {'name': 'JNE Regular', 'eta': '18-20 Mar', 'cost': 15000.0},
      {'name': 'SiCepat Halu', 'eta': '19-21 Mar', 'cost': 12000.0},
      {'name': 'J&T Express', 'eta': '17-19 Mar', 'cost': 18000.0},
    ];

    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Metode Pengiriman'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                final option = options[index];
                return ListTile(
                  title: Text(option['name'] as String),
                  subtitle: Text('Rp${(option['cost'] as double).toStringAsFixed(0)}'),
                  onTap: () {
                    Navigator.of(context).pop(option);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}