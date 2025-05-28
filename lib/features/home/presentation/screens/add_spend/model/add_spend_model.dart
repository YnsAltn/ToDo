import 'dart:convert';

class AddSpendModel {
  final double spendMoney;
  final String spendDate;
  final String spendCategory;
  final String spendHead;
  final String spendDescription;
  final int spendId;

  AddSpendModel({
    required this.spendMoney,
    required this.spendDate,
    required this.spendCategory,
    required this.spendHead,
    required this.spendDescription,
    required this.spendId,
  });

  Map<String, dynamic> toJson() {
    return {
      'spendMoney': spendMoney,
      'spendDate': spendDate,
      'spendCategory': spendCategory,
      'spendHead': spendHead,
      'spendDescription': spendDescription,
      'spendId': spendId,
    };
  }

  factory AddSpendModel.fromJson(Map<String, dynamic> json) {
    return AddSpendModel(
      spendMoney: (json['spendMoney'] ?? 0).toDouble(),
      spendDate: json['spendDate'] ?? "",
      spendCategory: json['spendCategory'] ?? "",
      spendHead: json['spendHead'] ?? "",
      spendDescription: json['spendDescription'] ?? "",
      spendId: json['spendId'] ?? 0,
    );
  }

  static List<AddSpendModel> listFromJson(String jsonString) {
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => AddSpendModel.fromJson(e)).toList();
  }

  static String listToJson(List<AddSpendModel> spends) {
    final List<Map<String, dynamic>> jsonList =
        spends.map((e) => e.toJson()).toList();
    return jsonEncode(jsonList);
  }
}
