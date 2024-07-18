import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:http/http.dart' as http;

import 'package:news_app/models/article.dart';
import 'package:news_app/utils/api.dart';

class NewsService {
  final String apiKey = newsApiKey;
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  NewsService() {
    _initializeRemoteConfig();
  }

  Future<void> _initializeRemoteConfig() async {
    await remoteConfig.setDefaults({
      'country_code': 'in',
    });
    await remoteConfig.fetchAndActivate();
  }

  Future<void> fetchAndActivateRemoteConfig() async {
    await remoteConfig.fetchAndActivate();
  }

  Future<List<Article>> fetchTopHeadlines() async {
    final countryCode = await fetchCountryCode();
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=$countryCode&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['articles'];
      return data.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news ${response.statusCode}');
    }
  }

  Future<String> fetchCountryCode() async {
    return remoteConfig.getString('country_code');
  }
}
