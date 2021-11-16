import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:udemy_flutter/shared/bloc_observer.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/local/cash_helper.dart';
import 'package:udemy_flutter/shared/network/remot/dio_helper.dart';
import 'package:udemy_flutter/shared/components/styles/themes.dart';

import 'layout/news_app/cubit/cubti.dart';

void main() async {
  //  make sure that every thing in the main finieshd then go to runapp
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  bool? isDark = CashHelper.getBloolean(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    // bool isDark = NewsCubit.get(context).isDark;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(
          create: (BuildContext context) =>
              AppCubit()..dark(fromShared: isDark),
        ),
        BlocProvider<NewsCubit>(
          create: (BuildContext context) => NewsCubit()
            ..getBusiness()
            ..getScience()
            ..getSport(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
