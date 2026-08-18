import 'package:flutter/material.dart';

import 'screens/splash/splash_screen.dart';

class HyellWalletApp extends StatelessWidget {
  const HyellWalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
