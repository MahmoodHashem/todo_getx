
import 'package:equatable/equatable.dart';

class Task extends Equatable{

  String title;
  int icon;
  String color;
  List<dynamic>? todos;

  Task({required this.title, required this.icon, required this.color, this.todos});


  Task copyWith({String?  title, int? icon, String? color, List<dynamic>? todos}){
    return Task(
        title: title ?? this.title,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        todos: todos ?? this.todos);
  }

  factory Task.fromJson(Map<String, dynamic> json){
    return Task(
        title: json['title'],
        icon: json['icon'],
        color: json['color'],
        todos: json['todos'],
      );
  }

  Map<String, dynamic> toJson(){
    return {
      'title': title,
      'icon': icon,
      'color': color,
      'todos': todos,
  };
}

@override
  // TODO: implement props
  List<Object?> get props => [title, icon, color];

}