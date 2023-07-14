import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hello/constants/constants.dart';
import 'package:hello/providers/chats_provider.dart';
import 'package:hello/services/chat/services.dart';
import 'package:hello/widgets/chat_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../providers/models_provider.dart';
import '../../services/chat/assets_manager.dart';
import '../../widgets/text_widget.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  bool _isTyping = false;
  bool _isListening = false;

  final stt.SpeechToText _speech = stt.SpeechToText();
  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;
  @override
  void initState() {
    // TODO: implement initState
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
    _initializeSpeech();
  }

  void _initializeSpeech() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {
        _isListening = false;
      });
    } else {
      print('The user has denied speech recognition permission.');
    }
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      backgroundColor: cardColor,
      appBar: AppBar(
        // backgroundColor: scaffoldBackgroundColor,
        // elevation: 2,
        // // iconTheme: new IconThemeData(color: Colors.white),
        // title: const Text(
        //   "ChatGPT",
        //   style: TextStyle(color: Colors.white),
        // ),
        title: const Text("Health Care Chat Application",
                style: TextStyle(fontSize: 25,
                color: Colors.white
          )
        ),
        backgroundColor: chatappTitleColor,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModalSheet(context: context);
            },
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
          ),
        ],
        // elevation: 2,
        // leading: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Image.asset(AssetsManager.govLogo,
        //   width: 3,
        //   height: 2,
        //   ),
        //),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                  controller: _listScrollController,
                  itemCount: chatProvider.getChatList.length, //chatList.length,
                  itemBuilder: (context, index) {
                    return ChatWidget(
                      msg: chatProvider
                          .getChatList[index].msg, // chatList[index].msg,
                      chatIndex: chatProvider.getChatList[index]
                          .chatIndex, //chatList[index].chatIndex,
                      shouldAnimate:
                          chatProvider.getChatList.length - 1 == index,
                    );
                  }),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ],
            const SizedBox(
              height: 15,
            ),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700,color: Colors.black),
                        controller: textEditingController,
                        onSubmitted: (value) async {
                          await sendMessageFCT(
                              modelsProvider: modelsProvider,
                              chatProvider: chatProvider);
                        },
                        decoration:  InputDecoration(
                            hintText: "How can I help you",
                            hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w700,color: Colors.grey),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25),
                             ),
                           )
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_isListening) {
                            stopListening();
                          } else {
                            startListening();
                          }
                        },
                        child: Icon(
                          _isListening ? Icons.mic : Icons.mic_none,
                          color: _isListening ? Colors.blue : Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(188, 6, 141, 47),
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(15),
                          )
                        ),
                    ElevatedButton(
                        onPressed: () async {
                          await sendMessageFCT(
                              modelsProvider: modelsProvider,
                              chatProvider: chatProvider);
                        },
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(188, 6, 141, 47),
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(15),
                          ) 
                        )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }

  void startListening() {
    _speech.listen(
      onResult: (result) {
        setState(() {
          textEditingController.text = result.recognizedWords;
        });
      },
    );
    setState(() {
      _isListening = true;
    });
  }

  void stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  Future<void> sendMessageFCT(
      {required ModelsProvider modelsProvider,
      required ChatProvider chatProvider}) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "You cant send multiple messages at a time",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Please type a message",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String msg = textEditingController.text;
      setState(() {
        _isTyping = true;
        // chatList.add(ChatModel(msg: textEditingController.text, chatIndex: 0));
        chatProvider.addUserMessage(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswers(
          msg: msg, chosenModelId: modelsProvider.getCurrentModel);
      // chatList.addAll(await ApiService.sendMessage(
      //   message: textEditingController.text,
      //   modelId: modelsProvider.getCurrentModel,
      // ));
      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TextWidget(
          label: error.toString(),
        ),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
      });
    }
  }
}
