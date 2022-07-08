// To parse this JSON data, do
//
//     final dynamicFormField = dynamicFormFieldFromJson(jsonString);

import 'dart:convert';

DynamicFormField dynamicFormFieldFromJson(String str) => DynamicFormField.fromJson(json.decode(str));

String dynamicFormFieldToJson(DynamicFormField data) => json.encode(data.toJson());

class DynamicFormField {
    DynamicFormField({
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
    List<String>? options;

    factory DynamicFormField.fromJson(Map<String, dynamic> json) => DynamicFormField(
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
