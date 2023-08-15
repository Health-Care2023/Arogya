class ResponseModel {
  final List<String> keywords;
  final String response;

  ResponseModel({required this.keywords, required this.response});

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        keywords: List<String>.from(json["keywords"]),
        response: json["response"],
      );
}
