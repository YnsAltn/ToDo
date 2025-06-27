import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/features/home/presentation/screens/add_spend/model/add_spend_model.dart';

class AddSpendService {
  Future<CollectionReference<Map<String, dynamic>>>
  _userSpendCollection() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('uid');

    if (uid == null) throw Exception("Kullanıcı ID'si bulunamadı");

    return FirebaseFirestore.instance
        .collection('spends')
        .doc(uid)
        .collection('userSpends');
  }

  Future<void> addSpend({
    required double spendMoney,
    required String spendDate,
    required String spendCategory,
    required String spendHead,
    required String spendDescription,
    required int spendId,
  }) async {
    try {
      final spendCollection = await _userSpendCollection();
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
      final spendCollection = await _userSpendCollection();
      await spendCollection.doc(model.spendId.toString()).set(model.toJson());
    } catch (e) {
      debugPrint("Firestore ekleme hatası: $e");
    }
  }

  Future<List<AddSpendModel>> getAllSpends() async {
    try {
      final spendCollection = await _userSpendCollection();
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
