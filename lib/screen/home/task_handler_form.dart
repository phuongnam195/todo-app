import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/model/repeat_type.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/util/constants.dart';
import 'package:todo_app/util/date_time_utils.dart';

import 'home_bloc.dart';
import 'home_screen.dart';
import 'repeat_type_picker.dart';

class TaskHandlerForm extends StatefulWidget {
  const TaskHandlerForm({this.taskId, required this.onDone, Key? key})
      : super(key: key);

  final int? taskId;
  final void Function(String?) onDone;

  @override
  State<TaskHandlerForm> createState() => _TaskHandlerFormState();
}

class _TaskHandlerFormState extends State<TaskHandlerForm> {
  final _titleController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _repeatController = TextEditingController();

  final _titleNode = FocusNode();

  DateTime _selectedDueDate = DateTimeUtils.today();
  RepeatType _selectedRepeatType = RepeatType.never;

  Task? _neededEditTask;
  bool _canSubmit = true;

  @override
  void initState() {
    _dueDateController.text = DateTimeUtils.formatDate(_selectedDueDate);
    _repeatController.text = _selectedRepeatType.string();
    if (widget.taskId != null) {
      homeBloc.add(LoadTask(widget.taskId!));
      _canSubmit = false;
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dueDateController.dispose();
    _repeatController.dispose();
    _titleNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: homeBloc,
      listenWhen: (prev, curr) =>
          curr is TaskLoaded || curr is TaskAdded || curr is TaskUpdated,
      listener: (ctx, state) {
        if (state is TaskLoaded) {
          _neededEditTask = state.task;
          _titleController.text = _neededEditTask!.title;
          _selectedDueDate = _neededEditTask!.dueDate;
          _dueDateController.text = DateTimeUtils.formatDate(_selectedDueDate);
          _selectedRepeatType = _neededEditTask!.repeatType;
          _repeatController.text = _selectedRepeatType.string();

          setState(() {
            _canSubmit = true;
          });
        } else if (state is TaskUpdated) {
          widget.onDone(S.current.update_task_success);
        } else if (state is TaskAdded) {
          widget.onDone(S.current.add_task_success);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: 45,
            right: 45,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              width: 60,
              height: 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: AppColor.hint,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _titleController,
              focusNode: _titleNode,
              style: AppStyle.subtitle,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: S.current.task_title_hint,
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Flexible(
              child: Row(
                children: [
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.current.due_date, style: AppStyle.hintText),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _dueDateController,
                          style: AppStyle.subtitle,
                          readOnly: true,
                          showCursor: false,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColor.hint, width: 1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            suffixIcon:
                                const Icon(Icons.calendar_today_outlined),
                          ),
                          onTap: () async {
                            final value = await showDatePicker(
                              context: context,
                              initialDate: _selectedDueDate,
                              firstDate: DateTimeUtils.today()
                                  .subtract(const Duration(days: 30)),
                              lastDate: DateTimeUtils.today()
                                  .add(const Duration(days: 30)),
                            );
                            _selectedDueDate = value ?? _selectedDueDate;
                            _dueDateController.text =
                                DateTimeUtils.formatDate(_selectedDueDate);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.current.repeat, style: AppStyle.hintText),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _repeatController,
                          style: AppStyle.subtitle,
                          readOnly: true,
                          showCursor: false,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            suffixIcon: const Icon(Icons.expand_more),
                          ),
                          onTap: () {
                            var repeatType = _selectedRepeatType;
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                content: RepeatTypePicker(
                                    value: repeatType,
                                    onSelected: (type) {
                                      repeatType = type;
                                    }),
                                actions: [
                                  TextButton(
                                    child: Text(S.current.ok),
                                    onPressed: () {
                                      setState(() {
                                        _selectedRepeatType = repeatType;
                                        _repeatController.text =
                                            repeatType.string();
                                      });
                                      Navigator.of(ctx).pop();
                                    },
                                    style: TextButton.styleFrom(
                                        primary: AppColor.negative,
                                        textStyle: AppStyle.title),
                                  )
                                ],
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: Text(
                _neededEditTask == null
                    ? S.current.add_new_task
                    : S.current.save,
                style: AppStyle.title.copyWith(color: Colors.white),
              ),
              onPressed: _canSubmit ? () => _onSubmit() : null,
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: AppColor.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  fixedSize: const Size.fromWidth(double.maxFinite)),
            ),
            const SizedBox(height: 10),
            Text(
              S.current.back_to_task_list,
              style: AppStyle.hintText.copyWith(fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _onSubmit() {
    if (_titleController.text.isEmpty) {
      _titleNode.requestFocus();
      return;
    }
    if (_neededEditTask == null) {
      _addNewTask();
    } else {
      _updateTask();
    }
  }

  _addNewTask() {
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch,
      title: _titleController.text,
      dueDate: _selectedDueDate,
      repeatType: _selectedRepeatType,
      createdDate: DateTime.now(),
    );
    homeBloc.add(AddTask(task));
  }

  _updateTask() {
    final task = _neededEditTask!.copyWith(
        title: _titleController.text,
        dueDate: _selectedDueDate,
        repeatType: _selectedRepeatType,
        completedDate: _neededEditTask!.completedDate);
    homeBloc.add(UpdateTask(task));
  }
}
