import 'package:flutter/material.dart';
import 'package:smart_app/presentation/components/AppButton.dart';
import 'package:smart_app/presentation/components/AppTextField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;

  String greeting() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning!';
    }
    if (hour < 17) {
      return 'Good Afternoon!';
    }
    return 'Good Evening!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          height: 450,
          width: 400,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(greeting(),
                    style: Theme.of(context).textTheme.headlineSmall),

                Text("Enter your login details to continue",
                    style: Theme.of(context).textTheme.titleMedium),
                Column(
                  children: [
                    AppTextField(
                        label: "Email",
                        textInputType: TextInputType.emailAddress,
                        hint: "johndoe@email.com",
                        icon: const Icon(Icons.email),
                        onSaved: null,
                        controller: emailController),
                    AppTextField(
                        label: "Password",
                        textInputType: TextInputType.visiblePassword,
                        icon: const Icon(Icons.lock),
                        hint: "* * * * * * *",
                        isPassword: true,
                        onHidePassword: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        onSaved: null,
                        controller: passwordController,
                        obscureText: hidePassword),
                    AppButton(
                      onClick: () {},
                      content:  const Text("Login", style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
                Text("Forgot Password?",
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
