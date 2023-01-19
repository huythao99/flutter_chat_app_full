import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class ClientApi {
  // static const baseURL = 'http://192.168.1.58:3000/';
  // static const baseURL = 'http://10.0.11.47:3000/';
  static const baseURL = 'http://192.168.0.101:3000/';
  static var headers = {'content-type': 'application/json'};
  static Dio? _dio;

  static initClientApi() {
    _dio ??= Dio(BaseOptions(baseUrl: baseURL, headers: {...headers}))
      ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        return handler.next(options); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: `handler.resolve(response)`.
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: `handler.reject(dioError)`
      }, onResponse: (response, handler) {
        // Do something with response data

        return handler.next(response); // continue
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: `handler.reject(dioError)`
      }, onError: (DioError e, handler) {
        // Do something with response error
        return handler.next(e); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: `handler.resolve(response)`.
      }));
  }

  static getApi(String path, Map<String, dynamic> params) {
    return _dio?.get(path, queryParameters: params);
  }

  static postApi(String path, Map<String, dynamic> body, bool isFormData) async {
    if (isFormData) {
      var formData = FormData.fromMap({
        ...body,
        'avatar': await MultipartFile.fromFile(body['avatar']['path'],
            filename: body['avatar']['path'], contentType: MediaType('image', 'png'))
      });
      return _dio?.post(path, data: formData, options: Options(headers: {...headers}));
    }
    return _dio?.post(
      path,
      data: body,
    );
  }

  static patchApi(String path, Map<String, dynamic> body) {
    return _dio?.patch(path, data: body);
  }

  static deleteApi(String path, Map<String, dynamic> params) {
    return _dio?.delete(path, queryParameters: params);
  }

  static setToken(String? token) {
    if (token != null) {
      if (headers.containsKey('authorization')) {
        headers.update('authorization', (value) => token);
      } else {
        headers['authorization'] = token;
      }
    }
  }

  static removeToken() {
    headers.remove('authorization');
  }
}
