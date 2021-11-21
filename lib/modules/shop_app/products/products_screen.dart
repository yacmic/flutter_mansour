import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/Models/shop_app/home_model.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/shop_app/cubit/state.dart';
import 'package:udemy_flutter/shared/components/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null,
            builder: (context) =>
                productBuilder(ShopCubit.get(context).homeModel),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget productBuilder(HomeModel? model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CarouselSlider(
                items: model!.data!.banners
                    .map((e) => Image(
                          image: NetworkImage(e.image),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                color: Colors.grey[300],
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                  childAspectRatio: 1 / 1.73,
                  children: List.generate(model.data!.products.length,
                      (index) => builGridProduct(model.data!.products[index])),
                ),
              )
            ],
          ),
        ),
      );

  Widget builGridProduct(ProductModel? model) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: AlignmentDirectional.bottomStart, children: [
            Image(
              image: NetworkImage(model!.image),
              width: double.infinity,
              height: 200,
              //fit: BoxFit.cover,
            ),
            if (model.discount != 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                color: Colors.red,
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(fontSize: 10.0, color: Colors.white),
                ),
              )
          ]),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border,
                        size: 14,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
