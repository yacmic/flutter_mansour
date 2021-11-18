import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter/modules/shop_app/login/cubit/cubit.dart';
import 'package:udemy_flutter/modules/shop_app/login/cubit/states.dart';
import 'package:udemy_flutter/modules/shop_app/register/shop_register_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (BuildContext context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status == true) {
              print(state.loginModel.data!.token);
              print(state.loginModel.message);
              Fluttertoast.showToast(
                msg: state.loginModel.message.toString(),
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            } else {
              print(state.loginModel.message);

              Fluttertoast.showToast(
                msg: state.loginModel.message.toString(),
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Login Now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.grey),
                        ),
                        const SizedBox(height: 20),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            text: 'Email',
                            prefix: Icons.email_outlined,
                            validate: (String val) {
                              if (val.isEmpty) {
                                return 'Email is empty';
                              }
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.emailAddress,
                            text: 'Password',
                            prefix: Icons.password,
                            suffix: ShopLoginCubit.get(context).suffix,
                            isPassword:
                                ShopLoginCubit.get(context).isPasswordShow,
                            suffixFunction: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            onSubmit: () {
                              if (formkey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            validate: (String val) {
                              if (val.isEmpty) {
                                return 'Password is empty';
                              }
                            }),
                        const SizedBox(height: 20),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (BuildContext context) {
                            return defaultButton(
                              function: () {
                                if (formkey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                } else {}
                              },
                              text: 'login',
                              isUpperCase: true,
                            );
                          },
                          fallback: (BuildContext context) =>
                              Center(child: const CircularProgressIndicator()),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            defaultTextButton(
                              text: 'Register',
                              function: () {
                                navigateTo(context, const ShopRegisterScreen());
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
