import 'package:flutter/material.dart';
import 'package:news_app/db/moor_database.dart';
import 'package:news_app/ui/components/articles_list_item.dart';
import 'package:news_app/ui/components/lottie_page.dart';
import 'package:news_app/utils/constants.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Saved Articles',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            Expanded(child: _buildTasksList(context)),
          ],
        ),
      ),
    );
  }

  StreamBuilder<List<Article>> _buildTasksList(BuildContext context) {
    final dao = Provider.of<ArticleDao>(context);
    return StreamBuilder(
      stream: dao.watchAllTasks(),
      builder: (context, snapshot) {
        final articles = snapshot.data ?? [];
        return articles.isNotEmpty
            ? ListView.builder(
                itemCount: (articles == null || articles.length == 0)
                    ? 0
                    : articles.length,
                itemBuilder: (context, index) {
                  final article = articles[index];
                  return Dismissible(
                    key: Key(article.title),
                    onDismissed: (direction) {
                      setState(() {
                        dao.deleteTask(article);
                        articles.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.white,
                          content: Text(
                            'Article Deleted',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15.0,
                            ),
                          ),
                          action: SnackBarAction(
                            label: 'Undo',
                            textColor: Colors.blue,
                            onPressed: () {
                              setState(() {
                                dao.insertArticle(article);
                              });
                            },
                          ),
                        ),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                    ),
                    child: ArticlesListItem(
                      article: articles[index],
                    ),
                  );
                },
              )
            : Center(
                child: LottiePage(
                  lottieAsset: 'assets/box-empty.json',
                  lottieText: Constants.emptyListText,
                ),
              );
      },
    );
  }
}
