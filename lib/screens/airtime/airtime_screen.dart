import 'package:flutter/material.dart';

class AirtimeScreen extends StatelessWidget {
  const AirtimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buy Airtime')),
      body: const Center(child: Text('Airtime Screen')),
    );
  }
}
