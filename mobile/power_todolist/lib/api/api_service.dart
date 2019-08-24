import 'package:dio/dio.dart';
import 'package:power_todolist/api/api_stratery.dart';
import 'package:power_todolist/json/photo_power.dart';

export 'package:dio/dio.dart';

class ApiService {
  static ApiService _instance;

  static ApiService getInstance() {
    if (_instance == null) {
      _instance = new ApiService._internal();
    }
    return _instance;
  }

  static final int SUCCEED = 0;
  static final int FAILED = 1;

  ApiService._internal();

  void getPhotos({
    Function success,
    Function failed,
    Function error,
    Map<String, String> params,
    CancelToken token,
  }) {
    ApiStrategy.getInstance().get(
      "https://api.unsplash.com/photos/",
      (data) {
        if (data.toString().contains("errors")) {
          failed(data);
        } else {
          List<PhotoPower> powers = PhotoPower.fromMapList(data);
          success(powers);
        }
      },
      params: params,
      errorCallBack: (errorMessage) {
        error(errorMessage);
      },
      token: token,
    );
  }
}
