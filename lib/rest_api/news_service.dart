import 'package:chopper/chopper.dart';
import 'package:news_app/model/result.dart';
import 'package:news_app/utils/model_converter.dart';

part 'news_service.chopper.dart';

@ChopperApi()
abstract class NewsService extends ChopperService {
  @Get(path: 'top-headlines')
  Future<Response<Result>> getTopHeadlinesNews(
      @Query('country') String country, @Query('apiKey') String apiKey);

  @Get(path: 'everything')
  Future<Response<Result>> searchForNews(
      @Query('q') String text, @Query('apiKey') String apiKey);

  static NewsService create() {
    final client = ChopperClient(
      baseUrl: 'https://newsapi.org/v2/',
      services: [
        _$NewsService(),
      ],
      interceptors: [
        HttpLoggingInterceptor(),
      ],
      converter: ModelConverter(),
      errorConverter: JsonConverter(),
    );
    return _$NewsService(client);
  }
}
