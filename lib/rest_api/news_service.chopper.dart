// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$NewsService extends NewsService {
  _$NewsService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NewsService;

  @override
  Future<Response<Result>> getTopHeadlinesNews(String country, String apiKey) {
    final $url = 'top-headlines';
    final $params = <String, dynamic>{'country': country, 'apiKey': apiKey};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<Result, Result>($request);
  }

  @override
  Future<Response<Result>> searchForNews(String text, String apiKey) {
    final $url = 'everything';
    final $params = <String, dynamic>{'q': text, 'apiKey': apiKey};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<Result, Result>($request);
  }
}
