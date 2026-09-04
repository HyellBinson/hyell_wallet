import 'package:flutter/material.dart';
import 'package:hyell_wallet/core/constants/app_colors.dart';
import 'data_transaction.dart';

class DataHistoryScreen extends StatelessWidget {
  const DataHistoryScreen({super.key});

  List<DataTransaction> get transactions {
    return [
      DataTransaction(
        id: '1',
        network: 'MTN',
        phoneNumber: '08012345678',
        data: '1GB',
        validity: '30 days',
        amount: 500,
        status: 'Successful',
        reference: 'HYD-839201',
        createdAt: DateTime.now(),
      ),

      DataTransaction(
        id: '2',
        network: 'Airtel',
        phoneNumber: '09012345678',
        data: '2GB',
        validity: '30 days',
        amount: 850,
        status: 'Successful',
        reference: 'HYD-839202',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),

      DataTransaction(
        id: '3',
        network: 'Glo',
        phoneNumber: '08112345678',
        data: '1GB',
        validity: '30 days',
        amount: 400,
        status: 'Failed',
        reference: 'HYD-839203',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data History',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),

      body: SafeArea(
        child: transactions.isEmpty
            ? _EmptyHistory(colors: colors)
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                itemCount: transactions.length,
                separatorBuilder: (_, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final transaction = transactions[index];

                  return _TransactionCard(transaction: transaction);
                },
              ),
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final DataTransaction transaction;

  const _TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final isSuccessful = transaction.status == 'Successful';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant),
      ),

      child: Row(
        children: [
          // Network logo
          _NetworkHistoryLogo(network: transaction.network),

          const SizedBox(width: 12),

          // Transaction information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${transaction.network} Data',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '${transaction.data} • ${transaction.phoneNumber}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  transaction.status,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isSuccessful ? AppColors.success : colors.error,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '-₦${transaction.amount.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                _formatDate(transaction.createdAt),
                style: TextStyle(fontSize: 10, color: colors.onSurfaceVariant),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();

    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return 'Today';
    }

    return 'Yesterday';
  }
}

class _NetworkHistoryLogo extends StatelessWidget {
  final String network;

  const _NetworkHistoryLogo({required this.network});

  String get assetPath {
    switch (network) {
      case 'MTN':
        return 'assets/images/networks/mtn.png';

      case 'Airtel':
        return 'assets/images/networks/airtel.png';

      case 'Glo':
        return 'assets/images/networks/glo.png';

      case 'T2mobile':
        return 'assets/images/networks/T2mobile.png';

      default:
        return 'assets/images/networks/T2mobile.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        shape: BoxShape.circle,
      ),
      child: Image.asset(assetPath, fit: BoxFit.contain),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  final ColorScheme colors;

  const _EmptyHistory({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 55,
              color: colors.onSurfaceVariant,
            ),

            const SizedBox(height: 15),

            const Text(
              'No data transactions yet',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),

            const SizedBox(height: 6),

            Text(
              'Your data purchases will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
