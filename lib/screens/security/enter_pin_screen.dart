import 'package:flutter/material.dart';

class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({super.key});

  @override
  State<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _onPinChanged(String value) {
    if (value.length == 4) {
      _verifyPin(value);
    }
  }

  void _verifyPin(String pin) {
    // Temporary PIN for testing.
    // We will replace this with secure PIN verification later.
    const savedPin = '1234';

    if (pin == savedPin) {
      Navigator.pop(context, true);
    } else {
      _pinController.clear();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Incorrect PIN')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Confirm PIN')),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 60),

              Icon(Icons.lock_rounded, size: 42, color: colors.primary),

              const SizedBox(height: 20),

              const Text(
                'Enter your PIN',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),

              const SizedBox(height: 8),

              Text(
                'Enter your 4-digit transaction PIN to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.onSurfaceVariant, fontSize: 14),
              ),

              const SizedBox(height: 40),

              // PIN dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final isFilled = index < _pinController.text.length;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isFilled
                          ? colors.primary
                          : colors.surfaceContainerHighest,
                      border: Border.all(
                        color: isFilled
                            ? colors.primary
                            : colors.outlineVariant,
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 30),

              // Invisible-looking PIN input
              SizedBox(
                width: 1,
                height: 1,
                child: TextField(
                  controller: _pinController,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {});
                    _onPinChanged(value);
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
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
