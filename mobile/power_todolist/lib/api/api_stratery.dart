import 'package:dio/dio.dart';

class ApiStrategy {
  static ApiStrategy _instance;

  static ApiStrategy getInstance() {
    if (_instance == null) {
      _instance = ApiStrategy._internal();
    }
    return _instance;
  }

  Dio _client;
  static final String baseUrl = "http://111.230.251.115/oldchen/";
  static const int connectTimeOut = 10 * 1000;
  static const int receiveTimeOut = 15 * 1000;
  static const String GET = "get";
  static const String POST = "post";

  ApiStrategy._internal() {
    if (_client == null) {
      BaseOptions options = new BaseOptions();
      options.connectTimeout = connectTimeOut;
      options.receiveTimeout = receiveTimeOut;
      options.baseUrl = baseUrl;
      _client = new Dio(options);
      _client.interceptors.add(LogInterceptor(
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
      ));
    }
  }

  Dio get client => _client;

  static String getBaseUrl() {
    return baseUrl;
  }

  void get(
    String url,
    Function callBack, {
    Map<String, String> params,
    Function errorCallBack,
    CancelToken token,
  }) async {
    _request(
      url,
      callBack,
      method: GET,
      params: params,
      errorCallBack: errorCallBack,
      token: token,
    );
  }

  void _request(
    String url,
    Function callBack, {
    String method,
    Map<String, String> params,
    FormData formData,
    Function errorCallBack,
    ProgressCallback progressCallBack,
    CancelToken token,
  }) async {
    if (params != null && params.isNotEmpty) {
      print("<net> params :" + params.toString());
    }

    String errorMsg = "";
    int statusCode;
    try {
      Response response;
      if (method == GET) {
        if (params != null && params.isNotEmpty) {
          response = await _client.get(
            url,
            queryParameters: params,
            cancelToken: token,
          );
        } else {
          response = await _client.get(
            url,
            cancelToken: token,
          );
        }
      } else {
        if (params != null && params.isNotEmpty || formData.isNotEmpty) {
          response = await _client.post(
            url,
            data: formData ?? new FormData.from(params),
            onSendProgress: progressCallBack,
            cancelToken: token,
          );
        } else {
          response = await _client.post(
            url,
            cancelToken: token,
          );
        }
      }

      statusCode = response.statusCode;

      if (statusCode < 0) {
        errorMsg =
            "Network request error, status code:" + statusCode.toString();
        _handError(errorCallBack, errorMsg);
        return;
      }

      if (callBack != null) {
        callBack(response.data);
      }
    } catch (e) {
      _handError(errorCallBack, e.toString());
    }
  }

  static void _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
    print("<net> errorMsg :" + errorMsg);
  }
}
