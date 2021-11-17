import 'package:flutter/material.dart';
import 'package:udemy_flutter/modules/shop_app/register/shop_register_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                  onTap: () {},
                ),
                const SizedBox(
                  height: 15,
                ),
                defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  text: 'Password',
                  prefix: Icons.password,
                  suffix: Icons.remove_red_eye,
                  suffixFunction: () {},
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                defaultButton(
                  function: () {},
                  text: 'login',
                  isUpperCase: true,
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
    );
  }
}
