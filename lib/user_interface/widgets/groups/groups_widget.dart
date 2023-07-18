import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'groups_widget_model.dart';

class GroupsWidget extends StatefulWidget {
  const GroupsWidget({super.key});

  @override
  State<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {
  final _model = GroupsWidgetModel();
  @override
  Widget build(BuildContext context) {
    return GroupsWidgetModelProvider(
      model: _model,
      child: const GroupsWidgetBody(),
    );
  }
}

class GroupsWidgetBody extends StatelessWidget {
  const GroupsWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Groups',
        ),
      ),
      body: const _ListGroupsWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => GroupsWidgetModelProvider.read(context)
            ?.model
            .addGroupButton(context),
        child: const Icon(
          Icons.plus_one_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _ListGroupsWidget extends StatelessWidget {
  const _ListGroupsWidget();

  @override
  Widget build(BuildContext context) {
    final groupCount =
        GroupsWidgetModelProvider.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
      itemCount: groupCount,
      itemBuilder: (BuildContext context, int index) {
        return _ListGroupsRowWidget(indexInList: index);
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(height: 1),
    );
  }
}

class _ListGroupsRowWidget extends StatelessWidget {
  final int indexInList;
  const _ListGroupsRowWidget({
    required this.indexInList,
  });

  @override
  Widget build(BuildContext context) {
    final model = GroupsWidgetModelProvider.read(context)!.model;
    final group = model.groups[indexInList];
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete_forever_outlined,
            onPressed: (BuildContext context) => model.deleteGroup(indexInList),
          ),
        ],
      ),
      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          title: Text(group.name),
          trailing: const Icon(Icons.chevron_right_outlined),
          onTap: () => model.showTasks(context, indexInList),
        ),
      ),
    );
  }
}
