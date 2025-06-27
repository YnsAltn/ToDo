import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/features/home/presentation/screens/add_task/model/task_model.dart';

class TaskService {
  Future<CollectionReference<Map<String, dynamic>>>
  _userTaskCollection() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final uid = prefs.getString('uid');

      if (uid == null) {
        debugPrint(
          'Kullanıcı ID bulunamadı. SharedPreferences kontrol ediliyor...',
        );
        // Tüm SharedPreferences değerlerini kontrol et
        final allPrefs = prefs.getKeys();
        debugPrint('Mevcut SharedPreferences anahtarları: $allPrefs');
        throw Exception("Lütfen önce giriş yapın");
      }

      return FirebaseFirestore.instance
          .collection('tasks')
          .doc(uid)
          .collection('userTasks');
    } catch (e) {
      debugPrint('TaskService - Koleksiyon oluşturma hatası: $e');
      rethrow;
    }
  }

  Future<void> addTask({
    required String title,
    required String description,
    required DateTime date,
    required String time,
    required String category,
  }) async {
    try {
      if (title.isEmpty) {
        throw Exception("Görev başlığı boş olamaz");
      }

      final collection = await _userTaskCollection();

      await collection.add({
        'title': title,
        'description': description,
        'date': date,
        'time': time,
        'category': category,
        'isCompleted': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('TaskService - Görev ekleme hatası: $e');
      rethrow;
    }
  }

  Future<List<TaskModel>> getAllTasks() async {
    try {
      final taskCollection = await _userTaskCollection();
      final snapshot = await taskCollection.get();
      return snapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      debugPrint("Firestore getirme hatası: $e");
      return [];
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      final taskCollection = await _userTaskCollection();
      await taskCollection.doc(task.taskId).update(task.toJson());
    } catch (e) {
      debugPrint("Firestore güncelleme hatası: $e");
      rethrow;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      final taskCollection = await _userTaskCollection();
      await taskCollection.doc(taskId).delete();
    } catch (e) {
      debugPrint("Firestore silme hatası: $e");
      rethrow;
    }
  }
}
