import 'package:flutter/material.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/screen/home/tasks_card.dart';
import 'package:todo_app/util/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: TasksCard(title: 'Today', tasks: [
        Task(
          id: 1,
          content: 'Task 1',
          isCompleted: false,
          createdDate: DateTime.now(),
          dueDate: DateTime.now().add(const Duration(days: 1)),
        ),
        Task(
          id: 2,
          content: 'Task 2',
          isCompleted: true,
          createdDate: DateTime.now(),
          dueDate: DateTime.now().add(const Duration(days: 1)),
        ),
        Task(
          id: 3,
          content: 'Task 3',
          isCompleted: false,
          createdDate: DateTime.now(),
          dueDate: DateTime.now().add(const Duration(days: 1)),
        ),
        Task(
          id: 4,
          content: 'Task 4',
          isCompleted: false,
          createdDate: DateTime.now(),
          dueDate: DateTime.now().add(const Duration(days: 1)),
        ),
        Task(
          id: 5,
          content: 'Task 5',
          isCompleted: false,
          createdDate: DateTime.now(),
          dueDate: DateTime.now().add(const Duration(days: 1)),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        child: const Icon(Icons.add),
        elevation: 0,
        onPressed: () {},
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.done_all_outlined),
            label: S.current.complete,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.ballot_outlined),
            label: S.current.all,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.rule),
            label: S.current.incomplete,
          ),
        ],
        currentIndex: _currentPageIndex,
        selectedItemColor: AppColor.secondary,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
    );
  }
}
