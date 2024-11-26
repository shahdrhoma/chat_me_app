part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  String errMessage;
  RegisterFailure({required this.errMessage});
}

class RegisterLoading extends RegisterState {}
