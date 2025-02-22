class SurahModel {
  late int id;
  late String name;
  late String transliteration;
  late String translation;
  late String type;
  late String totalVerses;

  SurahModel({
    required this.id,
    required this.name,
    required this.transliteration,
    required this.translation,
    required this.type,
    required this.totalVerses,
  });

  SurahModel.fromJson(Map json) {
    id = json["id"];
    name = json["name"];
    transliteration = json["transliteration"];
    translation = json["translation"];
    type = json["type"];
    totalVerses = json["total_verses"];
  }

  Map toJson() {
    return {
      "id": id,
      "name": name,
      "transliteration": transliteration,
      "translation": translation,
      "type": type,
      "total_verses": totalVerses,
    };
  }
}
