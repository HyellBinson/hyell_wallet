class DataTransaction {
  final String id;
  final String network;
  final String phoneNumber;
  final String data;
  final String validity;
  final double amount;
  final String status;
  final String reference;
  final DateTime createdAt;

  const DataTransaction({
    required this.id,
    required this.network,
    required this.phoneNumber,
    required this.data,
    required this.validity,
    required this.amount,
    required this.status,
    required this.reference,
    required this.createdAt,
  });
}
