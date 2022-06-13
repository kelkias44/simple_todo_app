import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simple_todo/data/model/todo_model.dart';

class TodoDialog extends StatefulWidget {
  final Todo? todo;
  final Function(String description, String title, String date, String assignedTo) onClickedDone;
  const TodoDialog({this.todo, required this.onClickedDone});

  @override
  State<TodoDialog> createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  final formkey = GlobalKey<FormState>();
  final descController = TextEditingController();
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final assignedController = TextEditingController();

  
  @override
  void initState() {
    super.initState();

    if (widget.todo != null) {
      final todo = widget.todo!;

      descController.text = todo.description;
      titleController.text = todo.title;
      dateController.text = todo.date;
      assignedController.text = todo.assignedTo;
    }
  }

  @override
  void dispose() {
    descController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.todo != null;
    final title = isEditing ? 'Edit Todo' : 'Add Todo';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              buildTitle(),
              buildDescription(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
   }
   Widget buildDescription() => TextFormField(
        controller: descController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Todo',
        ),
        validator: (description) =>
            description != null && description.isEmpty ? 'Enter a name' : null,
      );
    Widget buildTitle() => TextFormField(
        controller: titleController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Todo Title',
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'Enter a name' : null,
      );
    Widget buildCancelButton(BuildContext context) => TextButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );
    Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formkey.currentState!.validate();

        if (isValid) {
          final description = descController.text;
          final title = titleController.text;
          final date = DateTime.now().toIso8601String();
          const assignedTo = '622de5fed3f42ebf99d1b5de';

          widget.onClickedDone(description, title,date,assignedTo);

          Navigator.of(context).pop();
        }
      },
    );
  }
}