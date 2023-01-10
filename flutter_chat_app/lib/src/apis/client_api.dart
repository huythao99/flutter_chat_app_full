import 'package:dio/dio.dart';

class ClientApi {
  static const baseURL = 'http://192.168.1.58:3000/';
  static const headers = {'content-type': 'application/json'}
  static final Dio _dio =
      Dio(BaseOptions(baseUrl: baseURL, headers: {
        ...headers
      }));

  getInstaceClientApi() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
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
    return _dio;
  }

  getApi(String path, Map<String, dynamic> params) {
    return _dio.get(path, queryParameters: params);
  }

  postApi(String path, Map<String, dynamic> body, bool isFormData) {
    if (isFormData) {
      var formData = FormData.fromMap(body);
      return _dio.post(path, data: formData, options: Options(
        headers: {
          ...headers,
          'content-type': 'multipart/form-data'
        }
      ));
    }
    return _dio.post(path, data: body);
  }
}
