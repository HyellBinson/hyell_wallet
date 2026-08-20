import 'package:flutter/material.dart';
import 'widgets/balance_card.dart';
import '../home/widgets/recent_transactions.dart';
import 'widgets/quick_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final sectionSpacing = screenHeight < 300 ? 4.0 : 8.0;

    final screenWidth = MediaQuery.of(context).size.width;
    final sectionWidthSpacing = screenWidth < 400 ? 4.0 : 8.0;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // 🔒 FIXED HEADER
              Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    child: Icon(Icons.person_outline, size: 24),
                  ),

                  SizedBox(width: sectionWidthSpacing),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Good day 👋',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),

                        const SizedBox(height: 2),

                        const Text(
                          'Hyell',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      size: 27,
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

                      Transform.translate(
                        offset: const Offset(0, -10),
                        child: const RecentTransaction(),
                      ),

                      Transform.translate(
                        offset: const Offset(0, -4),
                        child: const QuickServices(),
                      ),

                      const SizedBox(height: 10),
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
