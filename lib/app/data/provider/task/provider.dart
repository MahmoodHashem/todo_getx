
import 'dart:convert';

import 'package:get/get.dart';
import 'package:todo_getx/app/core/utils/keys.dart';
import 'package:todo_getx/app/data/service/storage/service.dart';
import 'package:todo_getx/app/data/model/task.dart';

class TaskProvider{

  final _storage = Get.find<StorageService>();

  void writeTask(List<Task> tasks){
    _storage.write(taskKey, jsonEncode(tasks));
  }

  List<Task> readTask(){

    var tasks = <Task>[];

    List x = jsonDecode(_storage.read(taskKey).toString());

    for (var element in x) {tasks.add(Task.fromJson(element));}
    
    return tasks;


  }



}