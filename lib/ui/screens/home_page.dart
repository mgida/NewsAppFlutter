import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/result.dart';
import 'package:news_app/rest_api/news_service.dart';
import 'package:news_app/ui/components/articles_list_view.dart';
import 'package:news_app/ui/components/lottie_page.dart';
import 'package:news_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  @override
  void initState() {
    Timer timer = Timer(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('News'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: _buildBody(context),
      ),
    );
  }

  FutureBuilder<Response<Result>> _buildBody(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<NewsService>(context)
            .getTopHeadlinesNews(Constants.country, Constants.apiKey),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              isLoading = false;
              return Center(
                child: LottiePage(
                  lottieAsset: 'assets/no-internet-connection.json',
                  lottieText: Constants.noConnectionText,
                ),
              );
            }
            final newsResult = snapshot.data.body;
            final articles = newsResult.articles;
            return isLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[400],
                    highlightColor: Colors.grey[50],
                    direction: ShimmerDirection.ttb,
                    child:
                        ArticlesListView(context: context, articles: articles),
                  )
                : ArticlesListView(context: context, articles: articles);
          } else {
            return Text('');
          }
        });
  }
}
