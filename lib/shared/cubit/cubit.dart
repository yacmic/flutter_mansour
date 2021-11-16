import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy_flutter/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:udemy_flutter/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInittialState());

  // to be more easy to caal oobject
  static AppCubit get(context) => BlocProvider.of(context);

  var currentIndex = 0;
  bool isBottumSheetShown = false;

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  List<Widget> screen = const [
    NewTasks(),
    DoneTasks(),
    ArchivedTasks(),
  ];
  List<Text> title = const [
    Text('New tasks'),
    Text('Done tasks'),
    Text('Archived tasks'),
  ];
  late Database database;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() {
    openDatabase(
      'base.db',
      version: 1,
      onCreate: (Database database, int version) async {
        // When creating the db, create the table
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date Text, time TEXT, status TEXT)')
            .then((value) => print('table created'))
            .catchError(
              (onError) => print(onError),
            );
      },
      onOpen: (database) {
        getDataFromDatabase(database);
      },
    ).then(
      (value) {
        database = value;
        emit(AppCreateDatabaseState());
      },
    );
  }

  insertToDatabase({
    required title,
    required time,
    required date,
  }) async {
    await database.transaction((txn) async => {
          await txn
              .rawInsert(
                  'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$time","$date" ,"new")')
              .then((value) {
            emit(AppInsertDatabaseState());
            getDataFromDatabase(database).then(
              (value) => {
                //tasks = value,
                emit(AppGetDatabaseState()),
              },
            );
            print('$value inserted succefully');
          }).catchError((onError) => print('Error when inserted $onError')),
        });
  }

  void updateData({
    required String status,
    required id,
  }) async {
    database.rawUpdate('UPDATE tasks SET status = ?  WHERE id = ?',
        [status, id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
    print('updated');
  }

  void deleteData({
    required id,
  }) async {
    database.rawDelete('Delete From tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
    print('updated');
  }

  getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then(
      (value) {
        print(value);
        value.forEach((element) {
          if (element['status'] == 'new') {
            newTasks.add(element);
          } else if (element['status'] == 'Done') {
            doneTasks.add(element);
          } else {
            archivedTasks.add(element);
          }
        });
        print('new : $newTasks');
        print('done: $doneTasks');
      },
    );
    emit(AppGetDatabaseState());
  }

  void changeBottomSheetState({required bool isShow}) {
    isBottumSheetShown = isShow;

    emit(AppCHangeBottomSheetState());
  }
}
