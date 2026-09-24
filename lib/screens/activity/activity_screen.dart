import 'package:flutter/material.dart';
import 'package:hyell_wallet/core/constants/app_colors.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> activities = [
    {
      'title': 'MTN Data',
      'subtitle': '1GB • Today, 10:32 AM',
      'amount': '-₦500',
      'type': 'Data',
      'icon': Icons.wifi_rounded,
      'isCredit': false,
    },
    {
      'title': 'Airtime',
      'subtitle': 'MTN • Today, 09:15 AM',
      'amount': '-₦1,000',
      'type': 'Airtime',
      'icon': Icons.phone_android_rounded,
      'isCredit': false,
    },
    {
      'title': 'Money Received',
      'subtitle': 'Wallet funding • Today, 08:20 AM',
      'amount': '+₦5,000',
      'type': 'Wallet',
      'icon': Icons.account_balance_wallet_outlined,
      'isCredit': true,
    },
    {
      'title': 'Airtel Data',
      'subtitle': '2GB • Yesterday, 06:45 PM',
      'amount': '-₦1,200',
      'type': 'Data',
      'icon': Icons.wifi_rounded,
      'isCredit': false,
    },
    {
      'title': 'Money Received',
      'subtitle': 'Wallet funding • Yesterday, 02:10 PM',
      'amount': '+₦2,000',
      'type': 'Wallet',
      'icon': Icons.account_balance_wallet_outlined,
      'isCredit': true,
    },
    {
      'title': 'Glo Airtime',
      'subtitle': 'Glo • Yesterday, 11:30 AM',
      'amount': '-₦500',
      'type': 'Airtime',
      'icon': Icons.phone_android_rounded,
      'isCredit': false,
    },
  ];

  List<Map<String, dynamic>> get filteredActivities {
    if (selectedFilter == 'All') {
      return activities;
    }

    return activities
        .where((activity) => activity['type'] == selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark
        ? AppColors.backgroundDark
        : AppColors.background;

    final surfaceColor = isDark ? AppColors.surfaceDark : AppColors.surface;

    final primaryTextColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimary;

    final secondaryTextColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondary;

    final filtered = filteredActivities;

    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                ),

                Expanded(
                  child: Text(
                    'Activity History',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            _buildFilters(
              isDark: isDark,
              surfaceColor: surfaceColor,
              secondaryTextColor: secondaryTextColor,
            ),

            const SizedBox(height: 10),

            Expanded(
              child: filtered.isEmpty
                  ? _buildEmptyState(
                      primaryTextColor: primaryTextColor,
                      secondaryTextColor: secondaryTextColor,
                    )
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                      children: [
                        _buildSection(
                          title: 'Today',
                          items: filtered
                              .where(
                                (item) => item['subtitle'].toString().contains(
                                  'Today',
                                ),
                              )
                              .toList(),
                          surfaceColor: surfaceColor,
                          primaryTextColor: primaryTextColor,
                          secondaryTextColor: secondaryTextColor,
                        ),

                        _buildSection(
                          title: 'Yesterday',
                          items: filtered
                              .where(
                                (item) => item['subtitle'].toString().contains(
                                  'Yesterday',
                                ),
                              )
                              .toList(),
                          surfaceColor: surfaceColor,
                          primaryTextColor: primaryTextColor,
                          secondaryTextColor: secondaryTextColor,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters({
    required bool isDark,
    required Color surfaceColor,
    required Color secondaryTextColor,
  }) {
    final filters = ['All', 'Data', 'Airtime', 'Wallet'];

    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 10);
        },
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilter = filter;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : surfaceColor,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.divider,
                ),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected ? Colors.white : secondaryTextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Map<String, dynamic>> items,
    required Color surfaceColor,
    required Color primaryTextColor,
    required Color secondaryTextColor,
  }) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            title,
            style: TextStyle(
              color: secondaryTextColor,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        ...items.map(
          (activity) => _buildActivityItem(
            activity,
            surfaceColor: surfaceColor,
            primaryTextColor: primaryTextColor,
            secondaryTextColor: secondaryTextColor,
          ),
        ),

        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildActivityItem(
    Map<String, dynamic> activity, {
    required Color surfaceColor,
    required Color primaryTextColor,
    required Color secondaryTextColor,
  }) {
    final bool isCredit = activity['isCredit'];

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.primarySoft,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(activity['icon'], color: AppColors.primary, size: 23),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'],
                  style: TextStyle(
                    color: primaryTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  activity['subtitle'],
                  style: TextStyle(color: secondaryTextColor, fontSize: 12),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          Text(
            activity['amount'],
            style: TextStyle(
              color: isCredit ? AppColors.success : primaryTextColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required Color primaryTextColor,
    required Color secondaryTextColor,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                color: AppColors.primary,
                size: 35,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              'No activity yet',
              style: TextStyle(
                color: primaryTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Your transactions will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(color: secondaryTextColor, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
