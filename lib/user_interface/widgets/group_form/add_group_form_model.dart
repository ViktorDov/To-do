import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../domain/entity/group/group.dart';

class AddGroupFormWidgetModel {
  var nameGroup = '';
  void saveGroup(BuildContext context) async {
    if (nameGroup.isEmpty) return;
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(GroupAdapter());
    }
    final box = await Hive.openBox<Group>('new_group');
    final group = Group(name: nameGroup);
    await box.add(group);
    if (context.mounted) Navigator.of(context).pop();
  }
}

class AddGroupWidgetModelProvider extends InheritedWidget {
  final AddGroupFormWidgetModel model;
  const AddGroupWidgetModelProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(
          key: key,
          child: child,
        );

  static AddGroupWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AddGroupWidgetModelProvider>();
  }

  static AddGroupWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<AddGroupWidgetModelProvider>()
        ?.widget;
    return widget is AddGroupWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
