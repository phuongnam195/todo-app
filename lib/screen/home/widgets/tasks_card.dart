import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/screen/home/home_bloc.dart';
import 'package:todo_app/screen/home/home_screen.dart';
import 'package:todo_app/util/constants.dart';

class TasksCard extends StatefulWidget {
  const TasksCard(this.tasks, {Key? key}) : super(key: key);

  final List<Task> tasks;

  @override
  State<TasksCard> createState() => _TasksCardState();
}

class _TasksCardState extends State<TasksCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            alignment: Alignment.centerRight,
            child: Text(
              '$_numCompletedTasks/${widget.tasks.length}',
              style: AppStyle.hintText.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          if (widget.tasks.isNotEmpty)
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
                  width: widget.tasks.isEmpty
                      ? 0
                      : constraints.maxWidth *
                          _numCompletedTasks /
                          widget.tasks.length,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ),
          for (int i = 0; i < widget.tasks.length; i++) _item(i)
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
                homeBloc.add(CheckTask(widget.tasks[i]));
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
              extentRatio: 0.2,
              motion: const DrawerMotion(),
              children: [
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
            title: const Text('Delete Task'),
            content: const Text('Are you sure delete this task?'),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: const Text('Delete'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }
}
