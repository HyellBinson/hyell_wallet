import 'package:flutter/material.dart';
import 'package:hyell_wallet/core/constants/app_colors.dart';

class ChangeLoginPinScreen extends StatefulWidget {
  const ChangeLoginPinScreen({super.key});

  @override
  State<ChangeLoginPinScreen> createState() => _ChangeLoginPinScreenState();
}

class _ChangeLoginPinScreenState extends State<ChangeLoginPinScreen> {
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
          currentPinController.text.length == 6 &&
          newPinController.text.length == 6 &&
          confirmPinController.text.length == 6;
    });
  }

  void _changeLoginPin() {
    const savedLoginPin = '123456';

    if (currentPinController.text != savedLoginPin) {
      _showMessage('Your current login PIN is incorrect.');
      return;
    }

    if (newPinController.text == currentPinController.text) {
      _showMessage('Your new login PIN must be different.');
      return;
    }

    if (newPinController.text != confirmPinController.text) {
      _showMessage('Your new login PINs do not match.');
      return;
    }

    _showMessage('Your login PIN has been changed successfully.');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Change Login PIN',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Change your login PIN',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Enter your current 6-digit login PIN and create a new one.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),

              const SizedBox(height: 30),

              _pinField(
                controller: currentPinController,
                label: 'Current Login PIN',
              ),

              const SizedBox(height: 20),

              _pinField(controller: newPinController, label: 'New Login PIN'),

              const SizedBox(height: 20),

              _pinField(
                controller: confirmPinController,
                label: 'Confirm New Login PIN',
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled ? _changeLoginPin : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.divider,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Change Login PIN',
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
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: 6,
      obscureText: true,
      onChanged: (_) {
        _checkPins();
      },
      decoration: InputDecoration(
        labelText: label,
        counterText: '',
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
