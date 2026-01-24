class AnimeModel {
  List<AnimeDataModel>? animeList;

  AnimeModel({this.animeList});

  AnimeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      animeList = <AnimeDataModel>[];
      json['data'].forEach((v) {
        animeList!.add(AnimeDataModel.fromJson(v));
      });
    }
  }
}

class AnimeDataModel {
  int? malId;
  String? title;

  AnimeDataModel({
    this.malId,
    this.title,
  });

  AnimeDataModel.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mal_id'] = malId;
    data['title'] = title;
    return data;
  }

  fromJson(Map<String, dynamic> json) => AnimeDataModel.fromJson(json);
}
