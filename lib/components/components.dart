import 'package:flutter/material.dart';
import 'package:todo/todo_cubit/todo_cubit.dart';

Widget BuildTaskItem (Map task,context){
  return Dismissible(
    key: Key('mahmoud'),
    onDismissed: (direction){
      TodoCubit.get(context).Delete(id: task['id']).then((value){
        TodoCubit.get(context).GetData(TodoCubit.get(context).database);
      });
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text(
              '${task['time']}',
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${task["title"]}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  '${task['date']}',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30.0,
          ),
          if(task['status'] == 'new' )
          Row(
            children: [
              IconButton(
                onPressed: (){
                  TodoCubit.get(context).Update(status: "done", id: task['id']).then((value){
                    TodoCubit.get(context).GetData(TodoCubit.get(context).database);
                  });
                },
                icon: Icon(
                  Icons.check_box_outlined,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              IconButton(
                onPressed: (){
                  TodoCubit.get(context).Update(status: 'archieved', id: task['id']).then((value){
                    TodoCubit.get(context).GetData(TodoCubit.get(context).database);
                  });
                },
                icon: Icon(
                  Icons.archive_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}