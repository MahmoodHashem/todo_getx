

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/app/core/utils/extensions.dart';
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
              padding: EdgeInsets.all(3.0.responsiveWieght),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){
                    Get.back();
                  }, icon: Icon(Icons.close)),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    ),

                      onPressed: (){

                  }, child: Text("Done",style: TextStyle(fontSize: 14.0.responsiveFont), ))
                ],
              ),
            ),
              Padding(
                padding:  EdgeInsets.all(3.0.responsiveWieght),
                child: Text("New Task",
                  style:TextStyle(
                    fontSize: 14.0.responsiveFont,
                    fontWeight: FontWeight.bold,
                  ) ,),
              ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0.responsiveWieght),
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
                top: 5.0.responsiveWieght,
                left: 5.0.responsiveWieght,
                right: 5.0.responsiveWieght,
                bottom: 2.0.responsiveWieght,
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
                  padding:  EdgeInsets.symmetric(horizontal: 5.0.responsiveWieght, vertical: 3.0.responsiveWieght),
                  child: Row(
                    children: [
                      Icon(IconData(e.icon, fontFamily: 'MaterialIcons'), color: HexColor.fromHex(e.color)),
                      SizedBox(width: 3.0.responsiveWieght,),
                      Text(e.title),
                      if(homeCtrl.selectedTask.value == e) Icon(Icons.check)

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
