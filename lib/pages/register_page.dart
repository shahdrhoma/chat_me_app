import 'package:chats_project/helper/show_snack_bar.dart';
import 'package:chats_project/pages/chatting.dart';
import 'package:chats_project/pages/cubits/register_cubit/register_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chats_project/components/custom_text_field.dart';
import 'package:chats_project/components/custom_button.dart';
import 'package:chats_project/pages/login_page.dart';
import 'package:chats_project/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatelessWidget {
  bool isLoading = false;
  String? email;
  static String id = 'RegisterPage';
  String? password;

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Screen size variables
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          isLoading = false;
          Navigator.pushNamed(context, LoginPage.id);
        } else if (state is RegisterFailure) {
          isLoading = false;
          showSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                      height: screenHeight * 0.372, // Responsive height
                      width: screenWidth * 0.8, // Responsive width
                    ),
                    //  SizedBox(height: screenHeight * 0.01), // Reduced space
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
                          'Register',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize:
                                screenWidth * 0.05, // Responsive font size
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Column(
                      children: [
                        CustomTextField(
                          onChanged: (data) {
                            email = data;
                          },
                          hintText: 'Email',
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
                        onTap: () async {
                          var auth = FirebaseAuth.instance;
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<RegisterCubit>(context)
                                .registerUser(
                                    email: email!, password: password!);
                          }
                        },
                        text: 'Register',
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'You already have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            ' Login',
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
        );
      },
    );
  }

  Future<void> registerUser(FirebaseAuth auth) async {
    await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
