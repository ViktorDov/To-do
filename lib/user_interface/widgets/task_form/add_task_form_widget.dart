import 'package:flutter/material.dart';
import 'add_task_form_widget_model.dart';

class AddTaskFormWidget extends StatefulWidget {
  const AddTaskFormWidget({super.key});

  @override
  State<AddTaskFormWidget> createState() => _AddTaskFormWidgetState();
}

class _AddTaskFormWidgetState extends State<AddTaskFormWidget> {
  AddTasksFromWidgetModel? _model;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_model == null) {
      final groupKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = AddTasksFromWidgetModel(groupKey: groupKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = _model;
    if (model != null) {
      return AddTasksFromWidgetProvider(
        model: model,
        child: const _AddTaskFormWidgetBody(),
      );
    } else {
      return const CircularProgressIndicator();
    }
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
