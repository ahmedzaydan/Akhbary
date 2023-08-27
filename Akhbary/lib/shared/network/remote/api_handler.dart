/// Dio is a popular package in Flutter for making HTTP requests to web services or APIs.
/// It provides a simple and powerful API for sending HTTP requests, handling response data, and configuring request options.
/// With Dio, you can make GET, POST, PUT, DELETE, and other types of requests, set request headers, handle timeouts and errors, and stream response data.
/// Some of the key features of Dio include:
///   1. Support for interceptors to modify request and response data
///   2. Support for multiple request and response data formats, such as JSON, FormData, and XML
///   3. Support for authentication and authorization
///   4. Support for cancellation and timeouts
///   5. Integration with Flutter's WidgetsBindingObserver for handling network activity indicator.

import 'package:dio/dio.dart';

class APIHandler {
  // dio is static to let static functions be able to use it
  static late Dio dio;

  // init is static to be able to access it from class name directly
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/', // server address
        receiveDataWhenStatusError: true, // receive date in all conditions
      ),
    );
  }

  // get data from API
  // getData is static to be able to access it from class name directly
  static Future<Response> getData({
    required String method,
    Map<String, dynamic>? queries,
  }) async {
    return await dio.get(
      method, // address inside the server
      queryParameters: queries, // queries I will do there
    );
  }
}
