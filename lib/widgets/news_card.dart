import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  NewsCard({
    super.key,
    required this.source,
    required this.description,
    required this.publishedAt,
    required this.urlToImage,
  });
  String source;
  String description;
  String publishedAt;
  String urlToImage;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final publishedAtFormatted =
        DateTime.parse(publishedAt); 

    final difference = now.difference(publishedAtFormatted);

    String formattedDifference;
    if (difference.inDays > 365) {
      final years = difference.inDays ~/ 365;
      formattedDifference = "$years year${years > 1 ? 's' : ''}";
    } else if (difference.inDays > 30) {
      final months = difference.inDays ~/ 30;
      formattedDifference = "$months month${months > 1 ? 's' : ''}";
    } else {
      final days = difference.inDays;
      formattedDifference = "$days day${days > 1 ? 's' : ''}";
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Card(
        color: Theme.of(context).copyWith().colorScheme.secondary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      source,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '$formattedDifference ago',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 10,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(10),
                child: Image.network(
                  urlToImage,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
