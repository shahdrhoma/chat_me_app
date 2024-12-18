import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException code: ${e.code}'); // Log the error code
      emit(LoginFailure(errMessage: _getFriendlyErrorMessage(e.code)));
    } catch (e) {
      print('General Exception: $e'); // Log any other errors
      emit(LoginFailure(errMessage: 'Something went wrong. Please try again.'));
    }
  }

  String _getFriendlyErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No account found for this email. Please check and try again.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'The email format is invalid. Please try again.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      case 'too-many-requests':
        return 'Too many login attempts. Please wait and try again.';
      default:
        return 'Login failed. Please try again.';
    }
  }
}
