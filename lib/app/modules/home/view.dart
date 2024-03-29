
//import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_getx/app/core/utils/extensions.dart';
import 'package:todo_getx/app/core/utils/values/color.dart';
import 'package:todo_getx/app/data/service/storage/service.dart';
import 'package:todo_getx/app/modules/home/controller.dart';
import 'package:todo_getx/app/core/utils/extensions.dart';
import 'package:todo_getx/app/modules/home/widgets/add_card.dart';
import 'package:todo_getx/app/modules/home/widgets/add_dialog.dart';
import 'package:todo_getx/app/modules/home/widgets/task_card.dart';
import 'package:todo_getx/app/modules/reports/report_view.dart';

import '../../data/model/task.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx( ()=> IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding:  EdgeInsets.all(4.0.responsiveWeight),
                    child: Text('My List',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0.responsiveFont,
                    ),
                    ),
                  ),
                  Obx(()=> GridView.count(
                      shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        crossAxisCount: 2,
                      children: [
                        ...controller.tasks.map((element) => LongPressDraggable(
                          data: element,
                          onDragStarted: ()=> controller.changeDeleting(true),
                          onDraggableCanceled: (_, offset)=> controller.changeDeleting(false),
                          onDragEnd: (_)=> controller.changeDeleting(false),
                          feedback: Opacity(
                            opacity: 0.5,
                            child: TaskCard(task: element),
                          ),
                            child: TaskCard(task: element))).toList(),
                        AddCard()
                      ],
                    ),
                  )
                ],
          ),
          ),
          ReportPage()
          ]
        ),
      ),
      floatingActionButton:  DragTarget(
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Deleted');

        },
        builder: (_, __, ___){
          return Obx( ()=> FloatingActionButton(
            elevation: 6,
            backgroundColor: controller.deleting.value ? Colors.red: blue,
            onPressed: (){
              if(controller.tasks.isNotEmpty){
                Get.to(AddDialog(), transition: Transition.downToUp);
              }else{
                EasyLoading.showInfo('Please Create at least one Tas');
              }

            },
            child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
          ),);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: Obx(()=> BottomNavigationBar(
          onTap: (index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon:Icon(Icons.apps),
                label: 'Report'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.data_usage),
                label: 'Data'
              )

            ]),
      ),

      );
  }
}
