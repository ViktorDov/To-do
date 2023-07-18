import 'package:flutter_todo_list/domain/entity/group/group.dart';
import 'package:flutter_todo_list/domain/entity/task/task.dart';
import 'package:hive/hive.dart';

class BoxManager {
  static final BoxManager instance = BoxManager._();

  BoxManager._();

  Future<Box<Group>> openGroupBox() {
    return _openBox('new_group', 0, GroupAdapter());
  }

  Future<Box<Task>> openTaskBox() {
    return _openBox('task_box', 1, TaskAdapter());
  }

  Future<void> closeBox<T>(Box<T> box) async {
    await box.compact();
    await box.close();
  }

  Future<Box<T>> _openBox<T>(
    String name,
    int typeId,
    TypeAdapter<T> adapter,
  ) async {
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }
    return await Hive.openBox<T>(name);
  }
}
