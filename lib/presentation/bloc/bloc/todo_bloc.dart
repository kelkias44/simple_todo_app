import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_todo/data/model/todo_model.dart';
import 'package:equatable/equatable.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<TodoEvent>((event, emit) {
    });
  }
}
