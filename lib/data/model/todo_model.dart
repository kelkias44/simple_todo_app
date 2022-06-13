
import 'dart:convert';

Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

String todoToJson(Todo data) => json.encode(data.toJson());

class Todo{
    Todo({
        required this.id,
        required this.title,
        required this.description,
        required this.date,
        required this.assignedTo,
        this.createdAt,
        this.owner,
        this.status
    });
    String id;
    String? status;
    String? createdAt;
    String? owner;
    String title;
    String description;
    String date;
    String assignedTo;

    factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        date: json["date"],
        status: json["status"],
        assignedTo: json["assignedTo"],
        createdAt: json["createdAt"],
        owner: json["owner"],


    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date,
        "status": status,
        "assignedTo": assignedTo,
        "createdAt": createdAt,
        "owner": owner,
    };
}