import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/shop_app/shop_layout.dart';
import 'package:udemy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:udemy_flutter/shared/bloc_observer.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/local/cash_helper.dart';
import 'package:udemy_flutter/shared/network/remot/dio_helper.dart';
import 'package:udemy_flutter/shared/components/styles/themes.dart';

import 'layout/news_app/cubit/cubti.dart';
import 'layout/shop_app/cubit/cubit.dart';

void main() async {
  //  make sure that every thing in the main finieshd then go to runapp
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  bool? isDark = CashHelper.getData(key: 'isDark');
  token = CashHelper.getData(key: 'token');
  bool onBoarding = CashHelper.getData(key: 'onBoarding');
  Widget widget;

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(isDark, widget));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  Widget startWidget;

  MyApp(
    this.isDark,
    this.startWidget,
  );
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
        BlocProvider<ShopCubit>(
          create: (BuildContext context) => ShopCubit()..getHomeData(),
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
            home: startWidget,
          );
        },
      ),
    );
  }
}
