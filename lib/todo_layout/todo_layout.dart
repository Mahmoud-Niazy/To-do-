import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do/reusable_components/reusable_components.dart';
import 'package:to_do/todo_cubit/todo_cubit.dart';
import 'package:to_do/todo_cubit/todo_states.dart';

class TodoLayout extends StatelessWidget{
  var scaffold_key = GlobalKey<ScaffoldState>();
  var form_key = GlobalKey<FormState>();
  var title_controller = TextEditingController();
  var time_controller = TextEditingController();
  var date_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
   return BlocConsumer<TodoCubit,TodoStates>(
     listener: (context,state){
       print(state);
     },
     builder: (context,state){
       return Scaffold(
         key: scaffold_key,
         appBar: AppBar(
           title: TodoCubit.get(context).titles[TodoCubit.get(context).current_index],
         ),
         bottomNavigationBar: BottomNavigationBar(
           items: [
             BottomNavigationBarItem(
                 icon: Icon(
                   Icons.menu,
                 ),
                 label: 'New tasks'
             ),
             BottomNavigationBarItem(
                 icon: Icon(
                   Icons.check_circle_outline,
                 ),
                 label: 'Done tasks'
             ),
             BottomNavigationBarItem(
                 icon: Icon(
                   Icons.archive_outlined,
                 ),
                 label: 'Archieved tasks'
             ),
           ],
           onTap: (index){
             TodoCubit.get(context).ChangeScreen(index);
           },
           currentIndex: TodoCubit.get(context).current_index,
         ),
         body: TodoCubit.get(context).screens[TodoCubit.get(context).current_index],
         floatingActionButton: FloatingActionButton(
           onPressed: (){
             if(TodoCubit.get(context).is_bottom_sheet_shown){
               if(form_key.currentState!.validate()){
                 TodoCubit.get(context).InsertToDatabase(title: title_controller.text, time: time_controller.text, date: date_controller.text).then((value) {
                   Navigator.pop(context);
                   title_controller.text = '' ;
                   time_controller.text = '' ;
                   date_controller.text = '' ;
                   TodoCubit.get(context).GetData(TodoCubit.get(context).GetData(TodoCubit.get(context).database));
                 });

               }
             }
             else{
               scaffold_key.currentState!.showBottomSheet((context) => Container(
                   child: Form(
                     key: form_key,
                     child: Column(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         BuildTextFormField(
                           controller: title_controller,
                           label: 'title',
                           prefix_icon: Icons.title,
                           validate: (value){
                             if(value!.isEmpty){
                               return 'title can\'t be empty ' ;
                             }
                           },
                         ),
                         SizedBox(
                           height: 15.0,
                         ),
                         BuildTextFormField(
                             controller: time_controller,
                             label: 'time',
                             prefix_icon: Icons.watch_later_outlined,
                             validate: (value){
                               if(value!.isEmpty){
                                 return 'time can\'t be empty ' ;
                               }
                             },
                             on_tap: (){
                               showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                                 time_controller.text = value!.format(context);
                               });
                             }
                         ),
                         SizedBox(
                           height: 15.0,
                         ),
                         BuildTextFormField(
                             controller: date_controller,
                             label: 'date',
                             prefix_icon: Icons.date_range,
                             validate: (value){
                               if(value!.isEmpty){
                                 return 'date can\'t be empty ' ;
                               }
                             },
                             on_tap: (){
                               showDatePicker(context: context,
                                 initialDate: DateTime.now(),
                                 firstDate: DateTime.now(),
                                 lastDate: DateTime.parse('2023-09-03'),
                               ).then((value){
                                 date_controller.text = DateFormat.yMMMMd().format(value!);
                               });
                             }
                         ),
                       ],
                     ),
                   ),
                 padding: EdgeInsets.all(20.0),
               ),).closed.then((value){
                 TodoCubit.get(context).BottomSheet();
               });
               TodoCubit.get(context).BottomSheet();
             }

           },
           child: Icon(
             TodoCubit.get(context).is_bottom_sheet_shown? Icons.add : Icons.edit ,
           ),
         ),
       ) ;
     },
   );
  }

}