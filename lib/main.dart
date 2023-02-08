import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/todo_cubit/todo_cubit.dart';
import 'package:to_do/todo_layout/todo_layout.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MultiBlocProvider(
     providers: [
       BlocProvider(create: (context)=> TodoCubit()..CreateDatabase()),
     ],
     child: MaterialApp(
       home: TodoLayout(),
     ),
   );
  }

}