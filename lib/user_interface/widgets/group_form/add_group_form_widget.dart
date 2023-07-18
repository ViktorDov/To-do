import 'package:flutter/material.dart';

import 'add_group_form_model.dart';

class AddGroupFormWidget extends StatefulWidget {
  const AddGroupFormWidget({super.key});

  @override
  State<AddGroupFormWidget> createState() => _AddGroupFormWidgetState();
}

class _AddGroupFormWidgetState extends State<AddGroupFormWidget> {
  final _model = AddGroupFormWidgetModel();
  @override
  Widget build(BuildContext context) {
    return AddGroupWidgetModelProvider(
      model: _model,
      child: const AddGroupFormWidgetBody(),
    );
  }
}

class AddGroupFormWidgetBody extends StatelessWidget {
  const AddGroupFormWidgetBody({super.key});

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
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: GroupNameForm(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            AddGroupWidgetModelProvider.read(context)?.model.saveGroup(context),
        child: const Icon(Icons.done_all_outlined),
      ),
    );
  }
}

class GroupNameForm extends StatelessWidget {
  const GroupNameForm({super.key});

  @override
  Widget build(BuildContext context) {
    final model = AddGroupWidgetModelProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Add name for a new group',
      ),
      onEditingComplete: () => model?.saveGroup(context),
      onChanged: (value) => model?.nameGroup = value,
    );
  }
}
