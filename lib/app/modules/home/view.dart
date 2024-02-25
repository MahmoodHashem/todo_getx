
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/app/core/utils/extensions.dart';
import 'package:todo_getx/app/data/service/storage/service.dart';
import 'package:todo_getx/app/modules/home/controller.dart';
import 'package:todo_getx/app/core/utils/extensions.dart';
import 'package:todo_getx/app/modules/home/widgets/add_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding:  EdgeInsets.all(4.0.responsiveWieght),
                child: Text('My List',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0.responsiveFont,
                ),
                ),
              ),

              GridView.count(
                shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  crossAxisCount: 2,
                children: [
                  AddCard()
                ],
              )

            ],
      ))
    );
  }
}
