import 'package:flutter/foundation.dart';
import 'package:e_shoes/models/cart_model.dart';
import 'package:e_shoes/models/product.dart'; 

class Order {
  final List<CartItem> items;
  final double subtotalBeforeDiscount; 
  final double discountAmount; 
  final double finalTotalPrice; 
  final String? appliedVoucherCode; 
  final DateTime orderDate; 
  

  Order({
    required this.items,
    required this.subtotalBeforeDiscount,
    required this.discountAmount,
    required this.finalTotalPrice,
    this.appliedVoucherCode,
    required this.orderDate,
  });
}


class HistoryModel extends ChangeNotifier {
  
  final List<Order> _orders = []; 

  List<Order> get orders => List.unmodifiable(_orders); 

  void addOrder(List<CartItem> newOrderItems, double subtotal, double discount, double finalTotal, String? voucherCode) { // <--- Perubahan parameter di sini
    final newOrder = Order(
      items: List<CartItem>.from(newOrderItems), 
      subtotalBeforeDiscount: subtotal,
      discountAmount: discount,
      finalTotalPrice: finalTotal,
      appliedVoucherCode: voucherCode,
      orderDate: DateTime.now(), 
    );
    _orders.insert(0, newOrder); 
    notifyListeners();
  }

  void clearHistory() {
    _orders.clear();
    notifyListeners();
  }
}