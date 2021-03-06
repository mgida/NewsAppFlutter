import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:news_app/model/result.dart';

class ModelConverter implements Converter{
  @override
  Request convertRequest(Request request) {
    final req = applyHeader(
      request,
      contentTypeKey,
      jsonHeaders,
      override: false,
    );
    return encodeJson(req);
  }

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(
      Response<dynamic> response) {
    return decodeJson<BodyType, InnerType>(response);  }

  Request encodeJson(Request request) {
    var contentType = request.headers[contentTypeKey];
    if (contentType != null && contentType.contains(jsonHeaders)) {
      return request.copyWith(body: json.encode(request.body));
    }
    return request;
  }

  Response decodeJson<BodyType, InnerType>(Response response) {
    var contentType = response.headers[contentTypeKey];
    var body = response.body;
    if (contentType != null && contentType.contains(jsonHeaders)) {
      body = utf8.decode(response.bodyBytes);
    }
    try {
      var mapData = json.decode(body);
      var result = Result.fromJson(mapData);
      return response.copyWith<BodyType>(body: result as BodyType);
    } catch (e) {
      chopperLogger.warning(e);
      return response.copyWith<BodyType>(body: body);
    }
  }
}