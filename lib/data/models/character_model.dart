class Data {
  bool? success;
  List<Character>? data;

  Data({this.success, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Character.fromJson(e)).toList();
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Character {
  String? name;
  String? portrayed;
  String? imageUrl;
  String? fullName;
  String? birthDate;
  List<String>? occupation;
  String? episodesCount;
  String? series;
  List<String>? appearances;
  int? id;

  Character({
    this.name,
    this.portrayed,
    this.imageUrl,
    this.fullName,
    this.birthDate,
    this.occupation,
    this.episodesCount,
    this.series,
    this.appearances,
    this.id,
  });

  Character.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    portrayed = json["portrayed"];
    imageUrl = json["image_url"];
    fullName = json["full_name"];
    birthDate = json["birth_date"];
    occupation = json["occupation"] == null
        ? null
        : List<String>.from(json["occupation"]);
    episodesCount = json["episodes_count"];
    series = json["series"];
    appearances = json["appearances"] == null
        ? null
        : List<String>.from(json["appearances"]);
    id = json["id"];
  }

  static List<Character> fromList(List<Map<String, dynamic>> list) {
    return list.map(Character.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    _data["portrayed"] = portrayed;
    _data["image_url"] = imageUrl;
    _data["full_name"] = fullName;
    _data["birth_date"] = birthDate;
    if (occupation != null) {
      _data["occupation"] = occupation;
    }
    _data["episodes_count"] = episodesCount;
    _data["series"] = series;
    if (appearances != null) {
      _data["appearances"] = appearances;
    }
    _data["id"] = id;
    return _data;
  }
}
