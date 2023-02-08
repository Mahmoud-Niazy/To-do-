import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/todo_cubit/todo_states.dart';

import '../components/components.dart';
import '../todo_cubit/todo_cubit.dart';
import '../variables/variables.dart';

class ArchievedTasks extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition: archieved_tasks.length > 0,
          builder: (context) => ListView.separated(
            itemBuilder: (context,index)=> BuildTaskItem(archieved_tasks[index],context),
            separatorBuilder: (context,index) => Container(
              height: 1.0,
              color: Colors.grey[300],
            ),
            itemCount: archieved_tasks.length,
          ),
          fallback: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.menu,
                  size: 200.0,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'There are no tasks ',
                  style: TextStyle(
                    fontSize:35.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        )  ;
      },
    );
  }

}
