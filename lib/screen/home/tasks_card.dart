import 'package:flutter/material.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/util/constants.dart';

class TasksCard extends StatefulWidget {
  const TasksCard({required this.title, required this.tasks, Key? key})
      : super(key: key);

  final String title;
  final List<Task> tasks;

  @override
  State<TasksCard> createState() => _TasksCardState();
}

class _TasksCardState extends State<TasksCard> {
  bool _isExpanded = false;

  @override
  void initState() {
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
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
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
                    style: AppStyle.hint.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
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
                for (int i = 0; i < widget.tasks.length; i++)
                  Builder(
                      key: Key('${widget.tasks[i]}'),
                      builder: (context) {
                        final task = widget.tasks[i];
                        return CheckboxListTile(
                          value: widget.tasks[i].isCompleted,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 5),
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
                            task.content,
                            style: AppStyle.subtitle.copyWith(
                                decoration: task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null),
                          ),
                        );
                      })
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

  int get _numCompletedTasks =>
      widget.tasks.where((task) => task.isCompleted).length;
}
