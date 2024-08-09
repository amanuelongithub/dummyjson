import 'dart:convert';

VideoDetailModel videoDetailModelFromJson(String str) => VideoDetailModel.fromJson(json.decode(str));

String videoDetailModelToJson(VideoDetailModel data) => json.encode(data.toJson());

class VideoDetailModel {
    final bool? success;
    final Data? data;

    VideoDetailModel({
        this.success,
        this.data,
    });

    factory VideoDetailModel.fromJson(Map<String, dynamic> json) => VideoDetailModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
    };
}

class Data {
    final String? id;
    final String? title;
    final String? videoUrl;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Data({
        this.id,
        this.title,
        this.videoUrl,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        title: json["title"],
        videoUrl: json["videoUrl"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "videoUrl": videoUrl,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
