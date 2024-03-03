

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo_getx/app/core/utils/extensions.dart';
import 'package:todo_getx/app/modules/details/widgets/doing_list.dart';
import 'package:todo_getx/app/modules/details/widgets/done_list.dart';

import '../home/controller.dart';

class DetailPage extends StatelessWidget {
  
  final homeCtrl = Get.find<HomeController>(); 
  
   DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.selectedTask.value; 
    var color = HexColor.fromHex(task!.color); 
    return Scaffold(
      body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding:  EdgeInsets.all(3.0.responsiveWeight),
              child: Row(
                children: [
                  IconButton(
                      onPressed: (){
                        Get.back();
                        homeCtrl.updateTodo();
                        homeCtrl.changeSelectedTask(null);
                        homeCtrl.editCtrl.clear();
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
            ),
            Padding(
              padding:EdgeInsets.symmetric(
                horizontal: 2.0.responsiveWeight,
                vertical: 5.0.responsiveHeight,
              ),
              child: TextFormField(
                controller: homeCtrl.editCtrl,
                autofocus: true,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[400]!
                    ),
                  ),
                  prefixIcon: Icon(Icons.check_box_outline_blank, color: Colors.grey[400]),
                  suffixIcon: IconButton(
                      onPressed: (){
                          if(homeCtrl.formKey.currentState!.validate()){
                            var success = homeCtrl.addTodo(homeCtrl.editCtrl.text);
                            if(success){
                              EasyLoading.showSuccess('Task Added Successfully ');
                              homeCtrl.updateTodo();
                            }else{
                              EasyLoading.showError('Duplicated');
                            }
                            homeCtrl.editCtrl.clear();
                          }

                      },
                      icon: Icon(Icons.done))
                ),
                validator: (value){
                  if(value == null ||value.trim().isEmpty){
                    return 'Please Enter you todo ';
                  }
                  return null;
                },
              ),
            ),
            DoingList(),
            DoneList(),
          ],
        ),
      )
    );
  }
}
