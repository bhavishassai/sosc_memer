import 'package:sosc_memer/models/meme.dart';

class MemeResponse {
  MemeResponse({
    required this.count,
    required this.memes,
  });
  late final int count;
  late final List<Meme> memes;

  MemeResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    memes = List.from(json['memes']).map((e) => Meme.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['count'] = count;
    _data['memes'] = memes.map((e) => e.toJson()).toList();
    return _data;
  }
}
