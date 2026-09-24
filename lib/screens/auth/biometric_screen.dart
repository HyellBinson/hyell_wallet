import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:hyell_wallet/core/constants/app_colors.dart';

class BiometricScreen extends StatefulWidget {
  const BiometricScreen({super.key});

  @override
  State<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  final LocalAuthentication _auth = LocalAuthentication();

  bool _biometricEnabled = false;
  bool _isChecking = false;

  Future<void> _toggleBiometric(bool value) async {
    if (!value) {
      setState(() {
        _biometricEnabled = false;
      });

      return;
    }

    setState(() {
      _isChecking = true;
    });

    try {
      final bool canAuthenticate = await _auth.isDeviceSupported();

      if (!canAuthenticate) {
        _showMessage(
          'Biometric authentication is not available on this device.',
        );
        return;
      }

      final bool authenticated = await _auth.authenticate(
        localizedReason: 'Authenticate to enable biometric security for HYELL',
        biometricOnly: true,
      );

      if (authenticated) {
        setState(() {
          _biometricEnabled = true;
        });

        _showMessage('Biometric authentication enabled.');
      }
    } catch (e) {
      _showMessage('Biometric authentication could not be completed.');
    } finally {
      setState(() {
        _isChecking = false;
      });
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,

      appBar: AppBar(
        title: Text(
          'Biometric Authentication',
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
            children: [
              const SizedBox(height: 20),

              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.primary.withOpacity(0.15)
                      : AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.fingerprint,
                  color: AppColors.primary,
                  size: 48,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Biometric Security',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Use your fingerprint or supported biometric '
                'authentication to help protect your HYELL account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 32),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Use biometrics',
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            'Require biometric authentication '
                            'for supported HYELL actions.',
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 12),

                    Switch(
                      value: _biometricEnabled,
                      onChanged: _isChecking ? null : _toggleBiometric,
                      activeThumbColor: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
