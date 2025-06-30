import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/voucher.dart';

class VoucherService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Voucher?> getVoucherByCode(String code) async {
    try {
      
      QuerySnapshot query = await _firestore
          .collection('vouchers')
          .where('code', isEqualTo: code.toUpperCase()) 
          .limit(1) 
          .get();

      if (query.docs.isNotEmpty) {
        
        return Voucher.fromJson(query.docs.first.data() as Map<String, dynamic>, query.docs.first.id);
      } else {
        return null; 
      }
    } catch (e) {
      print('Error getting voucher: $e');
      return null;
    }
  }

  Future<bool> markVoucherAsUsed(String voucherId, String userId) async {
    try {
      await _firestore.collection('vouchers').doc(voucherId).update({
        'usersUsed': FieldValue.arrayUnion([userId]), 
      });
      return true;
    } catch (e) {
      print('Error marking voucher as used: $e');
      return false;
    }
  }
}