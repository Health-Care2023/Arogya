import 'package:dialogflow_flutter/language.dart';
import 'package:flutter/cupertino.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:flutter/material.dart';
import 'package:dialogflow_flutter/dialogflowFlutter.dart';

import '../models/chat_model.dart';
import '../services/chat/api_service.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  late String responce;

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String chosenModelId}) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "asset/aragya-311abc8ea355.json").build();
    DialogFlow dialogflow =
        DialogFlow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(msg);
    responce = aiResponse.getListMessage()![0]["text"]["text"][0].toString();

    chatList.add(ChatModel(msg: responce, chatIndex: 1));
    notifyListeners();
  }
}
