class Voucher {
  final String id; 
  final String code;
  final double discountAmount;
  final String discountType; 
  final DateTime? expiryDate;
  final bool isOneTimeUse;

  Voucher({
    required this.id,
    required this.code,
    required this.discountAmount,
    required this.discountType,
    this.expiryDate,
    this.isOneTimeUse = false,
  });

  factory Voucher.fromJson(Map<String, dynamic> json, String id) {
    return Voucher(
      id: id, 
      code: json['code'] as String,
      discountAmount: (json['discountAmount'] as num).toDouble(), 
      discountType: json['discountType'] as String,
      expiryDate: json['expiryDate'] != null
          ? (json['expiryDate'] as dynamic).toDate() 
          : null,
      isOneTimeUse: json['isOneTimeUse'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'discountAmount': discountAmount,
      'discountType': discountType,
      'isOneTimeUse': isOneTimeUse,
      'expiryDate': expiryDate != null ? expiryDate!.toIso8601String() : null, 
    };
  }
}