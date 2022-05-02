import 'package:dio/dio.dart';

class Request {
  static get(url, callback) async {
    Response response;
    var dio = Dio();
    response = await dio.get(url);
    callback(response.data);
  }

  static post(url, body, callback) {}
}
