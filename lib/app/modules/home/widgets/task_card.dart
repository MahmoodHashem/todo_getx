

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_getx/app/core/utils/extensions.dart';

import '../../../data/model/task.dart';
import '../controller.dart';
class TaskCard extends StatelessWidget {

  final homeCtrl = Get.find<HomeController>();

  Task task;
  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    final squareWidth = Get.width - 12.0.responsiveWieght;
    return Container(
        width: squareWidth / 2 ,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.responsiveWieght),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 7,
            offset: Offset(0, 7),
          )
        ],
          color: Colors.white
      ),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepProgressIndicator(
              totalSteps: 100,
            currentStep: 80,
            size: 5,
              padding: 0,
            selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color.withOpacity(0.5), color]),
            unselectedGradientColor:LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.white]),
          ),
          Padding(
            padding: EdgeInsets.all(6.0.responsiveWieght),
            child: Icon(IconData(task.icon, fontFamily: 'MaterialIcons'), color: color,),
          ), 
          Padding(
            padding:  EdgeInsets.all(6.0.responsiveWieght),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0.responsiveFont
                ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text('${task.todos?.length ?? 0} tasks',
                overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
