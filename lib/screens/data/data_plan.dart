class DataPlan {
  final String id;
  final String network;
  final String data;
  final String validity;
  final double price;
  final String category;
  final bool isActive;

  const DataPlan({
    required this.id,
    required this.network,
    required this.data,
    required this.validity,
    required this.price,
    required this.category,
    this.isActive = true,
  });
}

final List<DataPlan> dataPlans = [
  const DataPlan(
    id: 'mtn-1gb-30d',
    network: 'MTN',
    data: '1GB',
    validity: '30 days',
    price: 500,
    category: 'Monthly',
  ),

  const DataPlan(
    id: 'mtn-2gb-30d',
    network: 'MTN',
    data: '2GB',
    validity: '30 days',
    price: 900,
    category: 'Monthly',
  ),

  const DataPlan(
    id: 'mtn-sme-1',
    network: 'MTN',
    data: '2GB',
    validity: '30 Days',
    price: 500,
    category: 'SME',
  ),

  const DataPlan(
    id: 'mtn-hot-1',
    network: 'MTN',
    data: '1GB',
    validity: '1 Day',
    price: 480,
    category: 'Hot',
  ),

  const DataPlan(
    id: 'mtn-gifting-1',
    network: 'MTN',
    data: '3GB',
    validity: '30 Days',
    price: 800,
    category: 'Gifting',
  ),

  const DataPlan(
    id: 'mtn-5gb-30d',
    network: 'MTN',
    data: '5GB',
    validity: '30 days',
    price: 2000,
    category: 'Monthly',
  ),

  const DataPlan(
    id: 'airtel-1gb-30d',
    network: 'Airtel',
    data: '1GB',
    validity: '30 days',
    price: 450,
    category: 'Monthly',
  ),

  const DataPlan(
    id: 'airtel-2gb-30d',
    network: 'Airtel',
    data: '2GB',
    validity: '30 days',
    price: 850,
    category: 'Monthly',
  ),

  const DataPlan(
    id: 'glo-1gb-30d',
    network: 'Glo',
    data: '1GB',
    validity: '30 days',
    price: 400,
    category: 'Monthly',
  ),

  const DataPlan(
    id: 'glo-2gb-30d',
    network: 'Glo',
    data: '2GB',
    validity: '30 days',
    price: 750,
    category: 'Monthly',
  ),

  const DataPlan(
    id: 'T2mobile-1gb-30d',
    network: 'T2mobile',
    data: '1GB',
    validity: '30 days',
    price: 500,
    category: 'Monthly',
  ),

  const DataPlan(
    id: 'T2mobile-2gb-30d',
    network: 'T2mobile',
    data: '2GB',
    validity: '30 days',
    price: 900,
    category: 'Monthly',
  ),
];
