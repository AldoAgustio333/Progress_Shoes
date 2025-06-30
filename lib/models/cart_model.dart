import 'package:flutter/foundation.dart';
import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  double _appliedDiscountAmount = 0.0;
  String? _appliedVoucherCode;

  List<CartItem> get items => _items;

  double get appliedDiscountAmount => _appliedDiscountAmount;
  String? get appliedVoucherCode => _appliedVoucherCode;

  void add(Product product) {
    bool found = false;
    for (var item in _items) {
      if (item.product.name == product.name) {
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

  void remove(Product product) {
    final index = _items.indexWhere((item) => item.product.name == product.name);
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
    _appliedDiscountAmount = 0.0;
    _appliedVoucherCode = null;
    notifyListeners();
  }

  void removeAll(Product product) {
    _items.removeWhere((item) => item.product.name == product.name);
    notifyListeners();
  }

  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  void setVoucherDiscount(double amount, String? code) {
    _appliedDiscountAmount = amount;
    _appliedVoucherCode = code;
    notifyListeners(); 
  }
}