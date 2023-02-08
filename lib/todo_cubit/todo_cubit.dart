import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do/todo_cubit/todo_states.dart';
import 'package:to_do/todo_screens/archieved_tasks.dart';
import 'package:to_do/todo_screens/done_tasks.dart';
import 'package:to_do/todo_screens/new_tasks.dart';

import '../variables/variables.dart';

class TodoCubit extends Cubit<TodoStates>{
  TodoCubit() : super(TodoInitialState());
  static TodoCubit get(context) => BlocProvider.of(context);

  int current_index = 0 ;
  ChangeScreen (index){
    current_index = index ;
    emit(ChangeScreenState());
  }

  List<Widget> screens = [
    NewTasks(),
    DoneTasks(),
    ArchievedTasks(),
  ] ;
  List<Widget> titles = [
    Text(
      'New Tasks',
    ),
    Text(
      'Done Tasks',
    ),
    Text(
      'Archieved Tasks',
    ),
  ];
  bool is_bottom_sheet_shown = false ;
  BottomSheet(){
    is_bottom_sheet_shown = !is_bottom_sheet_shown ;
    emit(ChangeBottomSheet());
  }

late Database database ;
  CreateDatabase() async{
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database , version){
        print('Database is created');
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT )')
            .then((value){
          print('Table is created');
          emit(CreateDatabaseSuccessfully());
        }).catchError((error){
          emit(CreateDatabaseError());
        });
      },
      onOpen: (database){
        GetData(database);
        print('Database is open');
      }
    );
  }

  Future InsertToDatabase({
    required String title,
    required String time ,
    required String date ,
})async{
    return await  database.transaction((txn) {
      return txn.rawInsert('INSERT INTO tasks( title , date , time , status ) VALUES ( "$title" , "$date" , "$time" , "new" )')
          .then((value) {
            print('$value inserted');
            emit(DataInsertedSuccessfully());
      })
          .catchError((error){
            emit(DataInsertedError());
      });
    });
  }


  GetData(Database database){
    new_tasks = [];
    done_tasks = [];
    archieved_tasks = [];
    database.rawQuery('SELECT * FROM tasks')
        .then((value){
          print(value);
         value.forEach((element) {
           if(element['status'] == 'new'){
             new_tasks.add(element);
           }
           if(element['status'] == 'done'){
             done_tasks.add(element);
           }
           if(element['status'] == 'archieved'){
             archieved_tasks.add(element);
           }
         });
         emit(GetDataSuccessfully());
    })
        .catchError((error){
          emit( GetDataError());
    });
  }

 Future Update({
    required String status ,
    required int id ,
}){
   return database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ? ' , ['$status' , id])
        .then((value){
          emit(UpdateDataSuccessfully());
    })
        .catchError((error){
          emit(UpdateDataError());
    });
  }

  Future Delete({
    required int id ,
}){
    return database.rawDelete('DELETE FROM tasks WHERE id = ? ' , [id])
        .then((value){
          emit(DeleteDataSuccessfully());
    })
        .catchError((error){
          emit(DeleteDataError());
    });
  }
}