import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
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
  AudioPlayer player = AudioPlayer();
  bool isLoading = false;
  int? currentPlaying;

  @override
  void initState() {
    load();
    player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        if (currentPlaying != null &&
            currentPlaying! < widget.surah.totalVerses) {
          currentPlaying = currentPlaying!;
          playAudio(ayahs[currentPlaying!]);
        } else {
          currentPlaying = null;
        }
        setState(() {});
      }
    });
    super.initState();
  }

  void playAudio(AyahModel ayah) async {
    if (currentPlaying == null || currentPlaying != ayah.id) {
      isLoading = true;
      currentPlaying = ayah.id;
      setState(() {});
      String surah = widget.surah.id.toString().padLeft(3, "0");
      String verse = ayah.id.toString().padLeft(3, "0");
      await player.setUrl(
          "https://everyayah.com/data/Alafasy_128kbps/$surah$verse.mp3");
      isLoading = false;
      setState(() {});
      player.play();
    } else {
      if (player.playing) {
        player.pause();
      } else {
        player.play();
      }
    }
    currentPlaying = ayah.id;
    setState(() {});
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
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
      backgroundColor: Color(0xff040C23),
      appBar: AppBar(
        backgroundColor: Color(0xff040C23),
        centerTitle: false,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            CupertinoIcons.chevron_back,
            color: Colors.white,
            size: 35,
          ),
        ),
        title: Text(
          widget.surah.transliteration,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
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
                SizedBox(height: 30),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xff121931),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Color(0xffA44AFF),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${verse.id}",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: isLoading && currentPlaying == verse.id
                            ? Center(
                                child: CircularProgressIndicator(
                                strokeWidth: 3,
                              ))
                            : CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  playAudio(verse);
                                },
                                child: Icon(
                                  player.playing && currentPlaying == verse.id
                                      ? CupertinoIcons.pause_fill
                                      : CupertinoIcons.play_arrow_solid,
                                  color: Color(0xffA44AFF),
                                  size: 27,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 400),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: currentPlaying == verse.id
                          ? Color(0xff121931)
                          : null,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      verse.text,
                      textDirection: TextDirection.rtl,
                      style: GoogleFonts.amiri(
                        fontSize: 22,
                        height: 2.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Text(
                  verse.translation,
                  style: GoogleFonts.poppins(
                    color: Color(0xffA19CC5),
                    fontSize: 15,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
