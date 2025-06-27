import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/features/auth/presentation/screens/login/model/login_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/features/auth/presentation/screens/login/service/login_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> createUser({
    required String email,
    required String password,
  }) async {
    final UserCredential credential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    final User? user = credential.user;
    if (user == null) debugPrint("Kullanıcı Oluşturulamadı.");
  }

  Future<LoginModel> signIn({
    required String email,
    required String password,
  }) async {
    final UserCredential credential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    final User? user = credential.user;

    if (user == null) debugPrint('Kullanıcı bulunamadı');

    final userToken = await user?.getIdToken();
    final uid = user?.uid ?? '';

    debugPrint("🔥 Token başarıyla alındı: $userToken");
    debugPrint("🔐 Kullanıcı UID: $uid");

    await saveUserData(email: email, uid: uid, userToken: userToken ?? '');

    return LoginModel(
      email: email,
      password: password,
      userToken: userToken ?? '',
    );
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
    if (gUser == null) return null;
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    final UserCredential userCredential = await _firebaseAuth
        .signInWithCredential(credential);

    final user = userCredential.user;
    final userToken = await user?.getIdToken();
    final uid = user?.uid ?? '';

    if (user != null) {
      await saveUserData(
        email: user.email ?? '',
        uid: uid,
        userToken: userToken ?? '',
      );
    }

    return user;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  Future<void> saveUserData({
    required String email,
    required String uid,
    required String userToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('uid', uid);
    await prefs.setString('userToken', userToken);
  }
}
