import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app_with_d5/ayah_model.dart';
import 'package:quran_app_with_d5/surah_model.dart';

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
  List<AyahModel> ayahs = [];

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    String data = await rootBundle.loadString("assets/saheeh.json");
    List jsonList = List.from(jsonDecode(data))[widget.surah.id - 1]["verses"];
    ayahs = jsonList.map((json) => AyahModel.fromJson(json)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.surah.transliteration),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.all(15),
          itemCount: ayahs.length,
          itemBuilder: (context, index) {
            AyahModel verse = ayahs[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    verse.text,
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.amiri(
                      fontSize: 22,
                      height: 2.5,
                    ),
                  ),
                ),
                Text(verse.translation),
              ],
            );
          },
        ),
      ),
    );
  }
}
