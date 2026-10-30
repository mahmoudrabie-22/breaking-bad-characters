
class Quotes {
  bool? success;
 List<Data>? data;

  Quotes({this.success, this.data});

  Quotes.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    data = json["data"] == null ? null : List<Data>.from(json["data"].map((x) => Data.fromJson(x)));
  }

  static List<Quotes> fromList(List<Map<String, dynamic>> list) {
    return list.map(Quotes.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    if(data != null) {
      _data["data"] = data?.map((x) => x.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  String? quote;
  String? author;
  String? series;
  int? id;

  Data({this.quote, this.author, this.series, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    quote = json["quote"];
    author = json["author"];
    series = json["series"];
    id = json["id"];
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["quote"] = quote;
    _data["author"] = author;
    _data["series"] = series;
    _data["id"] = id;
    return _data;
  }
}