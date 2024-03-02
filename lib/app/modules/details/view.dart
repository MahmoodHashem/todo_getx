

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_getx/app/core/utils/extensions.dart';

import '../home/controller.dart';

class DetailPage extends StatelessWidget {
  
  final homeCtrl = Get.find<HomeController>(); 
  
   DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.selectedTask.value; 
    var color = HexColor.fromHex(task!.color); 
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding:  EdgeInsets.all(3.0.responsiveWeight),
            child: Row(
              children: [
                IconButton(
                    onPressed: (){
                      Get.back();
                      homeCtrl.changeSelectedTask(null);
                    },
                    icon: Icon(Icons.arrow_back), 
                style: ButtonStyle(
                  overlayColor: MaterialStatePropertyAll(Colors.transparent),
                ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.responsiveWeight),
            child: Row(
              children: [
                Icon(IconData(task.icon, fontFamily: 'MaterialIcons'), color: color,),
                SizedBox(
                  width: 20,
                ),
                Text(task.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0.responsiveFont,
                )
                ),
              ],
            ),
          ),
          Obx( (){
            var totalTodos = homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
            return Padding(
              padding: EdgeInsets.only(
                left: 16.0.responsiveWeight,
                top: 3.0.responsiveWeight,
                right: 16.0.responsiveWeight,
                bottom: 3.0.responsiveWeight,
              ),
              child: Row(
                children: [
                  Text('$totalTodos Tasks'),
                  SizedBox(
                    width: 3.0.responsiveWeight
                  ),
                  Expanded(
                    child: StepProgressIndicator(
                      stepMainAxisAlignment: MainAxisAlignment.start,
                        padding: 0,
                        totalSteps: totalTodos == 0 ? 1 : totalTodos,
                        currentStep: homeCtrl.doneTodos.length,
                        size: 5,
                        selectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [color.withOpacity(0.5), color]),
                            unselectedGradientColor: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.grey[200]!, Colors.grey[200]!]),
                    ),
                  ),
                ],
              ),
            );
          }
          )
        ],
      )
    );
  }
}
