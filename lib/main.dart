import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:quran_app_with_d5/home_page.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => QuranAppWithD5(),
    ),
  );
}

class QuranAppWithD5 extends StatelessWidget {
  const QuranAppWithD5({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
