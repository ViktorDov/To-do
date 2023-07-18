import 'package:flutter/material.dart';
import 'package:flutter_todo_list/domain/data_provider/box_manager.dart';
import 'package:flutter_todo_list/domain/entity/group/group.dart';
import 'package:flutter_todo_list/domain/entity/task/task.dart';
import 'package:hive/hive.dart';

class AddTasksFromWidgetModel {
  int groupKey;
  var titleTask = '';
  var subtitleTask = '';

  AddTasksFromWidgetModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    if (titleTask.isEmpty || subtitleTask.isEmpty) return;
    BoxManager.instance.openGroupBox();
    BoxManager.instance.openTaskBox();
    // if (!Hive.isAdapterRegistered(0)) {
    //   Hive.registerAdapter(GroupAdapter());
    // }
    // if (!Hive.isAdapterRegistered(1)) {
    //   Hive.registerAdapter(TaskAdapter());
    // }
    final taskBox = await Hive.openBox<Task>('task_box');
    final task = Task(title: titleTask, subTitle: subtitleTask, isDone: false);
    await taskBox.add(task);

    final groupBox = await Hive.openBox<Group>('new_group');
    final group = groupBox.get(groupKey);
    group?.addTask(taskBox, task);
    if (context.mounted) Navigator.of(context).pop();
  }
}

class AddTasksFromWidgetProvider extends InheritedNotifier {
  final AddTasksFromWidgetModel model;
  const AddTasksFromWidgetProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          child: child,
        );

  static AddTasksFromWidgetProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AddTasksFromWidgetProvider>();
  }

  static AddTasksFromWidgetProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<AddTasksFromWidgetProvider>()
        ?.widget;
    return widget is AddTasksFromWidgetProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(AddTasksFromWidgetProvider oldWidget) {
    return false;
  }
}
