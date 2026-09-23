import 'package:flutter/material.dart';

import 'widgets/balance_card.dart';
import '../home/widgets/recent_transactions.dart';
import 'widgets/quick_services.dart';
import 'widgets/offers_section.dart';
import 'widgets/rewards_preview.dart';
import '../notifications/notification_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final sectionSpacing = screenHeight < 300 ? 4.0 : 8.0;

    final screenWidth = MediaQuery.of(context).size.width;
    final sectionWidthSpacing = screenWidth < 400 ? 4.0 : 8.0;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0D0F0E)
          : const Color(0xFFF8FAF9),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // 🔒 FIXED HEADER
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: isDark
                        ? const Color(0xFF00C853)
                        : const Color(0xFF00C853),
                    child: Icon(
                      Icons.person_outline,
                      size: 24,
                      color: isDark ? Colors.black : Colors.black,
                    ),
                  ),

                  SizedBox(width: sectionWidthSpacing),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good day 👋',
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark
                                ? const Color(0xFF9CA3AF)
                                : Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          'Hyell',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? const Color(0xFFF8FAF9)
                                : const Color(0xFF101412),
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const NotificationsScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.notifications_none_rounded,
                      size: 27,
                      color: isDark
                          ? const Color(0xFFF8FAF9)
                          : const Color(0xFF101412),
                    ),
                  ),
                ],
              ),

              SizedBox(height: sectionSpacing),

              // 📜 SCROLLABLE CONTENT
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const BalanceCard(balance: 150000),

                      // Recent transaction linking
                      Transform.translate(
                        offset: const Offset(0, -10),
                        child: const RecentTransaction(),
                      ),

                      // Quick service linking
                      Transform.translate(
                        offset: const Offset(0, -4),
                        child: const QuickServices(),
                      ),

                      // Offers section linking
                      Transform.translate(
                        offset: const Offset(0, 10),
                        child: const OffersSection(),
                      ),

                      // Rewards section linking
                      Transform.translate(
                        offset: const Offset(0, 20),
                        child: const RewardsPreview(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
