import 'dart:convert';

VideosModel videosModelFromJson(String str) => VideosModel.fromJson(json.decode(str));

String videosModelToJson(VideosModel data) => json.encode(data.toJson());

class VideosModel {
    final bool? success;
    final int? count;
    final Pagination? pagination;
    final List<Datum>? data;

    VideosModel({
        this.success,
        this.count,
        this.pagination,
        this.data,
    });

    factory VideosModel.fromJson(Map<String, dynamic> json) => VideosModel(
        success: json["success"],
        count: json["count"],
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "count": count,
        "pagination": pagination?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    final String? id;
    final String? title;
    final DateTime? createdAt;

    Datum({
        this.id,
        this.title,
        this.createdAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        title: json["title"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "createdAt": createdAt?.toIso8601String(),
    };
}

class Pagination {
    final int? currentPage;
    final int? pageLimit;
    final int? totalItems;
    final int? totalPages;

    Pagination({
        this.currentPage,
        this.pageLimit,
        this.totalItems,
        this.totalPages,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["currentPage"],
        pageLimit: json["pageLimit"],
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "pageLimit": pageLimit,
        "totalItems": totalItems,
        "totalPages": totalPages,
    };
}
