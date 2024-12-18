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

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Screen size variables
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02, // Dynamic horizontal padding
            ),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(height: screenHeight * 0.05), // Top spacing
                  Image.asset(
                    kLogo,
                    height: screenHeight * 0.372, // Enlarged height
                    width: screenWidth * 0.8, // Enlarged width
                  ),
                  Center(
                    child: Text(
                      'Chat Me',
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        color: Colors.white,
                        fontSize: screenWidth * 0.08, // Responsive font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05, // Responsive font size
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Column(
                    children: [
                      CustomTextField(
                        hintText: 'Email',
                        onChanged: (data) {
                          email = data;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      CustomTextField(
                        obscureText: true,
                        onChanged: (data) {
                          password = data;
                        },
                        hintText: 'Password',
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: double.infinity,
                    height: screenHeight * 0.07, // Responsive height
                    child: CustomButton(
                      text: 'Sign in',
                      onTap: () async {
                        var auth = FirebaseAuth.instance;
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context)
                              .signInUser(email: email!, password: password!);
                        } else {
                          print('Validation failed.');
                        }
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
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
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                screenWidth * 0.04, // Responsive font size
                          ),
                        ),
                      ),
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
}
