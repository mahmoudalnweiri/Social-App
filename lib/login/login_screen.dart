import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/socialCubit/cubit.dart';
import 'package:social_app/style/font_style.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/login/loginCubit/login_cubit.dart';
import 'package:social_app/login/loginCubit/login_states.dart';
import 'package:social_app/register/register_screen.dart';
import 'package:social_app/shared/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.setData(key: 'uId', value: state.uId).then((value) {
              SocialCubit.get(context).getUser();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const SocialLayout()));
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: headingStyle.copyWith(fontSize: 32),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Login now to communicate with friends',
                            style: subHeadingStyle.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              } else if (!value.contains('@')) {
                                return 'Your email must contains on "@"';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              hintText: 'Email Address',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 6) {
                                return 'Please enter your password at least 6 number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                splashRadius: 15,
                                onPressed: () {
                                  LoginCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                icon: Icon(LoginCubit.get(context).suffix),
                              ),
                              hintText: 'Password',
                              border: const OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: LoginCubit.get(context).isPassword,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                }
                              },
                              child: state is LoginLoadingState
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text(
                                      'Login',
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const RegisterScreen()));
                                },
                                child: const Text('Register Now'),
                              ),
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
        },
      ),
    );
  }
}
