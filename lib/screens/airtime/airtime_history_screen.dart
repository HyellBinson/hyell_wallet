import 'package:flutter/material.dart';
import 'package:hyell_wallet/core/constants/app_colors.dart';
import 'airtime_transaction.dart';

class AirtimeHistoryScreen extends StatelessWidget {
  const AirtimeHistoryScreen({super.key});

  List<AirtimeTransaction> get transactions {
    return [
      AirtimeTransaction(
        id: '1',
        network: 'MTN',
        phoneNumber: '08012345678',
        amount: 500,
        status: 'Successful',
        reference: 'HYA-839201',
        createdAt: DateTime.now(),
      ),

      AirtimeTransaction(
        id: '2',
        network: 'Airtel',
        phoneNumber: '09012345678',
        amount: 1000,
        status: 'Successful',
        reference: 'HYA-839202',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),

      AirtimeTransaction(
        id: '3',
        network: 'Glo',
        phoneNumber: '08112345678',
        amount: 200,
        status: 'Failed',
        reference: 'HYA-839203',
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
          'Airtime History',
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
  final AirtimeTransaction transaction;

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
          _NetworkHistoryLogo(network: transaction.network),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${transaction.network} Airtime',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  transaction.phoneNumber,
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
              Icons.phone_android_outlined,
              size: 55,
              color: colors.onSurfaceVariant,
            ),

            const SizedBox(height: 15),

            const Text(
              'No airtime transactions yet',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),

            const SizedBox(height: 6),

            Text(
              'Your airtime purchases will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
