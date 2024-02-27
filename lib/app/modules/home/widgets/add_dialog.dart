

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_getx/app/core/utils/extensions.dart';
import 'package:todo_getx/app/core/utils/values/color.dart';
import 'package:todo_getx/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  
  final homeCtrl = Get.find<HomeController>(); 
  
  
 AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homeCtrl.formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.responsiveWeight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Get.back();
                    homeCtrl.editCtrl.clear();
                    homeCtrl.changeSelectedTask(null);
                  }, icon: Icon(Icons.close)),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    ),

                      onPressed: (){
                      if(homeCtrl.formKey.currentState!.validate()) {
                        if (homeCtrl.selectedTask.value == null) {
                          EasyLoading.showError('Please select the Section');
                        } else {
                          var success = homeCtrl.updateTask(
                            homeCtrl.selectedTask.value,
                            homeCtrl.editCtrl.text,
                          );
                          if(success){
                            EasyLoading.showSuccess('Added Successfuly');
                            Get.back();
                            homeCtrl.changeSelectedTask(null);
                            homeCtrl.editCtrl.clear();
                          }else{
                            EasyLoading.showError('Task is already exist');
                          }
                        }
                      }
                  },
                      child: Text("Done",style: TextStyle(fontSize: 14.0.responsiveFont), ))
                ],
              ),
            ),
              Padding(
                padding:  EdgeInsets.all(3.0.responsiveWeight),
                child: Text("New Task",
                  style:TextStyle(
                    fontSize: 14.0.responsiveFont,
                    fontWeight: FontWeight.bold,
                  ) ,),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0.responsiveWeight),
              child: TextFormField(
                controller: homeCtrl.editCtrl,
                autofocus: true,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  )
                ),
                validator: (value){
                  if(value == null || value.trim().isEmpty){
                    return 'Please Enter you Todo';
                  }
                  return null; 
                },
              ),
            ), 
            Padding(
              padding:  EdgeInsets.only(
                top: 5.0.responsiveWeight,
                left: 5.0.responsiveWeight,
                right: 5.0.responsiveWeight,
                bottom: 2.0.responsiveWeight,
              ),
              child: Text('Add to ',
              style: TextStyle(
                color: Colors.grey[400]!
              ),
              ),
            ),
            
            ...homeCtrl.tasks.map((e) => Obx( ()=> GestureDetector(
                onTap: (){
                  homeCtrl.changeSelectedTask(e);
                },
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.0.responsiveWeight, vertical: 3.0.responsiveWeight),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(IconData(e.icon, fontFamily: 'MaterialIcons'), color: HexColor.fromHex(e.color)),
                          SizedBox(width: 3.0.responsiveWeight,),
                          Text(e.title),
                        ],
                      ),
                      if(homeCtrl.selectedTask.value == e) Icon(Icons.check, color: blue)
                    ],
                  ),
                ),
              ),
            ))

          ],
        ),
      ),
    );
  }
}
