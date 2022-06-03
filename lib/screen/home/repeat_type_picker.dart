import 'package:flutter/material.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/model/repeat_type.dart';
import 'package:todo_app/util/constants.dart';

class RepeatTypePicker extends StatefulWidget {
  const RepeatTypePicker({this.value, required this.onSelected, Key? key})
      : super(key: key);

  final RepeatType? value;
  final void Function(RepeatType) onSelected;

  @override
  State<RepeatTypePicker> createState() => _RepeatTypePickerState();
}

class _RepeatTypePickerState extends State<RepeatTypePicker> {
  late RepeatType _selectedRepeatType;

  @override
  void initState() {
    _selectedRepeatType = widget.value ?? RepeatType.never;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Text(
              S.current.repeat_task,
              style: AppStyle.title,
            ),
          ),
          for (var type in RepeatType.values)
            RadioListTile(
              title: Text(type.string()),
              value: type,
              groupValue: _selectedRepeatType,
              controlAffinity: ListTileControlAffinity.trailing,
              contentPadding: const EdgeInsets.only(left: 15, right: 10),
              onChanged: (RepeatType? value) {
                if (value == _selectedRepeatType) return;
                setState(() {
                  _selectedRepeatType = value ?? _selectedRepeatType;
                });
                widget.onSelected(_selectedRepeatType);
              },
            )
        ]);
  }
}
