import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo_getx/app/core/utils/extensions.dart';
import 'package:todo_getx/app/core/utils/values/color.dart';
import 'package:todo_getx/app/data/model/task.dart';
import 'package:todo_getx/app/modules/home/controller.dart';
import 'package:todo_getx/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons;
    final squareWidth = Get.width - 12.0.responsiveWieght;
    return Container(
      height: squareWidth / 2,
      width: squareWidth / 2,
      margin: EdgeInsets.all(3.0.responsiveWieght),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.responsiveWieght),
            radius: 5,
            title: 'Task key',
            content: Form(
                key: homeCtrl.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 3.0.responsiveWieght),
                      child: TextFormField(
                        controller: homeCtrl.editCtrl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelText: 'Title',
                        ),
                        validator: (value){
                          if(value == null || value.trim().isEmpty){
                            return 'please write the title';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        runSpacing: 5,
                        spacing: 10,
                        children: icons.map((e) => Obx((){
                          final index = icons.indexOf(e);
                          return ChoiceChip(
                            selectedColor: Colors.grey[200],
                              pressElevation: 0,
                              backgroundColor: Colors.white,
                              label:e,
                              selected: homeCtrl.choiceIndex.value == index,
                              onSelected: (value){
                                homeCtrl.choiceIndex.value = value ? index : 0;
                              },
                          );
                        })).toList(),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: Size(150, 40),
                        ),
                        onPressed: (){

                          if(homeCtrl.formKey.currentState!.validate()){
                            int icon = icons[homeCtrl.choiceIndex.value].icon!.codePoint;
                            String color = icons[homeCtrl.choiceIndex.value].color!.toHex();
                            var task = Task(
                                title: homeCtrl.editCtrl.value.text,
                                icon: icon,
                                color: color);
                            Get.back();
                            homeCtrl.addTask(task) ?
                            EasyLoading.showSuccess('Task Created successfuly') :
                            EasyLoading.showError('Task is Dupilacated');
                          }

                        },
                        child: Text('Confirm'))
                  ],
                ),),
          );
          homeCtrl.editCtrl.clear();
          homeCtrl.changeIndexOfChoice(0);

        },
        child: DottedBorder(
            color: Colors.grey[400]!,
            dashPattern: const [8,4],
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.grey,
                size: 10.0.responsiveWieght,
              ),
            )),
      ),
    );
  }
}
