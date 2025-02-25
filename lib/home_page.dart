import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app_with_d5/deatil_page.dart';
import 'package:quran_app_with_d5/surah_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<SurahModel> chapters = [];

  void load() async {
    String data = await rootBundle.loadString("assets/surah.json");
    List jsonList = List.from(jsonDecode(data));
    chapters = jsonList.map((json) => SurahModel.fromJson(json)).toList();
    setState(() {});
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff040C23),
      body: SafeArea(
        child: ListView.builder(
          itemCount: chapters.length,
          itemBuilder: (context, index) {
            SurahModel surah = chapters[index];
            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(surah: surah),
                  ),
                );
              },
              child: ListTile(
                leading: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/square.png",
                      height: 50,
                      width: 50,
                    ),
                    Text(
                      "${surah.id}",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      surah.transliteration,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "${surah.type.toUpperCase()} • ${surah.totalVerses} VERSES",
                      style: GoogleFonts.poppins(
                        color: Color(0xffA19CC5),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                trailing: Text(
                  surah.name,
                  style: GoogleFonts.amiri(
                    fontSize: 22,
                    color: Color(0xffA44AFF),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
