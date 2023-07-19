import 'package:flutter/material.dart';
import 'add_task_form_widget_model.dart';

class AddTaskFormWidget extends StatefulWidget {
  final int groupKey;
  const AddTaskFormWidget({super.key, required this.groupKey});

  @override
  State<AddTaskFormWidget> createState() => _AddTaskFormWidgetState();
}

class _AddTaskFormWidgetState extends State<AddTaskFormWidget> {
  late final AddTasksFromWidgetModel _model;
  @override
  void initState() {
    super.initState();
    _model = AddTasksFromWidgetModel(groupKey: widget.groupKey);
  }

  @override
  Widget build(BuildContext context) {
    return AddTasksFromWidgetProvider(
      model: _model,
      child: const _AddTaskFormWidgetBody(),
    );
  }
}

class _AddTaskFormWidgetBody extends StatelessWidget {
  const _AddTaskFormWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add a new group',
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: _TaskFormWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            AddTasksFromWidgetProvider.read(context)?.model.saveTask(context),
        child: const Icon(Icons.done_all_outlined),
      ),
    );
  }
}

class _TaskFormWidget extends StatelessWidget {
  const _TaskFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = AddTasksFromWidgetProvider.read(context)?.model;
    return Column(
      children: [
        TextField(
          autofocus: true,
          decoration: const InputDecoration(
            border: null,
            labelText: 'Title',
          ),
          // onEditingComplete: () => model?.saveTask(context),
          onChanged: (value) => model?.titleTask = value,
        ),
        const SizedBox(height: 10),
        TextField(
          autofocus: true,
          decoration: const InputDecoration(
            border: null,
            labelText: 'SubTitle',
          ),
          // onEditingComplete: () => model?.saveTask(context),
          onChanged: (value) => model?.subtitleTask = value,
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () => model?.saveTask(context),
          child: const Text('Safe'),
        )
      ],
    );
  }
}
