

import 'package:todo_getx/app/data/provider/task/provider.dart';

import '../../model/task.dart';

class TaskRepository{

  TaskProvider taskProvider;

  TaskRepository({required this.taskProvider});

  List<Task> read() => taskProvider.readTask();

  void write(List<Task> tasks) => taskProvider.writeTask(tasks);


}