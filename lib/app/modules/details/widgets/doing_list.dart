

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/app/core/utils/extensions.dart';
import 'package:todo_getx/app/modules/home/controller.dart';


class DoingList extends StatelessWidget {
   DoingList({Key? key}) : super(key: key);

  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return  homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty ?
      Column(
        children: [
          Image(
              image: AssetImage('assets/images/empty.png')),
          Text('Add Task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0.responsiveFont
          ),
          ),
        ],
      ) : ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          ...homeCtrl.doingTodos.map((element) =>
          Padding(
            padding: EdgeInsets.symmetric(
             vertical: 3.0.responsiveWeight,
              horizontal: 9.0.responsiveWeight
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    fillColor: const MaterialStatePropertyAll(Colors.grey),
                      value: element['done'],
                      onChanged: (value){
                        homeCtrl.doneTodo(element['title']);
                        homeCtrl.updateTodo();
                      }),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 4.0.responsiveWeight),
                  child: Text(element['title'],
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          )
          ).toList(),
          if(homeCtrl.doingTodos.isNotEmpty) Padding(
            padding:  EdgeInsets.symmetric(horizontal: 2.0.responsiveWeight),
            child: const Divider(thickness: 2,),
          )
        ],
      );
    }

    );
  }
}
