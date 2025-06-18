import 'package:flutter/foundation.dart';
import 'cart_model.dart'; 

class HistoryModel extends ChangeNotifier {
  final List<List<CartItem>> _orders = [];

  List<List<CartItem>> get orders => List.unmodifiable(_orders);

  void addOrder(List<CartItem> newOrderItems) {
    _orders.add(List<CartItem>.from(newOrderItems));
    notifyListeners();
  }

  void clearHistory() {
    _orders.clear(); 
    notifyListeners();
  }
}