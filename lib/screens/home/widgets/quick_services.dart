import 'package:flutter/material.dart';
import '../../data/data_screen.dart';
import '../../airtime/airtime_screen.dart';
import '../../electricity/electricity_screen.dart';
import '../../more/more_screen.dart';

class QuickServices extends StatelessWidget {
  const QuickServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick services',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),

        Row(
          children: [
            // All Services
            Expanded(
              child: _ServiceTile(
                icon: Icons.wifi_rounded,
                title: 'Data',
                onTap: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const DataScreen()));
                },
              ),
            ),
            const SizedBox(width: 8),

            Expanded(
              child: _ServiceTile(
                icon: Icons.phone_iphone_rounded,
                title: 'Airtime',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AirtimeScreen()),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),

            Expanded(
              child: _ServiceTile(
                icon: Icons.bolt_rounded,
                title: 'Electricity',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ElectricityScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),

            Expanded(
              child: _ServiceTile(
                icon: Icons.apps_rounded,
                title: 'More',

                onTap: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const MoreScreen()));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ServiceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const _ServiceTile({required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 21,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
