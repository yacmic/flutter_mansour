import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/news_app/cubit/cubti.dart';
import 'package:udemy_flutter/modules/shop_app/login/cubit/states.dart';

class ShopLoginCubit extends Cubit {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
}
