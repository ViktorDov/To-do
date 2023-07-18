import 'package:flutter/material.dart';
import '../widgets/group_form/add_group_form_widget.dart';
import '../widgets/groups/groups_widget.dart';
import '../widgets/task_form/add_task_form_widget.dart';
import '../widgets/tasks/tasks_widget.dart';

abstract class NavigationRoutesName {
  static const String groups = '/';
  static const String addGroup = '/add_group';
  static const String tasks = '/tasks';
  static const String addTask = '/tasks/add_new_task';
}

class MainNavigation {
  final initialRoute = NavigationRoutesName.groups;
  final routes = <String, Widget Function(BuildContext)>{
    NavigationRoutesName.groups: (context) => const GroupsWidget(),
    NavigationRoutesName.addGroup: (context) => const AddGroupFormWidget(),
    NavigationRoutesName.tasks: (context) => const TasksWidget(),
    NavigationRoutesName.addTask: (context) => const AddTaskFormWidget(),
  };
}
