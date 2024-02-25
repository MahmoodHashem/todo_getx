

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo_getx/app/data/service/storage/repository.dart';

import '../../data/model/task.dart';

class HomeController extends GetxController{

  TaskRepository taskRepository;

  HomeController({required this.taskRepository});


  final tasks = [].obs;
  final formKey = GlobalKey<FormState>();
  final editCtrl = TextEditingController();
  final choiceIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.read());
    ever(tasks, (callback) => taskRepository.write(tasks as List<Task>));

  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeIndexOfChoice(int value){
    choiceIndex.value = value;
  }

  bool addTask(Task task){
    if(tasks.contains(task)){
      return false;
    }
    tasks.add(task);
    return true;
  }

}