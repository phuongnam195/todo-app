import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/screen/home/home_bloc.dart';
import 'package:todo_app/screen/home/home_screen.dart';
import 'package:todo_app/util/constants.dart';

import 'task_handler_form.dart';

class TasksCard extends StatefulWidget {
  const TasksCard({required this.title, required this.tasks, Key? key})
      : super(key: key);

  final String title;
  final List<Task> tasks;

  @override
  State<TasksCard> createState() => _TasksCardState();
}

class _TasksCardState extends State<TasksCard> {
  bool _isExpanded = true;

  @override
  void initState() {
    if (widget.tasks.isEmpty) {
      _isExpanded = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: widget.tasks.isNotEmpty
                ? () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  }
                : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Text(
                    widget.title,
                    style: AppStyle.title,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '$_numCompletedTasks/${widget.tasks.length}',
                    style:
                        AppStyle.hintText.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  if (widget.tasks.isNotEmpty)
                    Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: AppColor.hint,
                    ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Container(
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: const Color(0xFFE1E1E1),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.centerLeft,
              child: LayoutBuilder(
                  builder: (context, constraints) => Container(
                        width: constraints.maxWidth *
                            _numCompletedTasks /
                            widget.tasks.length,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: AppColor.secondary,
                        ),
                      )),
            ),
          if (_isExpanded)
            ReorderableListView(
              shrinkWrap: true,
              children: [
                for (int i = 0; i < widget.tasks.length; i++) _item(i)
              ],
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final task = widget.tasks.removeAt(oldIndex);
                  widget.tasks.insert(newIndex, task);
                });
              },
            )
        ],
      ),
    );
  }

  Widget _item(int i) {
    return Builder(
        key: Key('${widget.tasks[i]}'),
        builder: (context) {
          final task = widget.tasks[i];
          return Slidable(
            key: Key('${task.id}-slidable'),
            child: CheckboxListTile(
              value: widget.tasks[i].isCompleted,
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    widget.tasks[i] = task.complete();
                  } else {
                    widget.tasks[i] = task.uncomplete();
                  }
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                task.title,
                style: AppStyle.subtitle.copyWith(
                    decoration:
                        task.isCompleted ? TextDecoration.lineThrough : null),
              ),
            ),
            endActionPane: ActionPane(
              extentRatio: 0.4,
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) => _editTask(i),
                  backgroundColor: const Color(0xFF1885F2),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                ),
                SlidableAction(
                  onPressed: (_) async {
                    final ok = await _confirmDeleteTask();
                    if (ok) {
                      _deleteTask(i);
                    }
                  },
                  backgroundColor: const Color(0xFFFF382C),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                ),
              ],
            ),
          );
        });
  }

  int get _numCompletedTasks =>
      widget.tasks.where((task) => task.isCompleted).length;

  _editTask(int index) {
    showModalBottomSheet(
      context: context,
      builder: (_) => TaskHandlerForm(taskId: widget.tasks[index].id),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
    );
  }

  _deleteTask(int index) {
    homeBloc.add(DeleteTask(widget.tasks[index].id));
    setState(() {
      widget.tasks.removeAt(index);
    });
  }

  Future<bool> _confirmDeleteTask() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(S.current.delete_task),
            content: Text(S.current.delete_task_confirm),
            actions: [
              TextButton(
                child: Text(S.current.cancel),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(S.current.delete),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }
}
