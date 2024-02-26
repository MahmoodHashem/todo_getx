

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

}