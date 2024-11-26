import 'package:chats_project/components/chat_bubble.dart';
import 'package:chats_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chats_project/pages/cubits/cubit/chatting_cubit.dart';

class ChattingPage extends StatelessWidget {
  static const String id = 'chatting';

  final ScrollController scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get email from route arguments
    var email = ModalRoute.of(context)?.settings.arguments as String?;

    if (email == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text("Error: No email found")),
      );
    }

    return BlocProvider(
      create: (context) =>
          ChattingCubit(FirebaseFirestore.instance)..fetchMessages(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                kLogo,
                height: 50,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChattingCubit, ChattingState>(
                builder: (context, state) {
                  if (state is ChattingLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ChattingLoaded) {
                    final messages = state.messages;

                    return ListView.builder(
                      controller: scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isSender = message.id == email;

                        return isSender
                            ? MessageBubble(
                                messageText: message.message,
                                isSender: true,
                              )
                            : MessageBubbleForAFriend(
                                messageText: message.message,
                                isSender: false,
                              );
                      },
                    );
                  } else if (state is ChattingError) {
                    return Center(child: Text('Error: ${state.error}'));
                  }

                  return Center(child: Text('Start a conversation!'));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Enter your message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          context
                              .read<ChattingCubit>()
                              .sendMessage(email, value);
                          _controller.clear();
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.fastOutSlowIn,
                          );
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        context
                            .read<ChattingCubit>()
                            .sendMessage(email, _controller.text);
                        _controller.clear();
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
