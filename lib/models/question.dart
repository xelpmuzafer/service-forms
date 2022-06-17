// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

List<Question> questionFromJson(String str) =>
    List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));

String questionToJson(List<Question> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Question {
  Question({
    this.id,
    this.questionJson,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  List<QuestionJson>? questionJson;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"] == null ? null : json["id"],
        questionJson: json["questionJSON"] == null
            ? null
            : List<QuestionJson>.from(
                json["questionJSON"].map((x) => QuestionJson.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "questionJSON": questionJson == null
            ? null
            : List<dynamic>.from(questionJson!.map((x) => x.toJson())),
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class QuestionJson {
  QuestionJson({
    this.id,
    this.question,
    this.answerType,
    this.options,
  });

  String? id;
  String? question;
  AnswerType? answerType;
  Options? options;

  factory QuestionJson.fromJson(Map<String, dynamic> json) => QuestionJson(
        id: json["id"] == null ? null : json["id"],
        question: json["question"] == null ? null : json["question"],
        answerType: json["answer_type"] == null
            ? null
            : answerTypeValues.map![json["answer_type"]],
        options:
            json["options"] == null ? null : Options.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "question": question == null ? null : question,
        "answer_type":
            answerType == null ? null : answerTypeValues.reverse[answerType],
        "options": options == null ? null : options!.toJson(),
      };
}

enum AnswerType { TEXT, NUMBER, MULTIPLE_CHOICE, AUDIO }

final answerTypeValues = EnumValues({
  "audio": AnswerType.AUDIO,
  "multiple choice": AnswerType.MULTIPLE_CHOICE,
  "number": AnswerType.NUMBER,
  "text": AnswerType.TEXT
});

class Options {
  Options({
    this.option2,
    this.option3,
    this.options1,
  });

  String? option2;
  String? option3;
  String? options1;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        option2: json["option2"] == null ? null : json["option2"],
        option3: json["option3"] == null ? null : json["option3"],
        options1: json["options1"] == null ? null : json["options1"],
      );

  Map<String, dynamic> toJson() => {
        "option2": option2 == null ? null : option2,
        "option3": option3 == null ? null : option3,
        "options1": options1 == null ? null : options1,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
