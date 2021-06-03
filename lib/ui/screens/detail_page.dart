import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:news_app/db/moor_database.dart' as saved;
import 'package:news_app/model/article.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPage extends StatefulWidget {
  DetailPage(this._article);

  final Article _article;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveArticle(context);
          displaySnackBar();
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.favorite_border,
          color: Colors.red,
          size: 35,
        ),
        elevation: 8.0,
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget._article.url,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ],
      ),
    );
  }

  displaySnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        backgroundColor: Colors.blueAccent,
        content: Text(
          'Saved successfully',
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
      ),
    );
  }

  void saveArticle(BuildContext context) {
    final dao = Provider.of<saved.ArticleDao>(context, listen: false);
    final article = saved.ArticlesCompanion(
      title: Value(widget._article.title),
      description: Value(widget._article.description),
      publishedAt: Value(widget._article.publishedAt),
      urlToImage: Value(widget._article.urlToImage),
    );
    dao.insertArticle(article);
  }
}
