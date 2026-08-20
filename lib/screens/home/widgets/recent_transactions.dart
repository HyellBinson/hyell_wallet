import 'package:flutter/material.dart';
import 'transaction_title.dart';
import '../../transaction/transactions_screen.dart';

class RecentTransaction extends StatelessWidget {
  const RecentTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading
        const SizedBox(height: 12),

        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(18),
          ),

          child: Column(
            children: [
              // see all button
              Row(
                children: [
                  FittedBox(
                    child: Text(
                      'Recent transactions',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  const Spacer(),

                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const TransactionsScreen(),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: const Text('See all'),
                      ),
                    ),
                  ),
                ],
              ),
              // transaction 1
              TransactionTile(
                icon: Icons.wifi_rounded,
                iconColor: Colors.orange,
                title: 'MTN Data',
                subtitle: '1GB • Today',
                amount: '-₦500',
              ),

              // divider
              Divider(
                height: 1,
                indent: 68,
                endIndent: 16,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),

              // transaction 2
              TransactionTile(
                icon: Icons.phone_android_rounded,
                iconColor: Colors.blue,
                title: 'Airtime',
                subtitle: 'MTN • Yesterday',
                amount: '-₦1,000',
              ),
            ],

            // testing the recent transaction design
          ),
        ),
      ],
    );
  }
}
