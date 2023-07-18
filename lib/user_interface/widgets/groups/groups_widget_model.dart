import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_list/domain/data_provider/box_manager.dart';
import 'package:flutter_todo_list/user_interface/navigation/routes.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../domain/entity/group/group.dart';

class GroupsWidgetModel extends ChangeNotifier {
  late final Future<Box<Group>> _box;
  GroupsWidgetModel() {
    _setup();
  }

  var _group = <Group>[];
  List<Group> get groups => _group.toList();

  void addGroupButton(BuildContext context) {
    Navigator.of(context).pushNamed(NavigationRoutesName.addGroup);
  }

  Future<void> showTasks(BuildContext context, int indexGroup) async {
    final groupKey = (await _box).keyAt(indexGroup);

    unawaited(
      Navigator.of(context)
          .pushNamed(NavigationRoutesName.tasks, arguments: groupKey),
    );
  }

  Future<void> deleteGroup(int indexGroup) async {
    final box = await _box;
    await box.getAt(indexGroup)?.tasks?.deleteAllFromHive();
    await box.deleteAt(indexGroup);
  }

  Future<void> _readGroupsFromHive() async {
    _group = (await _box).values.toList();
    notifyListeners();
  }

  void _setup() async {
    _box = BoxManager.instance.openGroupBox();
    await BoxManager.instance.openTaskBox();
    _readGroupsFromHive();
    (await _box).listenable().addListener(_readGroupsFromHive);
  }
}

class GroupsWidgetModelProvider extends InheritedNotifier {
  final GroupsWidgetModel model;
  const GroupsWidgetModelProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static GroupsWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<GroupsWidgetModelProvider>();
  }

  static GroupsWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<GroupsWidgetModelProvider>()
        ?.widget;
    return widget is GroupsWidgetModelProvider ? widget : null;
  }
}
