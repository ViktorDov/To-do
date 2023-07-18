import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_list/domain/entity/group/group.dart';
import 'package:flutter_todo_list/user_interface/navigation/routes.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../domain/entity/task/task.dart';

class TasksWidgetModel extends ChangeNotifier {
  int groupKey;
  late final Future<Box<Group>> _groupBox;
  var _tasks = <Task>[];
  List<Task> get tasks => _tasks.toList();
  Group? _group;
  Group? get group => _group;

  TasksWidgetModel({required this.groupKey}) {
    _setup();
  }

  void addTaskButton(BuildContext context) {
    Navigator.of(context)
        .pushNamed(NavigationRoutesName.addTask, arguments: groupKey);
  }

  void _loadGroupTitle() async {
    final box = await _groupBox;
    _group = box.get(groupKey);
    notifyListeners();
  }

  void _readTasks() {
    _tasks = _group?.tasks?.cast<Task>().toList() ?? <Task>[];
    notifyListeners();
  }

  void deleteTask(int indexTask) async {
    await _group?.tasks?.deleteFromHive(indexTask);
    await _group?.save();
  }

  void switchIsDone(int indexTask) {
    Task task = tasks[indexTask];
    task.switchStateIsDone();
    notifyListeners();
  }

  void _setupListenTasks() async {
    final box = await _groupBox;
    _readTasks();
    box.listenable(keys: [groupKey]).addListener(_readTasks);
  }

  void _setup() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GroupAdapter());
    }
    _groupBox = Hive.openBox<Group>('new_group');
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TaskAdapter());
    }
    Hive.openBox<Task>('task_box');
    _loadGroupTitle();
    _setupListenTasks();
  }
}

class TasksWidgetProvider extends InheritedNotifier {
  final TasksWidgetModel model;
  const TasksWidgetProvider(
      {Key? key, required Widget child, required this.model})
      : super(
          key: key,
          notifier: model,
          child: child,
        );

  static TasksWidgetProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TasksWidgetProvider>();
  }

  static TasksWidgetProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksWidgetProvider>()
        ?.widget;
    return widget is TasksWidgetProvider ? widget : null;
  }
}
