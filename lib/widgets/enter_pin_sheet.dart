import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../services/pin_service.dart';

class EnterPinSheet extends StatefulWidget {
  const EnterPinSheet({super.key});

  @override
  State<EnterPinSheet> createState() => _EnterPinSheetState();
}

class _EnterPinSheetState extends State<EnterPinSheet> {
  final TextEditingController _pinController = TextEditingController();

  bool _isVerifying = false;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _verifyPin() async {
    final pin = _pinController.text;

    if (pin.length != 4 || _isVerifying) {
      return;
    }

    setState(() {
      _isVerifying = true;
    });

    final isCorrect = await PinService.verifyPin(pin);

    if (!mounted) return;

    if (isCorrect) {
      Navigator.pop(context, true);
    } else {
      _pinController.clear();

      setState(() {
        _isVerifying = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Incorrect PIN')));
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
                  obscureText: true,
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
                      onPressed: _isVerifying
                          ? null
                          : () {
                              Navigator.pop(context);
                            },
                      child: const Text('Cancel'),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: FilledButton(
                      onPressed: pin.length == 4 && !_isVerifying
                          ? _verifyPin
                          : null,
                      child: _isVerifying
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Confirm'),
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
