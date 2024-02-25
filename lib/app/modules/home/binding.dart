import 'package:get/get.dart';
import 'package:todo_getx/app/data/provider/task/provider.dart';
import 'package:todo_getx/app/data/service/storage/repository.dart';
import 'package:todo_getx/app/modules/home/controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(taskProvider: TaskProvider(),),
      ),
    );
  }
}
