import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_app/cubit/states.dart';
import 'package:udemy_flutter/modules/news_app/business/business_screen.dart';
import 'package:udemy_flutter/modules/news_app/science/science_screen.dart';
import 'package:udemy_flutter/modules/news_app/sports/sports_screen.dart';
import 'package:udemy_flutter/shared/network/local/cash_helper.dart';
import 'package:udemy_flutter/shared/network/remot/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  //bool isDark = true;
  List<BottomNavigationBarItem> BottomItems = const [
    BottomNavigationBarItem(
      label: 'Business',
      icon: Icon(Icons.business),
    ),
    BottomNavigationBarItem(
      label: 'Science',
      icon: Icon(Icons.science),
    ),
    BottomNavigationBarItem(
      label: 'Sports',
      icon: Icon(Icons.sports),
    ),
  ];

  List screen = const [
    BusinessScreen(),
    SciencesScreen(),
    SportsScreen(),
  ];

  void changeBottomIndex(index) {
    currentIndex = index;

    emit(NewsBottomNavState());
  }

  // void dark({bool? fromShared}) {
  //   if (fromShared != null) {
  //     isDark = fromShared;
  //     emit(NewsSharedPreferncesState());
  //   } else {
  //     isDark = !isDark;
  //     CashHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
  //       emit(NewsSharedPreferncesState());
  //     });
  //     emit(NewsDarkThemeState());
  //   }
  // }

  List<dynamic> business = [];
  void getBusiness() {
    if (business.isEmpty) {
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(
        url: '/v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': '8b890e3eeb564e06aa1b99ef44597fce',
        },
      ).then(
        (value) {
          business = value.data['articles'];
          print(business[0]['title']);
          emit(NewsGetBusinessSuccessState());
        },
      ).catchError((onError) {
        print(onError.toString());
        emit(NewsGetBusinessErrorState('0'));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> sports = [];
  void getSport() {
    if (sports.length == 0) {
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(
        url: '/v2/top-headlines',
        query: {
          'country': 'it',
          'category': 'sports',
          'apiKey': '8b890e3eeb564e06aa1b99ef44597fce',
        },
      ).then(
        (value) {
          sports = value.data['articles'];
          //print(sports[0]['title']);
          emit(NewsGetSportsSuccessState());
        },
      ).catchError((onError) {
        print(onError.toString());
        emit(NewsGetSportsSuccessState());
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    if (science.isEmpty) {
      emit(NewsGetSciencesLoadingState());
      DioHelper.getData(
        url: '/v2/top-headlines',
        query: {
          'country': 'it',
          'category': 'science',
          'apiKey': '8b890e3eeb564e06aa1b99ef44597fce',
        },
      ).then(
        (value) {
          science = value.data['articles'];
          //print(sports[0]['title']);
          emit(NewsGetSciencesSuccessState());
        },
      ).catchError((onError) {
        print(onError.toString());
        emit(NewsGetSciencesSuccessState());
      });
    } else {
      emit(NewsGetSciencesSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSerach(String value) {
    search = [];
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: '/v2/everything',
      query: {
        'q': value,
        'apiKey': '8b890e3eeb564e06aa1b99ef44597fce',
      },
    ).then(
      (value) {
        search = value.data['articles'];
        //print(sports[0]['title']);
        emit(NewsGetSearchSuccessState());
      },
    ).catchError((onError) {
      print(onError.toString());
      emit(NewsGetSearchSuccessState());
    });
  }
}
