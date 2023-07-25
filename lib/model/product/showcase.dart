class ShowCaseData {
  ShowCaseData({
    this.id,
    this.type,
    this.key,
    this.title,
    this.description,
    this.link,
    this.cssClass,
    this.cssItemClass,
    this.image,
    this.contentId,
    this.createdAt,
    this.updatedAt,
    this.content,
  });

  int? id;
  int? type;
  String? key;
  String? title;
  String? description;
  String? link;
  dynamic? cssClass;
  dynamic? cssItemClass;
  dynamic? image;
  dynamic? contentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic? content;

  factory ShowCaseData.fromJson(Map<String, dynamic> json) => ShowCaseData(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        key: json["key"] == null ? null : json["key"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        link: json["link"] == null ? null : json["link"],
        cssClass: json["css_class"],
        cssItemClass: json["css_item_class"],
        image: json["image"],
        contentId: json["content_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "key": key == null ? null : key,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "link": link == null ? null : link,
        "css_class": cssClass,
        "css_item_class": cssItemClass,
        "image": image,
        "content_id": contentId,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "content": content,
      };
}
