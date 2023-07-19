import 'package:flutter/material.dart';
import '../widgets/group_form/add_group_form_widget.dart';
import '../widgets/groups/groups_widget.dart';
import '../widgets/task_form/add_task_form_widget.dart';
import '../widgets/tasks/tasks_widget.dart';

abstract class NavigationRoutesName {
  static const String groups = '/';
  static const String addGroup = '/add_group';
  static const String tasks = '/tasks';
  static const String addTask = '/tasks/add_task';
}

class MainNavigation {
  final initialRoute = NavigationRoutesName.groups;
  final routes = <String, Widget Function(BuildContext)>{
    NavigationRoutesName.groups: (context) => const GroupsWidget(),
    NavigationRoutesName.addGroup: (context) => const AddGroupFormWidget(),
  };

  Route<Object> onGenerateRouteSetings(RouteSettings settings) {
    switch (settings.name) {
      case NavigationRoutesName.tasks:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => TasksWidget(groupKey: groupKey),
        );
      case NavigationRoutesName.addTask:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => AddTaskFormWidget(groupKey: groupKey),
        );
      default:
        const widget = Text('Errror!!!');
        return MaterialPageRoute(builder: ((context) => widget));
    }
  }
}
