import 'package:flutter/material.dart';
import 'package:hyell_wallet/core/constants/app_colors.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Offers for you',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),

            const SizedBox(width: 8),

            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('See all'),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.primaryDark,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get more from HYELL',
                      style: TextStyle(
                        color: colors.onPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Buy data and airtime, earn rewards.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.onPrimary.withValues(alpha: 0.85),
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 12),

                    FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: colors.onPrimary,
                        foregroundColor: colors.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text('Explore'),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              Icon(
                Icons.card_giftcard_rounded,
                color: colors.onPrimary,
                size: 55,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
