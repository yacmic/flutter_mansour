import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  var txemail = TextEditingController();
  var txpassword = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(fontSize: 40),
                    ),
                    const SizedBox(height: 45),
                    defaultFormField(
                      text: 'Email adr',
                      prefix: Icons.email,
                      type: TextInputType.emailAddress,
                      controller: txemail,
                      onTap: () {},
                      // validate: (String val) {
                      //   if (val.isEmpty) {
                      //     return 'email empty';
                      //   }
                      // },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: txpassword,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password must not be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: const Text('Password'),
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.remove_red_eye),
                            onPressed: () {},
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                    const SizedBox(height: 20),
                    defaultButton(
                        text: 'login',
                        function: () {
                          if (formKey.currentState!.validate()) {
                            print('dsffd');
                          }
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account ?'),
                        TextButton(
                          child: Text('Register Now'),
                          onPressed: () {},
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
