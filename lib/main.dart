import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_getx/app/modules/home/binding.dart';
import 'package:todo_getx/app/modules/home/view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/data/service/storage/service.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Getx Todo',
      initialBinding: HomeBinding(),
      home: HomePage(),
      builder: EasyLoading.init(),
    );
  }
}