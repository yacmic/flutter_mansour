import 'package:udemy_flutter/shared/cubit/cubit.dart';

abstract class AppStates {}

class AppInittialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class AppCreateDatabaseState extends AppStates {}

class AppGetDatabaseLoadingState extends AppStates {}

class AppGetDatabaseState extends AppStates {}

class AppInsertDatabaseState extends AppStates {}

class AppUpdateDatabaseState extends AppStates {}

class AppDeleteDatabaseState extends AppStates {}

class AppCHangeBottomSheetState extends AppStates {}

class AppSharedPreferncesState extends AppStates {}

class AppDarkThemeState extends AppStates {}
