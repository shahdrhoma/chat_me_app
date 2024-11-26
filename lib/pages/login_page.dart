import 'package:chats_project/components/custom_text_field.dart';
import 'package:chats_project/components/custom_button.dart';
import 'package:chats_project/helper/show_snack_bar.dart';
import 'package:chats_project/pages/chatting.dart';
import 'package:chats_project/pages/cubits/login_cubit/login_cubit.dart';
import 'package:chats_project/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chats_project/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  bool isLoading = false;

  String? email;
  static String id = 'LoginPage';

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          isLoading = false;
          Navigator.pushNamed(context, ChattingPage.id, arguments: email);
        } else if (state is LoginFailure) {
          isLoading = false;

          showSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(height: 50),
                  Image.asset(kLogo, height: 250),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Chat Me',
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      children: [
                        CustomTextField(
                            hintText: 'Email',
                            onChanged: (data) {
                              email = data;
                            }),
                        const SizedBox(height: 20),
                        CustomTextField(
                          obscureText: true,
                          onChanged: (data) {
                            password = data;
                          },
                          hintText: 'Password',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      text: 'Sign in',
                      onTap: () async {
                        var auth = FirebaseAuth.instance;
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context)
                              .signInUser(email: email!, password: password!);
                        } else {
                          print('no thing from the above ');
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: Text(
                            ' Register',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInUser(FirebaseAuth auth) async {
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
