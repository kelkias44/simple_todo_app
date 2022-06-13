import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simple_todo/presentation/bloc/bloc/todo_bloc.dart';
import 'package:simple_todo/presentation/widget/todo_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo/service_locator.dart';

import '../../data/model/todo_model.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('To do'),
          centerTitle: true,
        ),
      body: Expanded(
        child: BlocBuilder<TodoBloc,TodoState>(
          builder: (context, todoState){
            if(todoState is TodoLoading){
              return const CircularProgressIndicator();
            }else if(todoState is TodoLoaded){
              if(todoState.todos.isEmpty){
                return const Text('no todos yet');
              }else{
                return ListView.builder(
                  itemCount: todoState.todos.length,
                  itemBuilder:(BuildContext ctx, index ){
                    final todo = todoState.todos[index];

                return buildTodo(context, todo);
                });
              }
            }else if(todoState is TodoError){
              return Text(todoState.errorMessage);
            }else{
              return const SizedBox();
            }
          }

        ) 
        ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => TodoDialog(
              onClickedDone: addTodo,
            ),
          ),
        ),
    );
    
  }
  Widget buildTodo(
    BuildContext context,
    Todo todo,
  ) {
    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          todo.title,
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(todo.description),
        children: [
          buildButtons(context, todo),
        ],
      ),
    );
  }
  Widget buildButtons(BuildContext context, Todo todo) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: const Text('Edit'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TodoDialog(
                    todo: todo,
                    onClickedDone: (desc,title,date,assigned) =>
                        editTodo(todo, desc,title),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: const Text('Delete'),
              icon: const Icon(Icons.delete),
              onPressed: () => deleteTodo(todo),
            ),
          )
        ],
      );
      Future addTodo(String description, String title, String date, String assign) async { 
        final todo = Todo(title: title, description: description, date: date, assignedTo: assign);
        sl<TodoBloc>().add(AddTodo(todo));
  }

  void editTodo(
    Todo todo,
    String description,
    String title,
  ) {
    sl<TodoBloc>().add(UpdateTodo(todo, description, title));
  }

  void deleteTodo(Todo todo) {
    sl<TodoBloc>().add(RemoveTodo(todo));
  }
}