

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  final tabIndex = 0.obs;
  final selectedTask = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

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

  void changeTabIndex(int index){
    tabIndex.value = index;
  }

  void changeIndexOfChoice(int value){
    choiceIndex.value = value;
  }

  void changeDeleting(bool value){
    deleting.value = value;
  }

  void changeTodosStatus(List<dynamic> selected){
    doingTodos.clear();
    doneTodos.clear();

    for(int i = 0; i < selected.length; i++){
      var todo = selected[i];
      var status = todo['done'];

      if(status == true){
        doneTodos.add(todo);
      }else{
        doingTodos.add(todo);
      }

    }


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

  bool addTodo(String title) {

    var todo = <String, dynamic>{'title':title, 'done': false};
    print('before conditions');
    if(doingTodos.any((element) => mapEquals(todo, element))){
      print('doing condition');
      return false;
    }
    var doneTodo = <String, dynamic>{'title': title, 'done': true};
    if(doneTodos.any((element) => mapEquals(doneTodo, element))){
      print('done condition');
      return false;
    }
    print('after conditions');
    doingTodos.add(todo);
    return true;
  }

  void updateTodo(){

    var newTodos = <Map<String, dynamic>>[];

    newTodos.addAll([
      ...doingTodos,
      ...doneTodos]
    );

    var newTask = selectedTask.value!.copyWith(todos: newTodos);
    int oldIndex = tasks.indexOf(selectedTask.value!);
    tasks[oldIndex] = newTask;
  }

  void doneTodo(String title){

    var doingTodo = <String, dynamic>{'title': title, 'done': false};
    int index = doingTodos.indexWhere((element) => mapEquals(doingTodo, element));
    doingTodos.removeAt(index);
    var doneTodo = <String, dynamic>{'title': title, 'done': true};
    doneTodos.add(doneTodo);

  }

  void unDoneTodo(String title){

    var doneTodo = <String, dynamic>{'title': title, 'done': true};

    int index = doneTodos.indexWhere((element) => mapEquals(doneTodo, element));
    doneTodos.removeAt(index);
    var doingTodo = <String, dynamic>{'title': title, 'done': false};
    doingTodos.add(doingTodo);


  }

  void deleteDoneTodo(String title) {

    var doneTodo = <String, dynamic>{'title': title, 'done': true};

    int index = doneTodos.indexWhere((element) => mapEquals(element, doneTodo));

    doneTodos.removeAt(index);
  }


  bool isTaskTodosEmpty(Task task){
    return task.todos == null || task.todos!.isEmpty;
  }


  int getDoneTodos(Task task){
    int result = 0;

    for(int i = 0; i < task.todos!.length; i++){
      if(task.todos![i]['done'] == true){
        result += 1;
      }
    }
    return result;
  }

  int getTotalTasks(){
    int result = 0;

    for(int i = 0; i < tasks.length; i++){
      if(tasks[i].todos !=  null){
        result += tasks[i].todos!.length;
      }
    }
      return result;
  }

  int getTotalDoneTask(){
    int result = 0;

    for(int i = 0; i < tasks.length; i++){
      if(tasks[i].todos != null){
        for(int j = 0; j < tasks[i].todos!.length; j++){
          if(tasks[i].todos![j]['done'] == true){
            result += 1;
          }
        }
      }
    }
    return result;
  }

}