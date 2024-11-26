import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chats_project/constants.dart';
import 'package:chats_project/models/message.dart';

part 'chatting_state.dart';

class ChattingCubit extends Cubit<ChattingState> {
  final FirebaseFirestore firestore;

  ChattingCubit(this.firestore) : super(ChattingInitial());

  // Fetch messages from Firestore
  void fetchMessages() {
    try {
      emit(ChattingLoading());
      firestore
          .collection(kMessagesCollections)
          .orderBy('createdAt', descending: false)
          .snapshots()
          .listen((snapshot) {
        final messages = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Message.fromJson(data);
        }).toList();

        emit(ChattingLoaded(messages));
      });
    } catch (error) {
      emit(ChattingError(error.toString()));
    }
  }

  // Send a new message
  Future<void> sendMessage(String email, String message) async {
    if (message.trim().isNotEmpty) {
      try {
        await firestore.collection(kMessagesCollections).add({
          'id': email,
          'message': message,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } catch (error) {
        emit(ChattingError(error.toString()));
      }
    }
  }
}
