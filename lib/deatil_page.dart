import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app_with_d5/surah_model.dart';
import 'ayah_model.dart';
import 'package:flutter/services.dart';

class DetailPage extends StatefulWidget {
  final SurahModel surah;

  const DetailPage({
    super.key,
    required this.surah,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text(
          "Detail Page (${widget.surah.transliteration})",
          style: GoogleFonts.poppins(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
