part of 'chatting_cubit.dart';

abstract class ChattingState {}

class ChattingInitial extends ChattingState {}

class ChattingLoading extends ChattingState {}

class ChattingLoaded extends ChattingState {
  final List<Message> messages;
  ChattingLoaded(this.messages);
}

class ChattingError extends ChattingState {
  final String error;
  ChattingError(this.error);
}
