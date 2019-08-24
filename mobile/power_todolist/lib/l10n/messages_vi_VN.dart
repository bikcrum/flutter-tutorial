// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi_VN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

// ignore: unnecessary_new
final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'vi_VN';

  static m0(taskNumbers) => "${Intl.plural(taskNumbers, zero: 'Bạn chưa viết một nhiệm vụ nào.\nHãy bắt đầu nào.', one: 'Đây là danh sách việc cần làm của bạn,\nHôm nay, bạn có 1 nhiệm vụ phải hoàn thành. ', many: 'Đây là danh sách việc cần làm của bạn,\nHôm nay, bạn có ${taskNumbers} nhiệm vụ phải hoàn thành. ', other: 'Đây là danh sách việc cần làm của bạn,\nHôm nay, bạn có ${taskNumbers} nhiệm vụ phải hoàn thành. ')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appName" : MessageLookupByLibrary.simpleMessage("Công việc cần làm"),
    "appSetting" : MessageLookupByLibrary.simpleMessage("Cài đặt"),
    "changeTheme" : MessageLookupByLibrary.simpleMessage("Đổi giao diện"),
    "doneList" : MessageLookupByLibrary.simpleMessage("Danh sách hoàn thành"),
    "game" : MessageLookupByLibrary.simpleMessage("Trò chơi"),
    "languageTitle" : MessageLookupByLibrary.simpleMessage("Đổi ngôn ngữ"),
    "loading" : MessageLookupByLibrary.simpleMessage("đang tải..."),
    "loadingEmpty" : MessageLookupByLibrary.simpleMessage("không có gì"),
    "loadingError" : MessageLookupByLibrary.simpleMessage("tải thất bại"),
    "loadingIdle" : MessageLookupByLibrary.simpleMessage("..."),
    "music" : MessageLookupByLibrary.simpleMessage("Âm nhạc"),
    "reLoading" : MessageLookupByLibrary.simpleMessage("nhấp để tải lại"),
    "read" : MessageLookupByLibrary.simpleMessage("Ghi chép"),
    "sports" : MessageLookupByLibrary.simpleMessage("Thể thao"),
    "taskItems" : m0,
    "travel" : MessageLookupByLibrary.simpleMessage("Du lịch"),
    "welcomeWord" : MessageLookupByLibrary.simpleMessage("Xin chào! "),
    "work" : MessageLookupByLibrary.simpleMessage("Công việc")
  };
}
