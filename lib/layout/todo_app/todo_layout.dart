import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_flutter/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy_flutter/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:udemy_flutter/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {
        if (state is AppInsertDatabaseState) {
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: cubit.title[cubit.currentIndex],
          ),
          body: state is AppGetDatabaseLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : cubit.screen[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.isBottumSheetShown) {
                //if (formKey.currentState!.validate()) {
                cubit.insertToDatabase(
                  title: titleController.text,
                  time: timeController.text,
                  date: dateController.text,
                );
                // }
              } else {
                cubit.changeBottomSheetState(isShow: true);

                scaffoldKey.currentState!
                    .showBottomSheet(
                      (context) => Container(
                        color: Colors.grey[100],
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                controller: titleController,
                                type: TextInputType.text,
                                onTap: () {},
                                // validate: () {
                                //   if (titleController.text.isEmpty) {
                                //     return 'Title must not be empty';
                                //   }
                                //   return null;
                                // },
                                text: 'Task title',
                                prefix: Icons.title,
                              ),
                              const SizedBox(height: 20),
                              /////////////////////// 2nd  /////////////
                              defaultFormField(
                                controller: timeController,
                                type: TextInputType.datetime,
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeController.text =
                                        value!.format(context);
                                  });
                                },
                                // validate: () {
                                //   if (timeController.text.isEmpty) {
                                //     return 'time must not be empty';
                                //   }
                                //   return null;
                                // },
                                text: 'Task time',
                                prefix: Icons.watch_later_outlined,
                              ),

                              ////////////////////////////////
                              const SizedBox(height: 20),
                              defaultFormField(
                                controller: dateController,
                                type: TextInputType.datetime,
                                isClickable: true,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2025-05-03'),
                                  ).then((value) {
                                    dateController.text =
                                        DateFormat.yMMMd().format(value!);
                                  });
                                },
                                text: 'Date time',
                                prefix: Icons.watch_later_outlined,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .closed
                    .then((value) {
                  cubit.changeBottomSheetState(isShow: false);
                });
              }
            },
            child: Icon(!cubit.isBottumSheetShown ? Icons.add : Icons.edit),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check),
                label: 'Done',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.archive),
                label: 'Archives',
              ),
            ],
          ),
        );
      }),
    );
  }
}
