class PaymentMethodModel {
  final String methodId;
  final String userId;
  final String type; // card, wallet, upi, cash
  final String? cardLastFour;
  final String? cardBrand;
  final String? upiId;
  final bool isDefault;
  final DateTime createdAt;

  PaymentMethodModel({
    required this.methodId,
    required this.userId,
    required this.type,
    this.cardLastFour,
    this.cardBrand,
    this.upiId,
    this.isDefault = false,
    required this.createdAt,
  });
}