// lib/models/history_model.dart
import 'package:flutter/foundation.dart';
import 'cart_model.dart'; // Impor CartModel untuk definisi CartItem

class HistoryModel extends ChangeNotifier {
  // Mengubah _history menjadi List<List<CartItem>> untuk menyimpan daftar pesanan
  // Setiap pesanan adalah daftar dari CartItem
  final List<List<CartItem>> _orders = [];

  // Mengubah getter untuk mengembalikan _orders
  List<List<CartItem>> get orders => List.unmodifiable(_orders);

  // Mengubah metode untuk menambahkan pesanan (berupa List<CartItem>)
  void addOrder(List<CartItem> newOrderItems) {
    // Buat salinan item agar riwayat tidak terpengaruh jika keranjang berubah
    _orders.add(List<CartItem>.from(newOrderItems));
    notifyListeners();
  }

  void clearHistory() {
    _orders.clear(); // Bersihkan _orders
    notifyListeners();
  }
}