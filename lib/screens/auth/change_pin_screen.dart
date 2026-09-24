import 'package:flutter/material.dart';
import 'package:hyell_wallet/core/constants/app_colors.dart';

class ChangePinScreen extends StatefulWidget {
  const ChangePinScreen({super.key});

  @override
  State<ChangePinScreen> createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {
  final TextEditingController currentPinController = TextEditingController();

  final TextEditingController newPinController = TextEditingController();

  final TextEditingController confirmPinController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void dispose() {
    currentPinController.dispose();
    newPinController.dispose();
    confirmPinController.dispose();

    super.dispose();
  }

  void _checkPins() {
    setState(() {
      _isButtonEnabled =
          currentPinController.text.length == 4 &&
          newPinController.text.length == 4 &&
          confirmPinController.text.length == 4;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _changePin() {
    const savedPin = '1234';

    if (currentPinController.text != savedPin) {
      _showMessage('Your current PIN is incorrect.');
      return;
    }

    if (newPinController.text == currentPinController.text) {
      _showMessage('Your new PIN must be different.');
      return;
    }

    if (newPinController.text != confirmPinController.text) {
      _showMessage('Your new PINs do not match.');
      return;
    }

    _showMessage('Your PIN has been changed successfully.');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,

      appBar: AppBar(
        title: Text(
          'Change PIN',
          style: TextStyle(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isDark
            ? AppColors.backgroundDark
            : AppColors.background,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change your transaction PIN',
                style: TextStyle(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Enter your current PIN and create a new 4-digit PIN.',
                style: TextStyle(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 30),

              _pinField(
                controller: currentPinController,
                label: 'Current PIN',
                isDark: isDark,
              ),

              const SizedBox(height: 20),

              _pinField(
                controller: newPinController,
                label: 'New PIN',
                isDark: isDark,
              ),

              const SizedBox(height: 20),

              _pinField(
                controller: confirmPinController,
                label: 'Confirm New PIN',
                isDark: isDark,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled
                      ? () {
                          // pin validation here

                          _changePin();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: isDark
                        ? AppColors.surfaceDark
                        : AppColors.divider,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Change PIN',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _pinField({
    required TextEditingController controller,
    required String label,
    required bool isDark,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: 4,
      obscureText: true,

      style: TextStyle(
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
      ),

      onChanged: (_) {
        _checkPins();
      },

      decoration: InputDecoration(
        labelText: label,
        counterText: '',
        filled: true,

        fillColor: isDark ? AppColors.surfaceDark : AppColors.surface,

        labelStyle: TextStyle(
          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
