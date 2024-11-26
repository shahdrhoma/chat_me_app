import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> signInUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      print('Attempting login with email: $email');
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print('Login successful for user: ${user.user?.email}');
      emit(LoginSuccess());
      return; // Exit function
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code}');
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errMessage: 'User not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errMessage: 'Wrong password'));
      } else if (e.code == 'invalid-email') {
        emit(LoginFailure(errMessage: 'Invalid Email'));
      } else {
        emit(LoginFailure(errMessage: e.message ?? 'Unknown error occurred'));
      }
    } catch (e) {
      print('General Exception: $e');
      emit(LoginFailure(errMessage: 'Something went wrong: $e'));
    }
  }
}
