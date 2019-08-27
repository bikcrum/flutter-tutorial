// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en_US';

  static m0(taskNumbers) => "${Intl.plural(taskNumbers, zero: 'You have never written a list of tasks.\nLet\'s get started soon.', one: 'This is your todo-list,\nToday, you have 1 task to complete. ', many: 'This is your todo-list,\nToday, you have ${taskNumbers} tasks to complete. ', other: 'This is your todo-list,\nToday, you have ${taskNumbers} tasks to complete. ')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "languageTitle" : MessageLookupByLibrary.simpleMessage("Change Language"),
    "taskItems" : m0,
    "welcome" : MessageLookupByLibrary.simpleMessage("Hello! ")
  };
}
