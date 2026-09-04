import 'package:flutter/material.dart';
import '../data/data_screen.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  bool showFirstTransactionBonus = true;

  DateTime? bonusExpiresAt;

  void _startBonusTimer() {
    setState(() {
      bonusExpiresAt = DateTime.now().add(const Duration(hours: 24));
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========================================================
              // HEADER
              // ========================================================
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Rewards',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_none_rounded,
                      color: colors.onSurface,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ========================================================
              // REWARD BALANCE CARD
              // ========================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Rewards',
                      style: TextStyle(
                        color: colors.onPrimary.withValues(alpha: 0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '2,450',
                      style: TextStyle(
                        color: colors.onPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    Text(
                      'Reward points',
                      style: TextStyle(
                        color: colors.onPrimary.withValues(alpha: 0.8),
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      height: 42,
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: colors.onPrimary,
                          foregroundColor: colors.primary,
                        ),
                        child: const Text(
                          'Redeem',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ========================================================
              // REWARD PROGRESS
              // ========================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: colors.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Your Progress',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),

                        Text(
                          'Bronze',
                          style: TextStyle(
                            color: colors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    Text(
                      '2 purchases',
                      style: TextStyle(
                        fontSize: 13,
                        color: colors.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 8),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: 2 / 3,
                        minHeight: 8,
                        backgroundColor: colors.surfaceContainerHighest,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '1 more purchase to reach Silver',
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ========================================================
              // CASHBACK & BONUSES
              // ========================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: colors.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Cashback & Bonuses',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),

                        Icon(
                          Icons.local_fire_department_rounded,
                          color: colors.primary,
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      'Buy more, earn more',
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 16),

                    _RewardBonusRow(title: '₦500+ purchase', reward: '10–20MB'),

                    const SizedBox(height: 10),

                    _RewardBonusRow(
                      title: '₦1,000+ purchase',
                      reward: '30–50MB',
                    ),

                    const SizedBox(height: 10),

                    _RewardBonusRow(
                      title: '₦2,000+ purchase',
                      reward: 'Bigger reward',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ========================================================
              // FIRST TRANSACTION BONUS
              // ========================================================
              if (showFirstTransactionBonus)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: colors.outlineVariant),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: colors.primary.withValues(alpha: 0.10),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.celebration_rounded,
                          color: colors.primary,
                          size: 23,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'First Transaction Bonus',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              'Your first transaction unlocked a free 50MB bonus.',

                              style: TextStyle(
                                fontSize: 12,
                                height: 1.4,
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                            if (bonusExpiresAt != null) ...[
                              const SizedBox(height: 6),
                              Text(
                                'Expires in 24 hours',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: colors.primary,
                                ),
                              ),
                            ],

                            const SizedBox(height: 12),

                            Row(
                              children: [
                                Icon(
                                  Icons.card_giftcard_rounded,
                                  size: 18,
                                  color: colors.primary,
                                ),

                                const SizedBox(width: 6),

                                Text(
                                  '50MB bonus',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: colors.primary,
                                  ),
                                ),

                                const Spacer(),

                                SizedBox(
                                  height: 36,
                                  child: FilledButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const DataScreen(
                                            isClaimingBonus: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Claim',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),

              // refer and earn
              // ========================================================
              // REFERRAL + ACTIVITY REWARD
              // ========================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: colors.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: colors.primary.withValues(alpha: 0.10),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.people_alt_rounded,
                            color: colors.primary,
                            size: 23,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Referral + Activity',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                'Invite friends and stay active to unlock bigger rewards.',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.4,
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // Transaction requirement
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_cart_checkout_rounded,
                            size: 20,
                            color: colors.primary,
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              'Make an eligible transaction',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),

                          Icon(
                            Icons.check_circle_outline_rounded,
                            size: 20,
                            color: colors.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Referral requirement
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_add_alt_1_rounded,
                            size: 20,
                            color: colors.primary,
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              'Refer 1 friend or stay active',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),

                          Icon(
                            Icons.lock_outline_rounded,
                            size: 20,
                            color: colors.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 11,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.card_giftcard_rounded,
                            size: 20,
                            color: colors.primary,
                          ),

                          const SizedBox(width: 8),

                          Text(
                            'Unlock up to 50MB',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: colors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              // ========================================================
              // WAYS TO EARN
              // ========================================================
              Text(
                'Ways to earn',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),

              const SizedBox(height: 12),

              // We'll build the earning cards next.
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  final columns = width < 330 ? 1 : 2;

                  return GridView.count(
                    crossAxisCount: columns,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: columns == 1 ? 3.2 : 1.35,
                    children: [
                      _RewardEarnCard(
                        icon: Icons.card_giftcard_rounded,
                        title: 'Daily Bonus',
                        subtitle: 'Claim your daily reward',
                        onTap: () {},
                      ),

                      _RewardEarnCard(
                        icon: Icons.people_alt_outlined,
                        title: 'Refer Friends',
                        subtitle: 'Earn when friends join',
                        onTap: () {},
                      ),

                      _RewardEarnCard(
                        icon: Icons.phone_android_rounded,
                        title: 'Buy Data & Airtime',
                        subtitle: 'Earn rewards from purchases',
                        onTap: () {},
                      ),

                      _RewardEarnCard(
                        icon: Icons.account_balance_wallet_outlined,
                        title: 'Cashback',
                        subtitle: 'Get cashback on eligible purchases',
                        onTap: () {},
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RewardEarnCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _RewardEarnCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.outlineVariant),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: colors.primary, size: 21),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            Icon(Icons.chevron_right_rounded, color: colors.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

// rewardbonus row

class _RewardBonusRow extends StatelessWidget {
  final String title;
  final String reward;

  const _RewardBonusRow({required this.title, required this.reward});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.card_giftcard_rounded, size: 20, color: colors.primary),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ),

          Text(
            reward,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: colors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
