import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/Models/shop_app/home_model.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/state.dart';
import 'package:udemy_flutter/modules/shop_app/categories/categories_screen.dart';
import 'package:udemy_flutter/modules/shop_app/favorites/favorites_screen.dart';
import 'package:udemy_flutter/modules/shop_app/products/products_screen.dart';
import 'package:udemy_flutter/modules/shop_app/settings/settings_screen.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/network/end_point.dart';
import 'package:udemy_flutter/shared/network/remot/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  HomeModel? homeModel;

  List<Widget> bottomScreens = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      emit(ShopSuccessHomeDataState());
      homeModel = HomeModel.fromJson(value.data);

      printFullText(homeModel!.data!.banners[0].image);
    }).catchError((onError) {
      emit(ShopErrorHomeDataState());
      print(onError.toString());
    });
  }

  void changeBottom(int index) {
    currentIndex = index;

    emit(ShopChangeBottomNavState());
  }
}
