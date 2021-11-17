import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/layout/news_app/cubit/cubti.dart';
import 'package:udemy_flutter/layout/news_app/cubit/states.dart';
import 'package:udemy_flutter/modules/news_app/search/search_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';

import 'cubit/cubti.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(
                    context,
                    SearchScreen(),
                  );
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).dark();
                },
                icon: const Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   child: const Icon(Icons.add),
          //   onPressed: () {},
          // ),
          body: cubit.screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomIndex(index);
            },
            items: cubit.BottomItems,
          ),
        );
      },
    );
  }
}
