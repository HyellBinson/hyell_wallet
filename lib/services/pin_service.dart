import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PinService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _pinKey = 'transaction_pin';

  static Future<void> savePin(String pin) async {
    await _storage.write(key: _pinKey, value: pin);
  }

  static Future<String?> getPin() async {
    return await _storage.read(key: _pinKey);
  }

  static Future<bool> verifyPin(String pin) async {
    final savedPin = await getPin();

    if (savedPin == null) {
      return false;
    }

    return savedPin == pin;
  }

  static Future<bool> hasPin() async {
    final savedPin = await getPin();

    return savedPin != null && savedPin.isNotEmpty;
  }
}
