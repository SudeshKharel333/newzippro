class SliderResponse {
  int? id;
  String? sliderName;
  String? sliderImage;
  String? creationDate;

  SliderResponse(
      {this.id, this.sliderName, this.sliderImage, this.creationDate});

  SliderResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sliderName = json['slider_name'];
    sliderImage = json['slider_image'];
    creationDate = json['creationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slider_name'] = sliderName;
    data['slider_image'] = sliderImage;
    data['creationDate'] = creationDate;
    return data;
  }
}
