import 'package:intl/intl.dart';

class MyDocumentsResponseModel {
  final bool success;
  final List<DocumentItem> data;

  MyDocumentsResponseModel({required this.success, required this.data});

  factory MyDocumentsResponseModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<DocumentItem> documentList = list
        .map((i) => DocumentItem.fromJson(i))
        .toList();
    return MyDocumentsResponseModel(
      success: json['success'] ?? false,
      data: documentList,
    );
  }
}

class DocumentItem {
  final String id;
  final String title;
  final String sortDescription;
  final String detailDescription;
  final List<String> documentPaths;
  final CategoryInfo category;
  final UserInfo user;
  final DateTime createdAt;

  DocumentItem({
    required this.id,
    required this.title,
    required this.sortDescription,
    required this.detailDescription,
    required this.documentPaths,
    required this.category,
    required this.user,
    required this.createdAt,
  });

  // A helper getter to format the date nicely
  String get formattedDate {
    return DateFormat('EEEE, d MMMM').format(createdAt);
  }

  factory DocumentItem.fromJson(Map<String, dynamic> json) {
    return DocumentItem(
      id: json['_id'],
      title: json['title'] ?? 'No Title',
      sortDescription: json['sortDescription'] ?? '',
      detailDescription: json['detailDescription'] ?? '',
      documentPaths: List<String>.from(json['document'] ?? []),
      category: CategoryInfo.fromJson(json['category'] ?? {}),
      user: UserInfo.fromJson(json['user'] ?? {}),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class CategoryInfo {
  final String id;
  final String title;

  CategoryInfo({required this.id, required this.title});

  factory CategoryInfo.fromJson(Map<String, dynamic> json) {
    return CategoryInfo(
      id: json['_id'] ?? '',
      title: json['title'] ?? 'Uncategorized',
    );
  }
}

class UserInfo {
  final String id;
  final String email;

  UserInfo({required this.id, required this.email});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(id: json['_id'] ?? '', email: json['email'] ?? '');
  }
}
