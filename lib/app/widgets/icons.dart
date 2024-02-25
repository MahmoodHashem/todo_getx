
import 'package:flutter/material.dart';
import 'package:todo_getx/app/core/utils/values/color.dart';
import 'package:todo_getx/app/core/utils/values/icons.dart';


List<Icon> get getIcons =>  const [
      Icon(IconData(personIcon, fontFamily: 'MaterialIcons'),color: pink),
      Icon(IconData(workIcon, fontFamily: 'MaterialIcons'), color: purple),
      Icon(IconData(movieIcon, fontFamily: 'MaterialIcons'), color: green),
      Icon(IconData(sportIcon, fontFamily: 'MaterialIcons'), color: yellow),
      Icon(IconData(travelIcon, fontFamily: 'MaterialIcons'), color: deepPink),
      Icon(IconData(shopIcon, fontFamily: 'MaterialIcons'), color:lightBlue),

];

