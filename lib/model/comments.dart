// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'dart:convert';

CommentsModel commentsModelFromJson(String str) => CommentsModel.fromJson(json.decode(str));

String commentsModelToJson(CommentsModel data) => json.encode(data.toJson());

class CommentsModel {
    final List<Comment>? comments;
    final int? total;
    final int? skip;
    final int? limit;

    CommentsModel({
        this.comments,
        this.total,
        this.skip,
        this.limit,
    });

    factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
    };
}

class Comment {
    final int? id;
    final String? body;
    final int? postId;
    final int? likes;
    final User? user;

    Comment({
        this.id,
        this.body,
        this.postId,
        this.likes,
        this.user,
    });

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        body: json["body"],
        postId: json["postId"],
        likes: json["likes"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "postId": postId,
        "likes": likes,
        "user": user?.toJson(),
    };
}

class User {
    final int? id;
    final String? username;
    final String? fullName;

    User({
        this.id,
        this.username,
        this.fullName,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        fullName: json["fullName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "fullName": fullName,
    };
}
