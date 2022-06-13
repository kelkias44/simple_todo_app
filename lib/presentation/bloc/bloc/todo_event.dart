part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable {}
class getTodo extends TodoEvent{
  @override
  List<Object?> get props => [];
}
class AddTodo extends TodoEvent{
  final Todo todo;

  AddTodo(this.todo);
  @override
  List<Object?> get props => [todo];
}
class RemoveTodo extends TodoEvent{
  final Todo todo;

  RemoveTodo(this.todo);
  @override
  List<Object?> get props => [todo];
}
class UpdateTodo extends TodoEvent{
  final Todo todo;
  final String title;
  final String description;


  UpdateTodo(this.todo, this.description, this.title);
  @override
  List<Object?> get props => [todo,description,title];
}
