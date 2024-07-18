import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:news_app/models/article.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/utils/theme.dart';
import 'package:news_app/widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String countryCode = 'IN';

  @override
  void initState() {
    super.initState();
    _fetchCountryCode();
  }

  Future<void> _fetchCountryCode() async {
    final fetchedCountryCode =
        await context.read<NewsService>().fetchCountryCode();
    setState(() {
      countryCode = fetchedCountryCode.toUpperCase();
    });
  }

  // void _updateCountryCode(String newCode) {
  //   setState(() {
  //     countryCode = newCode;
  //   });
  //   context.read<NewsService>().fetchTopHeadlines();
  // }

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context).copyWith();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: Text(
          'MyNews',
          style: localTheme.textTheme.titleLarge?.copyWith(
            fontSize: 14,
            color: localTheme.colorScheme.surface,
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.public_sharp,
                    color: localTheme.colorScheme.surface),
                onPressed: () {},
              ),
              Text(
                countryCode,
                style: localTheme.textTheme.titleLarge?.copyWith(
                  fontSize: 14,
                  color: colorScheme.surface,
                ),
              ),
              // IconButton(
              //   icon: Icon(Icons.refresh, color: colorScheme.surface),
              //   onPressed: () async {
              //     await context
              //         .read<NewsService>()
              //         .fetchAndActivateRemoteConfig();
              //     _fetchCountryCode();
              //   },
              // ),
              // DropdownButton<String>(
              //   value: countryCode,
              //   dropdownColor: colorScheme.primary,
              //   underline: const SizedBox(),
              //   icon: Icon(Icons.arrow_drop_down, color: colorScheme.surface),
              //   items: countries.map<DropdownMenuItem<String>>((country) {
              //     return DropdownMenuItem<String>(
              //       value: country['code'],
              //       child: Text(
              //         country['name']!,
              //         style: localTheme.textTheme.titleLarge?.copyWith(
              //           fontSize: 14,
              //           color: colorScheme.surface,
              //         ),
              //       ),
              //     );
              //   }).toList(),
              //   onChanged: (newCode) {
              //     if (newCode != null) {
              //       _updateCountryCode(newCode);
              //     }
              //   },
              // ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0).copyWith(left: 16),
            child: Text(
              'Top Headlines',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.tertiary, fontSize: 16),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Article>>(
                future: context.read<NewsService>().fetchTopHeadlines(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No news found'));
                  } else {
                    final List<Article> articles = snapshot.data!;
                    return ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final Article article = articles[index];
                        return NewsCard(
                          source: article.source,
                          description: article.title,
                          urlToImage: article.urlToImage,
                          publishedAt: article.publishedAt,
                        );
                      },
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
