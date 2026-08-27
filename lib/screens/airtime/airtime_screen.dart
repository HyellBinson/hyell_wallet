import 'package:flutter/material.dart';
import 'package:hyell_wallet/core/constants/app_colors.dart';

class AirtimeScreen extends StatefulWidget {
  const AirtimeScreen({super.key});

  @override
  State<AirtimeScreen> createState() => _AirtimeScreenState();
}

class _AirtimeScreenState extends State<AirtimeScreen> {
  String? selectedNetwork;
  String? selectedPlan;

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
              // Header
              // ========================================================
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
                      'Airtime',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'History',
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // ======================================================
              // banner
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
                    'Airtime',
                    style: TextStyle(
                      color: colors.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),
              // =========================================================
              // SelectNetwork
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
                      onTap: (() {
                        setState(() {
                          selectedNetwork = 'Glo';
                        });
                      }),
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

              // ===================================================
              // Expanded
              // ===================================================
              if (selectedNetwork != null) ...[
                const SizedBox(height: 18),
                Text(
                  'Phone number',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                _PhoneNumberField(network: selectedNetwork!),
              ],

              // =================================================
              // Airtime plans
              // =================================================
            ],
          ),
        ),
      ),
    );
  }
}

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
            color: isSelected ? AppColors.success : colors.outlineVariant,
            width: isSelected ? 1.5 : 1,
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

class _PhoneNumberField extends StatelessWidget {
  final String network;

  const _PhoneNumberField({required this.network});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return TextField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Enter phone number',

        prefixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.primaryDark.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              network == 'T2' ? 'T2' : network[0],
              style: TextStyle(
                color: colors.primary,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),

        suffixIcon: IconButton(
          onPressed: () {
            // Contact picker will be added here.
          },
          icon: Icon(Icons.contacts_outlined, color: colors.primary),
        ),

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
