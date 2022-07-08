// To parse this JSON data, do
//
//     final questionsModel = questionsModelFromJson(jsonString);

import 'dart:convert';

QuestionsModel questionsModelFromJson(String str) => QuestionsModel.fromJson(json.decode(str));

String questionsModelToJson(QuestionsModel data) => json.encode(data.toJson());

class QuestionsModel {
    QuestionsModel({
        this.name,
        this.serviceMasterId,
        this.document,
    });

    String? name;
    String? serviceMasterId;
    Document? document;

    factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
        name: json["name"] == null ? null : json["name"],
        serviceMasterId: json["serviceMasterId"] == null ? null : json["serviceMasterId"],
        document: json["document"] == null ? null : Document.fromJson(json["document"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "serviceMasterId": serviceMasterId == null ? null : serviceMasterId,
        "document": document == null ? null : document!.toJson(),
    };
}

class Document {
    Document({
        this.data,
    });

    List<Datum>? data;

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.page,
        this.alias,
        this.name,
        this.type,
        this.isMandatory,
        this.options,
    });

    int? page;
    String? alias;
    String? name;
    String? type;
    String? isMandatory;
    List<String>?options;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        page: json["page"] == null ? null : json["page"],
        alias: json["alias"] == null ? null : json["alias"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        isMandatory: json["is_mandatory"] == null ? null : json["is_mandatory"],
        options: json["options"] == null ? null : List<String>.from(json["options"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "page": page == null ? null : page,
        "alias": alias == null ? null : alias,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "is_mandatory": isMandatory == null ? null : isMandatory,
        "options": options == null ? null : List<dynamic>.from(options!.map((x) => x)),
    };
}
