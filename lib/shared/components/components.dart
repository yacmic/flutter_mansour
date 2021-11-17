import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:udemy_flutter/modules/news_app/web_view/web_view_screen.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';

Widget defaultTextButton({
  required String text,
  required Function function,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(text),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: ElevatedButton(
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
        onPressed: () => function(),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? validate,
  required String text,
  required IconData prefix,
  IconData? suffix,
  Function? suffixFunction,
  Function? onTap,
  bool isClickable = true,
  Function? change,
  Function? onSubmit,
  bool isPassword = false,
  String textForUnValid = 'this element is required',
}) =>
    TextFormField(
      //textAlignVertical: TextAlignVertical.bottom,
      enabled: isClickable,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword ? true : false,
      validator: (value) {
        if (value!.isEmpty) {
          return textForUnValid;
        }
        return null;
      },
      onFieldSubmitted: (_) => onSubmit!(),
      decoration: InputDecoration(
        //contentPadding: const EdgeInsets.all(2),
        label: Text(text),
        prefixIcon: Icon(prefix), //suffixIcon: Icon(suffix),
        suffixIcon: IconButton(
          onPressed: () {
            suffixFunction!();
          },
          icon: Icon(suffix),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(),
          gapPadding: 4,
        ),
      ),
      // onTap: () {
      //   onTap!();
      // },
      onChanged: (value) {},
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model['time']}',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20.0),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'Done', id: model['id']);
              },
              icon: const Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'Archive', id: model['id']);
              },
              icon: const Icon(Icons.archive_outlined, color: Colors.black45),
            )
          ],
        ),
      ),
    );

Widget buildArticleItem(Map article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(article["urlToImage"].toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: SizedBox(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        article['title'],
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      article['publishedAt'],
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 2,
        color: Colors.grey,
      ),
    );

Widget ArticleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10),
    fallback: (context) =>
        isSearch ? Center() : const Center(child: CircularProgressIndicator()));

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );
