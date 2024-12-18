import 'package:chats_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chats_project/components/chat_bubble.dart';
import 'package:chats_project/pages/cubits/cubit/chatting_cubit.dart';

class ChattingPage extends StatelessWidget {
  static const String id = 'chatting';

  final ScrollController scrollController = ScrollController();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Get email from route arguments
    var email = ModalRoute.of(context)?.settings.arguments as String?;

    if (email == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Error: No email found")),
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
                height: screenHeight * 0.1111, // Responsive height for logo
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
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChattingLoaded) {
                    final messages = state.messages;

                    // Scroll to the bottom when new messages are loaded
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollToBottom();
                    });

                    return ListView.builder(
                      controller: scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isSender = message.id == email;

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.00000001,
                            vertical: screenHeight * 0.00001,
                          ),
                          child: isSender
                              ? MessageBubble(
                                  messageText: message.message,
                                  isSender: true,
                                )
                              : MessageBubbleForAFriend(
                                  messageText: message.message,
                                  isSender: false,
                                ),
                        );
                      },
                    );
                  } else if (state is ChattingError) {
                    return Center(child: Text('Error: ${state.error}'));
                  }

                  return const Center(child: Text('Start a conversation!'));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Enter your message',
                        hintStyle: TextStyle(
                          fontSize: screenWidth * 0.04, // Responsive font size
                        ),
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
                          _scrollToBottom();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                      width:
                          screenWidth * 0.01), // Space between text and button
                  IconButton(
                    icon: Icon(Icons.send, size: screenWidth * 0.07),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        context
                            .read<ChattingCubit>()
                            .sendMessage(email, _controller.text);
                        _controller.clear();
                        _scrollToBottom();
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

  // Helper method to scroll to the bottom of the ListView
  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
