import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'tasks_widget_model.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({super.key});

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  TasksWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TasksWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = _model;
    if (model != null) {
      return TasksWidgetProvider(
        model: model,
        child: const TasksWidgetBody(),
      );
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}

class TasksWidgetBody extends StatelessWidget {
  const TasksWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TasksWidgetProvider.watch(context)?.model;
    final title = model?.group?.name ?? 'Tasks';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const _ListGroupsWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => model?.addTaskButton(context),
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
        TasksWidgetProvider.watch(context)?.model.tasks.length ?? 0;
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
    final model = TasksWidgetProvider.read(context)!.model;
    final task = model.tasks[indexInList];

    final icon = task.isDone
        ? const Icon(Icons.done)
        : const Icon(Icons.read_more_outlined);

    final liteThrougth = task.isDone
        ? const TextStyle(decoration: TextDecoration.lineThrough)
        : null;
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 1,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete_forever_outlined,
            onPressed: (BuildContext context) => model.deleteTask(indexInList),
          ),
        ],
      ),
      child: ColoredBox(
        color: Colors.white,
        child: ListTile(
          title: Text(
            task.title,
            style: liteThrougth,
          ),
          subtitle: Text(
            task.subTitle,
            style: liteThrougth,
          ),
          trailing: icon,
          onTap: () => model.switchIsDone(indexInList),
        ),
      ),
    );
  }
}
