// lib/models/cart_model.dart
import 'package:flutter/foundation.dart';
import 'product.dart'; // Pastikan ini mengimpor model Product Anda

// Definisi untuk satu item dalam keranjang belanja
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  // Metode untuk menambah atau mengurangi kuantitas
  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}

// Model untuk mengelola seluruh keranjang belanja
class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void add(Product product) {
    // Cek apakah produk sudah ada di keranjang
    bool found = false;
    for (var item in _items) {
      if (item.product.name == product.name) { // Asumsi name adalah unique identifier
        item.incrementQuantity();
        found = true;
        break;
      }
    }
    if (!found) {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  // Metode remove sekarang menerima Product, bukan CartItem
  void remove(Product product) {
    final index = _items.indexWhere((item) => item.product.name == product.name); // Sesuaikan dengan cara Anda mengidentifikasi produk
    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // Metode removeAll sekarang menerima Product, bukan CartItem
  void removeAll(Product product) {
    _items.removeWhere((item) => item.product.name == product.name); // Sesuaikan dengan cara Anda mengidentifikasi produk
    notifyListeners();
  }

  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }
}