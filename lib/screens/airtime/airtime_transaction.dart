class AirtimeTransaction {
  final String id;
  final String network;
  final String phoneNumber;
  final double amount;
  final String status;
  final String reference;
  final DateTime createdAt;

  AirtimeTransaction({
    required this.id,
    required this.network,
    required this.phoneNumber,
    required this.amount,
    required this.status,
    required this.reference,
    required this.createdAt,
  });
}
