
import 'package:flutter/material.dart';
import 'package:todo_getx/app/core/utils/extensions.dart';


void main(){

  var myColor = HexColor.fromHex('#ff21f396');

  String hex = myColor.toHex();

  print('this is hex $hex');

}