import 'package:flutter/material.dart';
import 'package:hyell_wallet/core/constants/app_colors.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../data/data_plan.dart';
import '../security/setup_pin_screen.dart';
import '../security/enter_pin_screen.dart';
import '../data/data_history_screen.dart';

import '../../widgets/enter_pin_sheet.dart';
import '../../models/transaction_model.dart';

class DataScreen extends StatefulWidget {
  final bool isClaimingBonus;
  const DataScreen({super.key, this.isClaimingBonus = false});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  String? selectedNetwork;
  String selectedCategory = 'Hot';
  String? selectedPlanId;
  String phoneNumber = '';

  DataPlan? get selectedPlan {
    if (selectedPlanId == null) {
      return null;
    }

    try {
      return dataPlans.firstWhere((plan) => plan.id == selectedPlanId);
    } catch (_) {
      return null;
    }
  }

  final List<String> categories = [
    'Hot',
    'Daily',
    'Weekly',
    'Monthly',
    'SME',
    'Gifting',
  ];

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
              // header
              // ===============================================================
              // Heder
              // =============================================================
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                    ),
                  ),

                  const Expanded(
                    child: Text(
                      'Mobile Data',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DataHistoryScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'History',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // ======================================================
              // Banner
              // =========================================================
              AspectRatio(
                aspectRatio: 2.8,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primaryDark,
                    borderRadius: BorderRadius.circular(18),
                  ),

                  alignment: Alignment.center,
                  child: Text(
                    'Mobile Data',
                    style: TextStyle(
                      color: colors.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),
              // ======================================================
              // Select Network
              // =========================================================
              Text(
                'Select Network',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _NetworkTile(
                      name: 'MTN',
                      isSelected: selectedNetwork == 'MTN',
                      onTap: () {
                        setState(() {
                          selectedNetwork = 'MTN';
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 6),

                  Expanded(
                    child: _NetworkTile(
                      name: 'Airtel',
                      isSelected: selectedNetwork == 'Airtel',
                      onTap: () {
                        setState(() {
                          selectedNetwork = 'Airtel';
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 6),

                  Expanded(
                    child: _NetworkTile(
                      name: 'Glo',
                      isSelected: selectedNetwork == 'Glo',
                      onTap: () {
                        setState(() {
                          selectedNetwork = 'Glo';
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 6),

                  Expanded(
                    child: _NetworkTile(
                      name: 'T2mobile',
                      isSelected: selectedNetwork == 'T2mobile',
                      onTap: () {
                        setState(() {
                          selectedNetwork = 'T2mobile';
                        });
                      },
                    ),
                  ),
                ],
              ),

              // ====================================================
              // Phone number
              // ======================================================
              if (selectedNetwork != null) ...[
                const SizedBox(height: 18),

                Text(
                  'Phone number',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 10),

                _PhoneNumberField(
                  network: selectedNetwork!,
                  onChanged: (value) {
                    setState(() {
                      phoneNumber = value;
                    });
                  },
                ),

                const SizedBox(height: 20),

                if (widget.isClaimingBonus)
                  _BonusClaimSection(
                    phoneNumber: phoneNumber,
                    network: selectedNetwork!,
                  )
                else
                  _DataPlansSection(
                    selectedNetwork: selectedNetwork!,
                    selectedCategory: selectedCategory,
                    onCategorySelected: (category) {
                      setState(() {
                        selectedCategory = category;
                        selectedPlanId = null;
                      });
                    },
                    selectedPlanId: selectedPlanId,
                    onPlanSelected: (planId) {
                      setState(() {
                        selectedPlanId = planId;
                      });

                      final plan = dataPlans.firstWhere(
                        (plan) => plan.id == planId,
                      );

                      _showPurchaseSheet(context, plan);
                    },
                  ),
              ],

              // ===========================================================
              // Data Plans
              // ===========================================================
            ],
          ),
        ),
      ),
    );
  }

  void _showPurchaseSheet(BuildContext context, DataPlan plan) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.50,
          minChildSize: 0.35,
          maxChildSize: 0.85,
          expand: false,
          builder: (context, scrollController) {
            return _PurchaseBottomSheet(
              network: selectedNetwork!,
              phoneNumber: phoneNumber,
              plan: plan,
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }
}

class _PurchaseBottomSheet extends StatelessWidget {
  final String network;
  final String phoneNumber;
  final DataPlan plan;
  final ScrollController scrollController;

  const _PurchaseBottomSheet({
    required this.network,
    required this.phoneNumber,
    required this.plan,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
        children: [
          Center(
            child: Container(
              width: 42,
              height: 5,
              decoration: BoxDecoration(
                color: colors.onSurfaceVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            'Purchase Data',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w800,
              color: colors.onSurface,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _SummaryItem(title: 'Network', value: network),
              ),

              Expanded(
                child: _SummaryItem(
                  title: 'Phone',
                  value: phoneNumber.isEmpty ? 'Not entered' : phoneNumber,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: _SummaryItem(title: 'Data', value: plan.data),
              ),

              Expanded(
                child: _SummaryItem(title: 'Validity', value: plan.validity),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Divider(color: colors.outlineVariant),

          const SizedBox(height: 14),

          Row(
            children: [
              const Expanded(
                child: Text(
                  'Total',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),

              Text(
                '₦${plan.price.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: colors.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: phoneNumber.trim().isEmpty
                  ? null
                  : () async {
                      Navigator.pop(context);

                      final pinConfirmed = await showModalBottomSheet<bool>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const EnterPinSheet(),
                      );

                      if (pinConfirmed == true) {
                        // Actual purchase logic will come here later.
                      }
                    },
              child: const Text(
                'Confirm',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// pin

// pin

class _PurchaseSummary extends StatelessWidget {
  final String network;
  final String phoneNumber;
  final DataPlan plan;

  const _PurchaseSummary({
    required this.network,
    required this.phoneNumber,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
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
          Text(
            'Purchase Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: colors.onSurface,
            ),
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: _SummaryItem(title: 'Network', value: network),
              ),

              Expanded(
                child: _SummaryItem(
                  title: 'Phone',
                  value: phoneNumber.isEmpty ? 'Not entered' : phoneNumber,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: _SummaryItem(title: 'Data', value: plan.data),
              ),

              Expanded(
                child: _SummaryItem(title: 'Validity', value: plan.validity),
              ),
            ],
          ),

          const SizedBox(height: 18),

          const Divider(),

          const SizedBox(height: 12),

          Row(
            children: [
              const Expanded(
                child: Text(
                  'Total',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),

              Text(
                '₦${plan.price.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: colors.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: phoneNumber.trim().isEmpty
                  ? null
                  : () {
                      // Purchase logic will come here.
                    },
              child: const Text('Buy Data'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String title;
  final String value;

  const _SummaryItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            color: colors.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

// ===================================================================
// _Network tile
class _NetworkTile extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const _NetworkTile({
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        constraints: const BoxConstraints(minHeight: 48),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primary.withValues(alpha: 0.10)
              : colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.dividerDark
                : AppColors.divider,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isSelected ? AppColors.success : colors.onSurface,
                ),
              ),
            ),

            if (isSelected) ...[
              const SizedBox(width: 2),

              Icon(Icons.check_rounded, size: 14, color: AppColors.primaryDark),
            ],
          ],
        ),
      ),
    );
  }
}

class _PhoneNumberField extends StatefulWidget {
  final String network;
  final ValueChanged<String> onChanged;

  const _PhoneNumberField({required this.network, required this.onChanged});

  @override
  State<_PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<_PhoneNumberField> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _phoneController.addListener(() {
      widget.onChanged(_phoneController.text);
    });
  }

  Future<void> _pickContact() async {
    print('Opening contacts...');

    final permission = await FlutterContacts.permissions.request(
      PermissionType.read,
    );

    print('Contacts permission: $permission');

    final contact = await FlutterContacts.native.showPicker(
      properties: {ContactProperty.phone},
    );

    print('Contact returned: $contact');

    if (!mounted || contact == null) {
      print('No contact returned');
      return;
    }

    print('Contact name: ${contact.displayName}');
    print('Number of phones: ${contact.phones.length}');

    if (contact.phones.isEmpty) {
      print('This contact has no phone number');
      return;
    }

    print('Selected contact number: ${contact.phones.first.number}');

    _phoneController.text = contact.phones.first.number;

    print('Number placed in controller: ${_phoneController.text}');
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return TextField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Enter phone number',

        prefixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: _NetworkLogo(network: widget.network),
        ),

        suffixIcon: IconButton(
          onPressed: _pickContact,
          icon: Icon(Icons.contacts_outlined, color: AppColors.primaryDark),
        ),

        // ...the rest of your decoration
        filled: true,
        fillColor: colors.surface,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.outlineVariant),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.outlineVariant),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
      ),
    );
  }
}

class _NetworkLogo extends StatelessWidget {
  final String network;

  const _NetworkLogo({required this.network});

  String get assetPath {
    switch (network) {
      case 'MTN':
        return 'assets/images/networks/mtn.png';

      case 'Airtel':
        return 'assets/images/networks/airtel.png';

      case 'Glo':
        return 'assets/images/networks/glo.png';

      case 'T2':
        return 'assets/images/networks/T2.png';

      default:
        return 'assets/images/networks/T2mobile.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(assetPath, width: 28, height: 28, fit: BoxFit.contain);
  }
}

// data plan section

class _DataPlansSection extends StatelessWidget {
  final String selectedNetwork;
  final String selectedCategory;
  final void Function(String) onCategorySelected;
  final String? selectedPlanId;
  final ValueChanged<String> onPlanSelected;

  const _DataPlansSection({
    required this.selectedNetwork,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.selectedPlanId,
    required this.onPlanSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final categories = ['Hot', 'Daily', 'Weekly', 'Monthly', 'SME', 'Gifting'];

    // Get only plans belonging to the selected network.
    final plans = dataPlans.where((plan) {
      return plan.network == selectedNetwork &&
          plan.category == selectedCategory &&
          plan.isActive;
    }).toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.dividerDark
              : AppColors.divider,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ============================================================
          // TITLE
          // ============================================================
          Row(
            children: [
              Expanded(
                child: Text(
                  'Data Plans',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),

              IconButton(
                onPressed: () {},
                icon: Icon(Icons.grid_view_rounded, color: colors.primary),
              ),

              IconButton(
                onPressed: () {},
                icon: Icon(Icons.apps_rounded, color: colors.onSurfaceVariant),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ============================================================
          // CATEGORIES
          // ============================================================
          SizedBox(
            height: 42,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;

                return GestureDetector(
                  onTap: () {
                    onCategorySelected(category);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? colors.primary : colors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? colors.primary
                            : colors.outlineVariant,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? colors.onPrimary
                              : colors.onSurface,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // ============================================================
          // PLAN GRID
          // ============================================================
          if (plans.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),

              child: Center(
                child: Text(
                  'No data plans available',
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final columns = width < 320 ? 2 : 3;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: plans.length,

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.82,
                  ),

                  itemBuilder: (context, index) {
                    final plan = plans[index];

                    return _DataPlanCard(
                      data: plan.data,
                      validity: plan.validity,
                      price: plan.price,
                      isSelected: selectedPlanId == plan.id,
                      onTap: () {
                        onPlanSelected(plan.id);
                      },
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }
}

class _DataPlanCard extends StatelessWidget {
  final String data;
  final String validity;
  final double price;
  final bool isSelected;
  final VoidCallback onTap;

  const _DataPlanCard({
    required this.data,
    required this.validity,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? colors.primary : colors.primary,
            width: 1,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                validity,
                style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
              Text(
                '₦${price.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: colors.primary,
                ),
              ),
              if (isSelected) ...[
                const SizedBox(height: 5),
                Icon(
                  Icons.check_circle_rounded,
                  size: 18,
                  color: AppColors.success,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
// data bonus

class _BonusClaimSection extends StatelessWidget {
  final String phoneNumber;
  final String network; // Assuming the network is T2 for the bonus claim.

  const _BonusClaimSection({required this.phoneNumber, required this.network});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final canClaim = phoneNumber.trim().isNotEmpty;

    return Container(
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
                  Icons.card_giftcard_rounded,
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
                      'First Transaction Bonus',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your free data reward is ready.',
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Text(
                  '50 MB',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: colors.primary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'FREE DATA BONUS',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: colors.onSurfaceVariant,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 46,
            child: FilledButton(
              onPressed: canClaim
                  ? () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) {
                          return _BonusClaimConfirmation(
                            phoneNumber: phoneNumber,
                            network: network,
                          );
                        },
                      );
                    }
                  : null,
              child: const Text(
                'Claim 50MB',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// bonus claim section configuration

class _BonusClaimConfirmation extends StatelessWidget {
  final String phoneNumber;
  final String network;

  const _BonusClaimConfirmation({
    required this.phoneNumber,
    required this.network,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: colors.outlineVariant,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 20),

            Icon(Icons.card_giftcard_rounded, size: 42, color: colors.primary),

            const SizedBox(height: 12),

            const Text(
              'Claim 50MB Bonus',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),

            const SizedBox(height: 6),

            Text(
              'Confirm that you want to receive your free 50MB bonus on:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
            ),

            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Text(
                    network,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: colors.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    phoneNumber,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '50MB • FREE',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: () async {
                  Navigator.pop(context);

                  final pinConfirmed = await showModalBottomSheet<bool>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const EnterPinSheet(),
                  );

                  if (pinConfirmed == true) {
                    if (!context.mounted) return;

                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TransactionSuccess(
                          title: 'Bonus Activated!',
                          message:
                              'Your free 50 MB data bonus has been activated successfully.',
                        ),
                      ),
                    );

                    if (!context.mounted) return;

                    Navigator.pop(context, true);
                  }
                },
                child: const Text(
                  'Confirm Claim',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
              ),
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              height: 44,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// success sheet

class _BonusClaimSuccess extends StatelessWidget {
  final String phoneNumber;
  final String network;

  const _BonusClaimSuccess({required this.phoneNumber, required this.network});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_rounded, color: colors.primary, size: 30),
            ),

            const SizedBox(height: 14),

            const Text(
              '50MB Bonus Claimed!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),

            const SizedBox(height: 6),

            Text(
              'Your free data bonus has been sent to:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
            ),

            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Text(
                    network,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: colors.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    phoneNumber,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '50MB • FREE',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: colors.primary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BonusPinSheet extends StatefulWidget {
  final String phoneNumber;
  final String network;

  const _BonusPinSheet({required this.phoneNumber, required this.network});

  @override
  State<_BonusPinSheet> createState() => _BonusPinSheetState();
}

class _BonusPinSheetState extends State<_BonusPinSheet> {
  String pin = '';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ============================================================
            // DRAG HANDLE
            // ============================================================
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: colors.outlineVariant,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 18),

            // ============================================================
            // LOCK ICON
            // ============================================================
            Icon(Icons.lock_rounded, size: 30, color: AppColors.primaryDark),

            const SizedBox(height: 10),

            // ============================================================
            // TITLE
            // ============================================================
            const Text(
              'Enter your PIN',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),

            const SizedBox(height: 6),

            Text(
              'Enter your 4-digit transaction PIN',
              style: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
            ),

            const SizedBox(height: 22),

            // ============================================================
            // PIN CIRCLES
            // ============================================================
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              transform: Matrix4.translationValues(
                0,
                keyboardHeight > 0 ? -8 : 0,
                0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final isFilled = index < pin.length;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    curve: Curves.easeOut,
                    margin: const EdgeInsets.symmetric(horizontal: 9),
                    width: isFilled ? 16 : 14,
                    height: isFilled ? 16 : 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isFilled ? colors.primary : Colors.transparent,
                      border: Border.all(
                        color: isFilled ? colors.primary : colors.outline,
                        width: 2,
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 22),

            // ============================================================
            // HIDDEN PIN INPUT
            // ============================================================
            SizedBox(
              height: 1,
              width: 1,
              child: TextField(
                autofocus: true,
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    pin = value;
                  });

                  if (value.length == 4) {
                    FocusScope.of(context).unfocus();
                  }
                },
              ),
            ),

            const SizedBox(height: 10),

            // ============================================================
            // CONFIRM BUTTON
            // ============================================================
            SizedBox(
              width: double.infinity,
              height: 48,
              child: FilledButton(
                onPressed: pin.length == 4 ? _verifyPin : null,
                child: const Text(
                  'Confirm',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // ============================================================
            // CANCEL
            // ============================================================
            SizedBox(
              width: double.infinity,
              height: 42,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _verifyPin() {
    // We will connect this to the same saved transaction PIN.
  }
}
