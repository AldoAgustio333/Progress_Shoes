import 'package:flutter/foundation.dart';
import 'cart_model.dart'; // Import model produk & cart item

class HistoryModel extends ChangeNotifier {
  final List<CartItem> _history = [];

  List<CartItem> get history => List.unmodifiable(_history);

  void addToHistory(List<CartItem> purchasedItems) {
    // Tambah semua item ke history
    _history.addAll(purchasedItems);
    notifyListeners();
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }
}
