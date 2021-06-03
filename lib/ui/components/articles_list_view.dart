import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/article.dart';
import 'package:news_app/ui/screens/detail_page.dart';
import 'package:news_app/ui/components/articles_list_item.dart';

class ArticlesListView extends StatelessWidget {
  const ArticlesListView({
    Key key,
    @required this.context,
    this.articles,
  }) : super(key: key);

  final BuildContext context;
  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return GridView.builder(
      itemCount:
          (articles == null || articles.length == 0 ) ? 0 : articles.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            navigateToDetailPage(context, index);
          },
          child: ArticlesListItem(article: articles[index]),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: orientation == Orientation.landscape ? 2 : 1,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 2 / 1,
      ),
      shrinkWrap: true,
    );
  }

  void navigateToDetailPage(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(articles[index]),
      ),
    );
  }
}
