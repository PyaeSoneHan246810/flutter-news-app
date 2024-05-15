// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'source.dart';

class Article {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'source': source.toMap(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      source: Source.fromMap(map['source'] as Map<String, dynamic>),
      author: (map['author'] ?? "") as String,
      title: (map['title'] ?? "") as String,
      description: (map['description'] ?? "") as String,
      url: (map['url'] ?? "") as String,
      urlToImage: (map['urlToImage'] ?? "") as String,
      publishedAt: (map['publishedAt'] ?? "") as String,
      content: (map['content'] ?? "") as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source) as Map<String, dynamic>);
}
