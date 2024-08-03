// ignore_for_file: prefer_const_constructors, avoid_single_cascade_in_expression_statements

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_app/bloc/Login/login_bloc.dart';
import 'package:smart_app/presentation/components/AppButton.dart';
import 'package:smart_app/presentation/components/AppTextField.dart';
import 'package:smart_app/presentation/homepage/Homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          height: 450,
          width: 400,
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
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
                          icon: Icon(Icons.email),
                          onSaved: null,
                          controller: emailController),
                      AppTextField(
                          label: "Password",
                          textInputType: TextInputType.visiblePassword,
                          icon: Icon(Icons.lock),
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
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state.status == LoginStatus.error) {
                            return Text(
                              state.message,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Colors.red),
                            );
                          }
                          return SizedBox();
                        },
                      ),
                      AppButton(
                        onClick: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          context.read<LoginBloc>().add(Login(
                              email: emailController.text,
                              password: passwordController.text));
                        },
                        content: BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state.loggedIn) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/home', (Route<dynamic> route) => false);
                            }
                          },
                          builder: (context, state) {
                            if (state.status == LoginStatus.loading) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Authenticating ...",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              );
                            }
                            return Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            );
                          },
                        ),
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
      ),
    );
  }
}
