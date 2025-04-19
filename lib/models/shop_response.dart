class Categories {
  int? id;
  String? categoryName;
  String? categoryDescription;
  String? creationDate;
  String? updationDate;

  Categories(
      {this.id,
        this.categoryName,
        this.categoryDescription,
        this.creationDate,
        this.updationDate});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    categoryDescription = json['categoryDescription'];
    creationDate = json['creationDate'];
    updationDate = json['updationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryName'] = categoryName;
    data['categoryDescription'] = categoryDescription;
    data['creationDate'] = creationDate;
    data['updationDate'] = updationDate;
    return data;
  }
}


class Products {
  int? id;
  int? category;
  int? subCategory;
  String? productName;
  int? productPrice;
  int? productPriceBeforeDiscount;
  String? productImage1;
  String? productImage2;
  String? productImage3;

  Products(
      {this.id,
        this.category,
        this.subCategory,
        this.productName,
        this.productPrice,
        this.productPriceBeforeDiscount,
        this.productImage1,
        this.productImage2,
        this.productImage3});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    subCategory = json['subCategory'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    productPriceBeforeDiscount = json['productPriceBeforeDiscount'];
    productImage1 = json['productImage1'];
    productImage2 = json['productImage2'];
    productImage3 = json['productImage3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['subCategory'] = subCategory;
    data['productName'] = productName;
    data['productPrice'] = productPrice;
    data['productPriceBeforeDiscount'] = productPriceBeforeDiscount;
    data['productImage1'] = productImage1;
    data['productImage2'] = productImage2;
    data['productImage3'] = productImage3;
    return data;
  }
}

