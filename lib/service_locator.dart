import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_todo/data/service/todo_service.dart';
import 'package:simple_todo/domain/repository/todo_repository.dart';
import 'package:simple_todo/presentation/bloc/bloc/todo_bloc.dart';

import 'data/repository/todo_repository_impl.dart';

final sl = GetIt.instance;

Future initServiceLocator()async{
  sl.registerSingleton<Dio>(Dio());

  sl.registerFactory<TodoBloc>((() => TodoBloc(sl())));
  sl.registerSingleton<TodoRepository>(TodoRepositoryImpl());
  sl.registerSingleton<TodoService>((TodoService()));
}