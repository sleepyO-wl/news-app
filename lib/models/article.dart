class Article {
  final String title;
  final String description;
  final String author;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final String source;

  Article({
    required this.title,
    required this.description,
    required this.author,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    required this.source,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      author: json['author'] ?? 'No Author',
      url: json['url'] ?? 'url missing',
      urlToImage: json['urlToImage'] ??
          'https://media.istockphoto.com/id/1313303632/video/breaking-news-template-intro-for-tv-broadcast-news-show-program-with-3d-breaking-news-text.jpg?s=640x640&k=20&c=S0dTZp37XKVcCAnoguMnRatvv4Nkp2cjmA5aYOOrJs8=',
      publishedAt: json['publishedAt'] ?? 'No Date',
      content: json['content'] ?? 'Content is missing',
      source: json['source']['name'] ?? 'Source is missing',
    );
  }
}
