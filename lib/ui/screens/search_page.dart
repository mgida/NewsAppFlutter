import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/result.dart';
import 'package:news_app/rest_api/news_service.dart';
import 'package:news_app/ui/components/articles_list_view.dart';
import 'package:news_app/utils/constants.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String enteredText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your search here',
                  border: UnderlineInputBorder(),
                ),
                onChanged: (newValue) {
                  setState(() {
                    enteredText = newValue;
                  });
                },
              ),
              SizedBox(
                height: 6.0,
              ),
              Expanded(
                child: SizedBox(
                  height: 200.0,
                  child: _buildBody(context, enteredText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<Response<Result>> _buildBody(
      BuildContext context, String enteredText) {
    return FutureBuilder(
        future: Provider.of<NewsService>(context)
            .searchForNews(enteredText, Constants.apiKey),
        builder: (context, snapshot) {
          if (enteredText == null || enteredText.isEmpty) {
            return Text('');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.3,
                ),
              );
            }
            final newsResult = snapshot.data.body;
            final articles = newsResult.articles;
            return ArticlesListView(context: context, articles: articles);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
