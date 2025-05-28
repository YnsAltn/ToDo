import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/features/home/presentation/screens/add_spend/model/add_spend_model.dart';

class AddSpendService {
  final spendCollection = FirebaseFirestore.instance
      .collection('spends')
      .doc("userId") // bu kısımda userId'yi dinamik olarak almanız gerekiyor
      .collection('userSpends');

  Future<void> addSpend({
    required double spendMoney,
    required String spendDate,
    required String spendCategory,
    required String spendHead,
    required String spendDescription,
    required int spendId,
  }) async {
    try {
      await spendCollection.doc(spendId.toString()).set({
        'spendMoney': spendMoney,
        'spendDate': spendDate,
        'spendCategory': spendCategory,
        'spendHead': spendHead,
        'spendDescription': spendDescription,
        'spendId': spendId,
      });
    } catch (e) {
      debugPrint("Error adding spend: $e");
    }
  }

  Future<void> addSpendFromModel(AddSpendModel model) async {
    try {
      await spendCollection.doc(model.spendId.toString()).set(model.toJson());
    } catch (e) {
      debugPrint("Firestore ekleme hatası: $e");
    }
  }

  Future<List<AddSpendModel>> getAllSpends() async {
    try {
      final snapshot = await spendCollection.get();
      return snapshot.docs
          .map((doc) => AddSpendModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      debugPrint("Firestore getirme hatası: $e");
      return [];
    }
  }
}
