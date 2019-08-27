import '../model/main_page_model.dart';
import '../config/provider_config.dart';

class MainPageLogic {
  final MainPageModel _model;

  MainPageLogic(this._model);

  void addNumber() {
    _model.taskNumbers++;
    _model.refresh();
  }

  void subNumber() {
    _model.taskNumbers--;
    _model.taskNumbers = _model.taskNumbers < 0 ? 0 : _model.taskNumbers;
    _model.refresh();
  }
}
