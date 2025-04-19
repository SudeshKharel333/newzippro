class Notice {
  int? id;
  String? title;
  String? description;
  String? image;
  String? publishDate;
  String? createdAt;
  String? updatedAt;

  Notice(
      {this.id,
        this.title,
        this.description,
        this.image,
        this.publishDate,
        this.createdAt,
        this.updatedAt});

  // Notice.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   title = json['title'];
  //   description = json['description'];
  //   image = json['image'];
  //   publishDate = json['publish_date'];
  //   createdAt = json['created_at'];
  //   updatedAt = json['updated_at'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = id;
  //   data['title'] = title;
  //   data['description'] = description;
  //   data['image'] = image;
  //   data['publish_date'] = publishDate;
  //   data['created_at'] = createdAt;
  //   data['updated_at'] = updatedAt;
  //   return data;
  // }
}