import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/shop_app/login/cubit/states.dart';
import 'package:udemy_flutter/shared/network/end_point.dart';
import 'package:udemy_flutter/shared/network/remot/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then(
      (value) {
        emit(ShopLoginSuccessState());
        print(value.data);
      },
    ).catchError((onError) => print(onError.toString()));
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPasswordShow = true;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;

    suffix = isPasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;

    emit(ShopLoginPasswordVisibilityState());
  }
}
