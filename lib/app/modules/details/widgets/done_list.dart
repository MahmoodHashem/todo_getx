


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/app/core/utils/extensions.dart';
import 'package:todo_getx/app/modules/home/controller.dart';


class DoneList extends StatelessWidget {
   DoneList({Key? key}) : super(key: key);

  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doneTodos.isNotEmpty ?
        ListView(
          shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.0.responsiveWeight,
                ),
                child: Text("Completed(${homeCtrl.doneTodos.length})",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0.responsiveFont,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...homeCtrl.doneTodos.map((element) =>
              Dismissible(
                key: ObjectKey(element),
                background: Container(
                  color: Colors.red.withOpacity(0.6),
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.delete, color: Colors.white,),
                ),
                direction: DismissDirection.startToEnd,
                onDismissed: (_){
                  homeCtrl.deleteDoneTodo(element['title']);
                },
                child: Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: 9.0.responsiveWeight,
                    // vertical: 3.0.responsiveWeight
                  ),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        homeCtrl.unDoneTodo(element['title']);
                        homeCtrl.updateTodo();
                      }, icon: const Icon(Icons.check_box, color: Colors.blue)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.0.responsiveWeight,
                        ),
                        child: Text(element['title'],
                          style: const TextStyle(
                            decoration: TextDecoration.lineThrough
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
              ).toList()
            ],
        ) : Container()
    );
  }
}


