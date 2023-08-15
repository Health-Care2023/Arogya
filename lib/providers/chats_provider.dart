import 'package:flutter/cupertino.dart';

import '../models/chat_model.dart';
import '../services/chat/api_service.dart';
import '../models/response_model.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  List<ResponseModel> responseList = [
    ResponseModel(keywords: [], response: 'Sorry, I dont understand.'),
    ResponseModel(
      keywords: ['types', 'categories', 'category', 'type'],
      response:
          'Types of diabetes are: \n 1. Type 1 diabetes \n 2. Type 2 diabetes \n 3. Gestational diabetes \n 4. Monogenic diabetes \n 5. Cystic fibrosis-related diabetes \n 6. Steroid diabetes \n 7. Pre-diabetes \n 8. Latent autoimmune diabetes in adults (LADA)',
    ),
    ResponseModel(
        keywords: ['what', 'definition', 'explanation', 'overview'],
        response:
            'Diabetes is a chronic medical condition characterized by elevated levels of glucose (sugar) in the blood. It occurs when the body either doesnt produce enough insulin or is unable to effectively use the insulin it produces. Insulin is a hormone produced by the pancreas that helps regulate blood sugar levels and allows glucose to enter cells to be used as energy.'),
    ResponseModel(
      keywords: ['insipidus', 'what'],
      response:
          'Diabetes insipidus is a rare disorder characterized by the inability of the body to properly regulate water balance. Unlike diabetes mellitus (the more common type of diabetes), diabetes insipidus does not involve problems with insulin or blood sugar levels. Instead, it affects the way the body handles fluids, leading to excessive thirst and the production of large volumes of diluted urine.',
    ),
    ResponseModel(
      keywords: ['cure', 'curable', 'treatment', 'treatable', 'cured'],
      response:
          'While there is no cure at present early diagnosis proper management and adherence to a comprehensive treatment plan can help individuals with diabetes reduce the risk of complications and improve their overall quality of life. Its crucial for individuals with diabetes to work closely with their healthcare providers to develop a personalized treatment strategy and maintain regular check-ups to monitor their condition and make necessary adjustments to their management plan as needed.',
    ),
  ];

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String chosenModelId}) async {
    // if (chosenModelId.toLowerCase().startsWith("gpt")) {
    //   chatList.addAll(await ApiService.sendMessageGPT(
    //     message: msg,
    //     modelId: chosenModelId,
    //   ));
    // } else {
    //   chatList.addAll(await ApiService.sendMessage(
    //     message: msg,
    //     modelId: chosenModelId,
    //   ));
    // }
    chatList.add(ChatModel(msg: generateResponse(msg: msg), chatIndex: 1));
    notifyListeners();
  }

  String generateResponse({required String msg}) {
    String lowercaseMsg = msg.toLowerCase();
    String cleanedMsg = lowercaseMsg.replaceAll(RegExp(r'[^\w\s]'), '');
    List<String> words = cleanedMsg.split(' ');

    int highestMatchCount = 0;
    ResponseModel matchingResponse =
        responseList[0]; // Default to the first response

    for (var response in responseList) {
      int matchCount = 0;

      for (var keyword in response.keywords) {
        if (words.contains(keyword)) {
          matchCount++;
        }
      }

      if (matchCount > highestMatchCount) {
        highestMatchCount = matchCount;
        matchingResponse = response;
      }
    }

    return matchingResponse.response;
  }
}
