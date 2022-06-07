// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(countIncompleted) =>
      "You have ${countIncompleted} tasks to do today";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add_new_task": MessageLookupByLibrary.simpleMessage("Add new task"),
        "add_task_success":
            MessageLookupByLibrary.simpleMessage("Task has been added!"),
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "back_to_task_list":
            MessageLookupByLibrary.simpleMessage("Back to task list"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "complete": MessageLookupByLibrary.simpleMessage("Complete"),
        "current_language": MessageLookupByLibrary.simpleMessage("English"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "delete_task": MessageLookupByLibrary.simpleMessage("Delete Task"),
        "delete_task_confirm": MessageLookupByLibrary.simpleMessage(
            "Are you sure delete this task?"),
        "delete_task_error":
            MessageLookupByLibrary.simpleMessage("Task does not exist"),
        "delete_task_success":
            MessageLookupByLibrary.simpleMessage("Task has been deleted!"),
        "due_date": MessageLookupByLibrary.simpleMessage("Due date"),
        "duplicate_task":
            MessageLookupByLibrary.simpleMessage("Duplicate task"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "every_day": MessageLookupByLibrary.simpleMessage("Every day"),
        "every_month": MessageLookupByLibrary.simpleMessage("Every month"),
        "every_week": MessageLookupByLibrary.simpleMessage("Every week"),
        "every_year": MessageLookupByLibrary.simpleMessage("Every year"),
        "hahahaa": MessageLookupByLibrary.simpleMessage("hahaha"),
        "incomplete": MessageLookupByLibrary.simpleMessage("Incomplete"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "never": MessageLookupByLibrary.simpleMessage("Never"),
        "notification": MessageLookupByLibrary.simpleMessage("Notification"),
        "notification_description":
            MessageLookupByLibrary.simpleMessage("Remind due tasks"),
        "notification_title": m0,
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "on_time": MessageLookupByLibrary.simpleMessage("On time"),
        "others": MessageLookupByLibrary.simpleMessage("Others"),
        "overdue": MessageLookupByLibrary.simpleMessage("Overdue"),
        "repeat": MessageLookupByLibrary.simpleMessage("Repeat"),
        "repeat_task": MessageLookupByLibrary.simpleMessage("Repeat task"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "setting": MessageLookupByLibrary.simpleMessage("Setting"),
        "switch_language": MessageLookupByLibrary.simpleMessage("Switch"),
        "task_not_found":
            MessageLookupByLibrary.simpleMessage("Task not found"),
        "task_title_hint": MessageLookupByLibrary.simpleMessage(
            "Try typing \'Take the English test\'"),
        "this_week": MessageLookupByLibrary.simpleMessage("This week"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "tommorow": MessageLookupByLibrary.simpleMessage("Tommorow"),
        "update_task_error":
            MessageLookupByLibrary.simpleMessage("Cannot update this task!"),
        "update_task_success":
            MessageLookupByLibrary.simpleMessage("Task has been updated!")
      };
}
