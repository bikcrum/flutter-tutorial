import 'package:hello_flutter/model/main_page_model.dart';

class MainPageLogic {
  final MainPageModel _model;

  MainPageLogic(this._model);

  void incrementCounter() {
    this._model.counter++;
    this._model.refresh();
  }
}
