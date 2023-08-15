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
    ResponseModel(
      keywords: ['high', 'blood' , 'sugar','hyperglycemia','level'],
      response:
          'High blood sugar, also known as hyperglycemia, refers to a condition characterized by abnormally elevated levels of glucose (sugar) in the bloodstream. In a healthy individual, the body regulates blood sugar levels through the hormone insulin, which helps glucose enter the cells to be used as energy. However, in cases of high blood sugar, either insufficient insulin is produced or the body becomes resistant to its effects, resulting in an accumulation of glucose in the blood.',      
    ),
    ResponseModel(
      keywords: ['low','hypoglycemia','decreased','blood','sugar'],
      response:
          'Low blood sugar, also known as hypoglycemia, refers to a condition characterized by abnormally low levels of glucose (sugar) in the bloodstream. Glucose is the primary source of energy for the body cells, including the brain, so maintaining stable blood sugar levels is crucial for proper bodily function.',
    ),
    ResponseModel(
      keywords: ['continous','glucose','monitoring','potential','limitations'],
      response:
        'Continuous glucose monitoring (CGM) is a method of monitoring blood glucose levels in real time throughout the day and night. It involves the use of a small sensor that is inserted under the skin, typically on the abdomen or arm, to measure glucose levels in the interstitial fluid. The sensor is connected to a transmitter that sends the glucose readings wirelessly to a receiver or a smartphone app.',
    ),
    ResponseModel(
      keywords: ['testing','procedure','blood','sugar','levels','guideline'],
      response:
        'To test your blood sugar, you typically follow these steps:\n1. Wash your hands with soap and warm water, or use an alcohol swab to clean the area you will be pricking.\n2. Prepare your blood glucose meter by inserting a fresh lancet into the lancing device.\n3. Use the lancing device to prick the side of your fingertip gently. Alternatively, you may use alternative sites like the forearm or palm, as advised by your healthcare provider.',
    ),
     ResponseModel(
      keywords: ['insulin','overdose','excessive','amount','procedure','manage'],
      response:
        'Handling an insulin overdose is a serious matter that requires prompt action. If you or someone else experiences an insulin overdose, follow these steps:\n1. Recognize the symptoms: Symptoms of an insulin overdose may include excessive sweating, shakiness, confusion, dizziness, weakness, rapid heartbeat, blurred vision, difficulty concentrating, or loss of consciousness.\n2. Assess the severity: Determine the severity of the overdose based on the symptoms. If the person is conscious and able to swallow, it may be a milder case. However, if the person is unconscious or experiencing severe symptoms, it is a medical emergency, and immediate medical assistance should be sought.\n3. Call for help: In cases of severe symptoms or loss of consciousness, call emergency services or your local emergency number immediately. Inform them about the insulin overdose and provide any other necessary details.\n4. Stay with the person: If the person is conscious and able to communicate, stay with them and monitor their condition closely until medical help arrives.',

    ),
     ResponseModel(
      keywords: ['diabetic','shock','insulin','reactions','meaning','overview'],
      response:
        'Diabetic shock and insulin reactions refer to two related but distinct conditions that can occur in individuals with diabetes.',
    ),
    ResponseModel(
      keywords: ['carbohydrate','fibre','diabetes','descibes','associations','relationship','connection'],
      response:
        'The relationship between carbohydrates, fiber, and diabetes is significant and can greatly impact blood sugar control, overall glycemic management, and the prevention of complications. Here are some key aspects of their connection:\n1. Carbohydrates: Carbohydrates are the primary macronutrient that significantly affects blood sugar levels. When consumed, carbohydrates are broken down into glucose, leading to a rise in blood sugar. In diabetes, the body either has insufficient insulin or is resistant to insulin, which impairs glucose regulation. Therefore, monitoring and managing carbohydrate intake is crucial for individuals with diabetes to maintain stable blood sugar levels.\n2. Fiber: Fiber is a type of carbohydrate that is not broken down or absorbed by the body. It passes through the digestive system relatively intact. Fiber-rich foods, such as fruits, vegetables, whole grains, legumes, and nuts, offer various health benefits for individuals with diabetes.\n3. Glycemic impact: Carbohydrates can be categorized based on their glycemic index (GI), which reflects how quickly they raise blood sugar levels. High-GI carbohydrates, such as white bread, sugary beverages, and processed snacks, cause a rapid spike in blood sugar. In contrast, low-GI carbohydrates, including whole grains, certain fruits, and vegetables, release glucose more gradually, resulting in a slower rise in blood sugar.',
    
    ),
     ResponseModel(
      keywords: ['glycemic','index','food','connection','understanding'],
      response:
        'Understanding food and the glycemic index is essential for making informed dietary choices, especially for individuals looking to manage blood sugar levels, promote satiety, and support overall health. Here are the key points to grasp:\n1. Glycemic index (GI): The glycemic index is a numerical ranking system that measures how carbohydrates in food affect blood sugar levels compared to pure glucose. Foods are categorized as high (GI above 70), medium (GI between 56-69), or low (GI below 55) based on their impact on blood sugar.\n2. Blood sugar response: Foods with a high GI cause a rapid spike in blood sugar levels, leading to a quick energy boost followed by a crash. In contrast, foods with a low GI are digested and absorbed more slowly, resulting in a more gradual and sustained rise in blood sugar.\n3. Impact on health: Consuming a diet consisting mainly of high-GI foods may contribute to increased risk of type 2 diabetes, weight gain, and cardiovascular diseases. Low-GI foods tend to promote better blood sugar control, sustained energy, and improved weight management.',
    ),
    ResponseModel(
      keywords: ['portion','sizes','individual','insulin','dosing','relationships','example'],
      response:
        'Determining optimal serving sizes for individuals with diabetes is crucial for maintaining stable blood sugar levels and supporting overall health. Here are some considerations to keep in mind:\n1. Consult a healthcare professional: It is advisable to work with a registered dietitian or healthcare provider to determine personalized serving sizes based on individual needs, goals, medication, and other factors specific to your condition.\n2. Carbohydrate servings: Carbohydrates have the most significant impact on blood sugar levels. Monitoring carbohydrate intake and distributing it evenly throughout meals can help manage blood glucose. A typical recommendation is to aim for 45-60 grams of carbohydrates per meal for women and 60-75 grams for men. However, individual requirements may vary. \n3. Choose high-fiber carbohydrates: Opt for high-fiber carbohydrates as they tend to have a smaller impact on blood sugar levels. Include whole grains, legumes, fruits, and vegetables in your meals and adjust portion sizes accordingly.',
      ),
    ResponseModel(
      keywords: ['diabetes','alcohol','consumption','relationship','information'],
      response:
        'Diabetes and alcohol consumption are interconnected, and it\'s important to understand the effects alcohol can have on individuals with diabetes. Here are some key points to consider:\n1. Blood sugar control: Alcohol can affect blood sugar levels in various ways. Initially, alcohol may cause a decrease in blood sugar levels, leading to hypoglycemia (low blood sugar). However, alcohol can also interfere with the liver\'s ability to produce glucose, resulting in delayed hypoglycemia hours after drinking. On the other hand, excessive alcohol consumption can lead to hyperglycemia (high blood sugar) due to the additional calories and carbohydrates found in alcoholic beverages.\n2. Hypoglycemia risk: People with diabetes who take insulin or certain diabetes medications are at higher risk of experiencing alcohol-induced hypoglycemia. Alcohol can mask the symptoms of hypoglycemia, making it more challenging to recognize and treat. It\'s crucial to monitor blood sugar levels closely and consume alcohol in moderation to minimize this risk.\n3. Calories and weight management: Alcoholic beverages can be high in calories and sugar, which can contribute to weight gain and difficulty managing blood sugar levels. It\'s important to consider the nutritional content of alcoholic drinks and incorporate them into an overall balanced diet.',
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
