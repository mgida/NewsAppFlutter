import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticlesListItem extends StatelessWidget {
  const ArticlesListItem({
    Key key,
    @required this.article,
  }) : super(key: key);

  final article;

  String get _formattedReleaseDate {
    var formatAll =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(article.publishedAt);
    var formattedDate = DateFormat.yMMMd().format(formatAll);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: 150,
                height: 150,
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  child: CachedNetworkImage(
                    imageUrl: article.urlToImage ??
                        "https://www.generationsforpeace.org/wp-content/uploads/2018/07/empty.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Container(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Opacity(
                        opacity: 0.7,
                        child: Text(
                          article.title ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      article.description ?? '',
                      style: textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Opacity(
                                opacity: 0.7,
                                child: Text(
                                  '$_formattedReleaseDate' ?? '',
                                  style: textTheme.bodyText2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
