// To parse this JSON data, do
//
//     final chatMessage = chatMessageFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChatMessage chatMessageFromJson(String str) => ChatMessage.fromJson(json.decode(str));

String chatMessageToJson(ChatMessage data) => json.encode(data.toJson());

class ChatMessage {
    ChatMessage({
        @required this.id,
        @required this.parentId,
        @required this.message,
    });

    int? id;
    int? parentId;
    String? message;

    factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        id: json["id"] == null ? null : json["id"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        message: json["message"] == null ? null : json["message"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "parent_id": parentId == null ? null : parentId,
        "message": message == null ? null : message,
    };
}
