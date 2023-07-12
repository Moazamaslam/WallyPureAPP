class Wallpapermodel {
  late String photographer;
  late String photographer_url;
  late int photographer_id;
  late SrcModel src;
  Wallpapermodel(
      {required this.photographer,
      required this.photographer_id,
      required this.photographer_url,
      required this.src});
  factory Wallpapermodel.fromMap(Map<String, dynamic> jsondata) {
    return Wallpapermodel(
        photographer: jsondata["photographer"],
        photographer_id: jsondata["photographer_id"],
        photographer_url: jsondata["photographer_url"],
        src: SrcModel.fromMap(jsondata["src"]));
  }
}

class SrcModel {
  late String original;
  late String small;
  late String portrait;
  SrcModel(
      {required this.original, required this.portrait, required this.small});
  factory SrcModel.fromMap(Map<String, dynamic> jsondata) {
    return SrcModel(
        original: jsondata["original"],
        portrait: jsondata["portrait"],
        small: jsondata["small"]);
  }
}
