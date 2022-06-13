import 'package:simple_todo/data/model/todo_model.dart';

abstract class TodoRepository{
  Future<Todo> getTodos();
  Future updateTodo(Todo todo, String description, String title);
  Future deleteTodo(Todo todo);
  Future addTodo(Todo todo);
}