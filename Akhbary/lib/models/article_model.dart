class ArticleModel {
  static int counter = 0;
  final int id = ++counter;
  String? author; // The author of the article
  String? title; // The headline or title of the article
  String? category; // The category or the article
  String? url; // The direct URL to the article
  String? urlToImage; // The URL to a relevant image for the article
  // The date and time that the article was published, in UTC (+000)
  String? publishedAt;
  bool favorites = false;
  bool read = false;

  ArticleModel.mapArticleToModel({
    required Map<String, dynamic> article,
    String? articleCategory,
  }) {
    author = article['author'];
    title = article['title'];
    category = articleCategory;
    url = article['url'];
    urlToImage = article['urlToImage'];
    publishedAt = article['publishedAt'];
  }
}
