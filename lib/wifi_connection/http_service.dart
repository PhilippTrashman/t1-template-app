import 'package:dio/dio.dart';

class HttpService {
  final Dio _dio = Dio();
  String espUrl = 'http://192.168.4.1/';

  Future<Response> get(String url) async {
    return await _dio.get(espUrl + url);
  }

  Future<Response> post(String url) async {
    try {
      return await _dio.post(espUrl + url);
    } catch (e) {
      print(e);
      return Response(requestOptions: RequestOptions(path: 'error'));
    }
  }

  Future<Response> handleHelloRequest() async {
    return await post('hello');
  }
}
