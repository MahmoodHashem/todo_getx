
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:todo_getx/app/core/utils/extensions.dart';
import 'package:todo_getx/app/data/service/storage/service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () async {
              StorageService s = StorageService();

              print('saved');
            }, child: Text("Save")),
            ElevatedButton(onPressed: (){


            }, child: Text("Get"))
          ],
        )
      ),
    );
  }
}
