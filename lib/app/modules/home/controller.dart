

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_getx/app/data/service/storage/repository.dart';

import '../../data/model/task.dart';

class HomeController extends GetxController{

  TaskRepository taskRepository;

  HomeController({required this.taskRepository});


  List<Task> tasks = <Task>[].obs;
  final formKey = GlobalKey<FormState>();
  final editCtrl = TextEditingController();
  final deleting = false.obs;
  final choiceIndex = 0.obs;
  final selectedTask = Rx<Task?>(null);

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.read());
    ever(tasks as RxInterface<Object?>, (callback) => taskRepository.write(tasks));

  }

  @override
  void onClose() {
    editCtrl.dispose();
    super.onClose();
  }

  void changeIndexOfChoice(int value){
    choiceIndex.value = value;
  }

  void changeDeleting(bool value){
    deleting.value = value;
  }

  bool addTask(Task task){
    if(tasks.contains(task)){
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task){
    tasks.remove(task);
  }

  void changeSelectedTask(Task? newSelected){
    selectedTask.value = newSelected;
  }

  bool updateTask(Task? task, String title) {

    var todos = task!.todos ?? [];
    if(containTodo(todos, title)){
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);

    var newTask = task.copyWith(todos: todos);

    int oldIndex = tasks.indexOf(task);

    tasks[oldIndex] = newTask;
    return true;

  }

  bool containTodo(List todo, String title) {
    return todo.any((element) => element['title'] == title);
  }

}