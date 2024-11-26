import 'package:chats_project/firebase_options.dart';
import 'package:chats_project/pages/chatting.dart';
import 'package:chats_project/pages/cubits/cubit/chatting_cubit.dart';
import 'package:chats_project/pages/cubits/login_cubit/login_cubit.dart';
import 'package:chats_project/pages/cubits/register_cubit/register_cubit.dart';
import 'package:chats_project/pages/login_page.dart';
import 'package:chats_project/pages/register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chats_project/pages/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Scholar_Chat_App());
}

class Scholar_Chat_App extends StatelessWidget {
  const Scholar_Chat_App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(
          create: (context) =>
              ChattingCubit(FirebaseFirestore.instance)..fetchMessages(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          WelcomePage.id: (context) => WelcomePage(),
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChattingPage.id: (context) => ChattingPage(),
        },
        initialRoute: WelcomePage.id,
      ),
    );
  }
}
