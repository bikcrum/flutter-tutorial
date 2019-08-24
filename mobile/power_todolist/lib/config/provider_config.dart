import 'package:flutter/material.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:power_todolist/pages/all_page.dart';
import 'package:provider/provider.dart';

class ProviderConfig {
  static ProviderConfig _instance;

  static ProviderConfig getInstance() {
    if (_instance == null) {
      _instance = ProviderConfig._internal();
    }
    return _instance;
  }

  ProviderConfig._internal();

  ChangeNotifierProvider<GlobalModel> getGlobal(Widget child) {
    return ChangeNotifierProvider<GlobalModel>(
      builder: (context) => GlobalModel(),
      child: child,
    );
  }

  ChangeNotifierProvider<MainPageModel> getMainPage() {
    return ChangeNotifierProvider<MainPageModel>(
      builder: (context) => MainPageModel(),
      child: MainPage(),
    );
  }

  ChangeNotifierProvider<EditTaskPageModel> getEditTaskPage(TaskIconPower taskIcon, {TaskDetailPageModel taskDetailPageModel, TaskPower taskPower}) {
    return ChangeNotifierProvider<EditTaskPageModel>(
      builder: (context) => EditTaskPageModel(oldTaskPower: taskPower),
      child: EditTaskPage(
        taskIcon,
        taskDetailPageModel: taskDetailPageModel,
      ),
    );
  }

  ChangeNotifierProvider<TaskDetailPageModel> getTaskDetailPage(
    int index,
    TaskPower taskPower, {
    DoneTaskPageModel doneTaskPageModel,
    SearchPageModel searchPageModel,
  }) {
    return ChangeNotifierProvider<TaskDetailPageModel>(
      builder: (context) => TaskDetailPageModel(
        taskPower,
        doneTaskPageModel: doneTaskPageModel,
        searchPageModel: searchPageModel,
        heroTag: index,
      ),
      child: TaskDetailPage(),
    );
  }

  ChangeNotifierProvider<DoneTaskPageModel> getDoneTaskPage() {
    return ChangeNotifierProvider<DoneTaskPageModel>(
      builder: (context) => DoneTaskPageModel(),
      child: DoneTaskPage(),
    );
  }

  ChangeNotifierProvider<ThemePageModel> getThemePage() {
    return ChangeNotifierProvider<ThemePageModel>(
      builder: (context) => ThemePageModel(),
      child: ThemePage(),
    );
  }

  ChangeNotifierProvider<IconSettingPageModel> getIconSettingPage() {
    return ChangeNotifierProvider<IconSettingPageModel>(
      builder: (context) => IconSettingPageModel(),
      child: IconSettingPage(),
    );
  }

  ChangeNotifierProvider<AvatarPageModel> getAvatarPage({MainPageModel mainPageModel}) {
    return ChangeNotifierProvider<AvatarPageModel>(
      builder: (context) => AvatarPageModel(),
      child: AvatarPage(
        mainPageModel: mainPageModel,
      ),
    );
  }

  ChangeNotifierProvider<SearchPageModel> getSearchPage() {
    return ChangeNotifierProvider<SearchPageModel>(
      builder: (context) => SearchPageModel(),
      child: SearchPage(),
    );
  }
}
