import 'dart:convert';

class FeedModel {
    String name;
    String location;
    String imageUrl;

    FeedModel({
        required this.name,
        required this.location,
        required this.imageUrl,
    });

    FeedModel copyWith({
        String? name,
        String? location,
        String? imageUrl,
    }) => 
        FeedModel(
            name: name ?? this.name,
            location: location ?? this.location,
            imageUrl: imageUrl ?? this.imageUrl,
        );

    factory FeedModel.fromRawJson(String str) => FeedModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        name: json["name"],
        location: json["location"],
        imageUrl: json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
        "imageUrl": imageUrl,
    };
}
