import 'package:flutter/material.dart';
import 'package:hyell_wallet/core/constants/app_colors.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'airtime_history_screen.dart';
import '../../widgets/enter_pin_sheet.dart';

class AirtimeScreen extends StatefulWidget {
  const AirtimeScreen({super.key});

  @override
  State<AirtimeScreen> createState() => _AirtimeScreenState();
}

class _AirtimeScreenState extends State<AirtimeScreen> {
  String? selectedNetwork;
  String phoneNumber = '';
  int? selectedAmount;
  String? amountError;
  final TextEditingController _amountController = TextEditingController();
  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _showAirtimePurchaseSheet(BuildContext context, int amount) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _AirtimePurchaseSheet(
          network: selectedNetwork!,
          phoneNumber: phoneNumber,
          amount: amount,
        );
      },
    );
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AirtimeHistoryScreen(),
                        ),
                      );
                    },
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
                _PhoneNumberField(
                  network: selectedNetwork!,
                  onChanged: (value) {
                    setState(() {
                      phoneNumber = value;
                    });
                  },
                ),
              ],

              // =================================================
              // Airtime plans
              // =================================================

              // =================================================
              // Airtime amount
              // =================================================
              if (selectedNetwork != null) ...[
                const SizedBox(height: 22),

                _AirtimeAmountSection(
                  selectedAmount: selectedAmount,
                  amountController: _amountController,

                  onAmountSelected: (amount) {
                    setState(() {
                      selectedAmount = amount;
                    });
                  },

                  onAmountError: (error) {
                    setState(() {
                      amountError = error;
                    });
                  },
                ),
              ],

              if (selectedNetwork != null && phoneNumber.trim().isNotEmpty) ...[
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed:
                        selectedAmount != null &&
                            selectedAmount! >= 50 &&
                            selectedAmount! <= 50000
                        ? () {
                            _showAirtimePurchaseSheet(context, selectedAmount!);
                          }
                        : null,
                    child: const Text(
                      'Buy Airtime',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _AirtimeAmountSection extends StatelessWidget {
  final int? selectedAmount;
  final ValueChanged<int> onAmountSelected;
  final TextEditingController amountController;
  final ValueChanged<String?> onAmountError;

  const _AirtimeAmountSection({
    required this.selectedAmount,
    required this.onAmountSelected,
    required this.amountController,
    required this.onAmountError,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final amounts = [100, 200, 500, 1000, 2000, 5000];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.outlineVariant),
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
                  'Airtime Amount',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),

              Icon(Icons.phone_in_talk_rounded, color: colors.primary),
            ],
          ),

          const SizedBox(height: 16),

          // ============================================================
          // QUICK AMOUNTS
          // ============================================================
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final columns = width < 320 ? 2 : 3;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: amounts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.45,
                ),
                itemBuilder: (context, index) {
                  final amount = amounts[index];

                  return _AirtimeAmountCard(
                    amount: amount,
                    isSelected: selectedAmount == amount,
                    onTap: () {
                      amountController.text = amount.toString();

                      onAmountSelected(amount);
                    },
                  );
                },
              );
            },
          ),

          const SizedBox(height: 18),

          // ============================================================
          // CUSTOM AMOUNT
          // ============================================================
          Text(
            'Enter amount',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: colors.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              final amount = int.tryParse(value);

              if (amount == null || amount == 0) {
                onAmountSelected(0);
                onAmountError(null);
                return;
              }

              if (amount < 50) {
                onAmountSelected(0);
                onAmountError('Minimum airtime amount is ₦50');
                return;
              }

              if (amount > 50000) {
                onAmountSelected(0);
                onAmountError('Maximum airtime amount is ₦50,000');
                return;
              }

              onAmountSelected(amount);
              onAmountError(null);
            },
            decoration: InputDecoration(
              hintText: 'Enter amount',
              prefixText: '₦ ',
              prefixStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: colors.onSurface,
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
          ),

          const SizedBox(height: 7),

          Text(
            'Minimum ₦50 • Maximum ₦50,000',
            style: TextStyle(
              fontSize: 11,
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _AirtimeAmountCard extends StatelessWidget {
  final int amount;
  final bool isSelected;
  final VoidCallback onTap;

  const _AirtimeAmountCard({
    required this.amount,
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
            color: isSelected ? colors.primary : colors.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '₦${amount.toString()}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Airtime',
                style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
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

class _PhoneNumberField extends StatefulWidget {
  final String network;
  final ValueChanged<String> onChanged;

  const _PhoneNumberField({required this.network, required this.onChanged});

  @override
  State<_PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<_PhoneNumberField> {
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _pickContact() async {
    final permission = await FlutterContacts.permissions.request(
      PermissionType.read,
    );

    if (permission != PermissionStatus.granted) {
      return;
    }

    final contact = await FlutterContacts.native.showPicker(
      properties: {ContactProperty.phone},
    );

    if (!mounted || contact == null) {
      return;
    }

    if (contact.phones.isEmpty) {
      return;
    }

    final number = contact.phones.first.number;

    _phoneController.text = number;

    widget.onChanged(number);
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
      onChanged: widget.onChanged,

      decoration: InputDecoration(
        hintText: 'Enter phone number',

        prefixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: _NetworkLogo(network: widget.network),
        ),

        suffixIcon: IconButton(
          onPressed: _pickContact,
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

class _AmountChip extends StatelessWidget {
  final int amount;
  final VoidCallback onTap;

  const _AmountChip({required this.amount, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.outlineVariant),
        ),
        child: Text(
          '₦${amount.toString()}',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: colors.onSurface,
          ),
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

      case 'T2mobile':
        return 'assets/images/networks/T2mobile.png';

      default:
        return 'assets/images/networks/T2mobile.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(assetPath, width: 28, height: 28, fit: BoxFit.contain);
  }
}

class _AirtimePurchaseSheet extends StatelessWidget {
  final String network;
  final String phoneNumber;
  final int amount;

  const _AirtimePurchaseSheet({
    required this.network,
    required this.phoneNumber,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colors.outlineVariant,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Confirm Purchase',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),

            const SizedBox(height: 20),

            // Network
            Row(
              children: [
                _NetworkLogo(network: network),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    network,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Phone number
            Row(
              children: [
                Icon(Icons.phone_outlined, color: colors.onSurfaceVariant),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    phoneNumber,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Amount
            Row(
              children: [
                Icon(Icons.payments_outlined, color: colors.onSurfaceVariant),

                const SizedBox(width: 12),

                const Expanded(
                  child: Text(
                    'Airtime',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),

                Text(
                  '₦$amount',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: colors.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: () async {
                  Navigator.pop(context);

                  final pinConfirmed = await showModalBottomSheet<bool>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return const EnterPinSheet();
                    },
                  );

                  if (pinConfirmed == true) {
                    // Actual airtime purchase logic will come here later.
                  }
                },
                child: const Text(
                  'Confirm Purchase',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AirtimePinSheet extends StatefulWidget {
  const _AirtimePinSheet();

  @override
  State<_AirtimePinSheet> createState() => _AirtimePinSheetState();
}

class _AirtimePinSheetState extends State<_AirtimePinSheet> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _verifyPin() {
    final pin = _pinController.text;

    if (pin.length != 4) {
      return;
    }

    // Temporary PIN for testing.
    const savedPin = '1234';

    if (pin == savedPin) {
      Navigator.pop(context, true);
    } else {
      _pinController.clear();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Incorrect PIN')));

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final pin = _pinController.text;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ============================================================
              // HANDLE
              // ============================================================
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.outlineVariant,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              const SizedBox(height: 22),

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

              const SizedBox(height: 18),

              // ============================================================
              // HIDDEN PIN INPUT
              // ============================================================
              SizedBox(
                height: 1,
                width: 1,
                child: TextField(
                  controller: _pinController,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  showCursor: false,
                  style: const TextStyle(
                    color: Colors.transparent,
                    fontSize: 1,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  onChanged: (value) {
                    setState(() {});

                    if (value.length == 4) {
                      _verifyPin();
                    }
                  },
                ),
              ),

              const SizedBox(height: 10),

              // ============================================================
              // BUTTONS
              // ============================================================
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: FilledButton(
                      onPressed: pin.length == 4 ? _verifyPin : null,
                      child: const Text('Confirm'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
