class CategoryResponseModel {
  final bool success;
  final List<CategoryItem> data;

  CategoryResponseModel({required this.success, required this.data});

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<CategoryItem> categoryList = list
        .map((i) => CategoryItem.fromJson(i))
        .toList();
    return CategoryResponseModel(
      success: json['success'] ?? false,
      data: categoryList,
    );
  }
}

class CategoryItem {
  final String id;
  final String title;

  CategoryItem({required this.id, required this.title});

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(id: json['_id'], title: json['title']);
  }
}
