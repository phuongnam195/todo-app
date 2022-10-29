import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/util/constants.dart';
import 'package:todo_app/util/date_time_utils.dart';

import '../home_bloc.dart';
import '../home_screen.dart';

class NewTaskForm extends StatefulWidget {
  const NewTaskForm({required this.onSubmit, Key? key}) : super(key: key);

  final void Function(String?) onSubmit;

  @override
  State<NewTaskForm> createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  final _titleController = TextEditingController();
  final _dateTimeController = TextEditingController();

  final _titleNode = FocusNode();

  DateTime _selectedDateTime = DateTimeUtils.today();

  @override
  void initState() {
    _dateTimeController.text = _selectedDateTime.formatDateTime();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateTimeController.dispose();
    _titleNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: homeBloc,
      listenWhen: (prev, curr) => curr is TaskAdded,
      listener: (ctx, state) {
        if (state is TaskAdded) {
          widget.onSubmit('Task has been added!');
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
                color: AppColors.hint,
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _titleController,
              focusNode: _titleNode,
              style: AppStyle.subtitle,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'Try typing \'Take the English test\'',
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text('Date & Time', style: AppStyle.hintText)),
            const SizedBox(height: 10),
            TextField(
              controller: _dateTimeController,
              style: AppStyle.subtitle,
              readOnly: true,
              showCursor: false,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.hint, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                suffixIcon: const Icon(Icons.calendar_today_outlined),
              ),
              textAlign: TextAlign.center,
              onTap: () async {
                DatePicker.showDateTimePicker(
                  context,
                  locale: LocaleType.en,
                  currentTime: DateTime.now(),
                  minTime: DateTime.now(),
                  maxTime:
                      DateTimeUtils.today().add(const Duration(days: 365 * 5)),
                  onConfirm: (time) {
                    _selectedDateTime = time;
                    _dateTimeController.text =
                        _selectedDateTime.formatDateTime();
                  },
                );
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              child: Text(
                'Add new task',
                style: AppStyle.title.copyWith(color: Colors.white),
              ),
              onPressed: () => _onSubmit(),
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: AppColors.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  fixedSize: const Size.fromWidth(double.maxFinite)),
            ),
            const SizedBox(height: 10),
            Text(
              'Back to task list',
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
    _addNewTask();
  }

  _addNewTask() {
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch,
      title: _titleController.text,
      dateTime: _selectedDateTime,
      createdDate: DateTime.now(),
    );
    homeBloc.add(AddTask(task));
  }
}
