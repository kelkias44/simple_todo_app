import 'package:dio/dio.dart';
import 'package:simple_todo/constants/constant.dart';

import '../model/todo_model.dart';

class TodoService{
Dio dio = Dio(BaseOptions(
  connectTimeout: 5000000,
  receiveTimeout: 5000000,
  headers: {
    "Content-Type": "application/json",
  },
));
  Future getTodos()async{
    Response? response;
    response = await dio.get('$baseUrl/api/v1/tasks/');
    return response;
  }
  Future deleteTodo(Todo todo) async {
    await dio.delete('$baseUrl/api/v1/tasks/${todo.id}');
  }
  Future updateTodo(Todo todo,String description,String title)async{
    await dio.put('$baseUrl/api/v1/tasks/${todo.id}', data: Todo(description: description,title: title,date: DateTime.now().toIso8601String(),assignedTo: '622de5fed3f42ebf99d1b5de'));
  }
  Future addTodo(Todo todo)async{
    await dio.post('$baseUrl/api/v1/tasks', data: todo);
  }
  
}