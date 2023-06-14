// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SingleQoute {
  String text;
  String author;

  SingleQoute(this.text, this.author);

  factory SingleQoute.fromMap(Map<String, dynamic> map) {
    return SingleQoute(
      map['text'] as String,
      map['author'] as String,
    );
  }

  factory SingleQoute.fromJson(String source) =>
      SingleQoute.fromMap(json.decode(source) as Map<String, dynamic>);
}
