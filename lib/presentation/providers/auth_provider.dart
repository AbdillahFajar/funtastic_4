import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repo;

  /// UID user yang sedang login (null jika logout)
  String? uid;

  /// State UI
  bool loading = false;
  String? error;

  /// Subscription untuk listener FCM token
  /// Disimpan agar bisa di-cancel saat logout
  StreamSubscription<String>? _fcmSub;

  AuthProvider(this._repo) {
    /// Listener perubahan status autentikasi Firebase
    /// Akan terpanggil saat:
    /// - login
    /// - logout
    /// - app dibuka ulang tapi user masih login
    _repo.authStateChanges().listen((u) async {
      uid = u;

      if (uid != null) {
        /// 1️⃣ Simpan token FCM yang sedang aktif (sekali)
        /// Penting untuk:
        /// - user lama
        /// - login ulang
        /// - kasus token belum pernah disimpan
        await _saveInitialFcmToken(uid!);

        /// 2️⃣ Dengarkan perubahan token di masa depan
        /// Misalnya:
        /// - user ganti device
        /// - reinstall app
        /// - Firebase rotasi token
        _listenFcmToken(uid!);
      } else {
        /// Jika logout:
        /// - hentikan listener agar tidak bocor
        _fcmSub?.cancel();
        _fcmSub = null;
      }

      notifyListeners();
    });
  }

  // =========================
  // 🔐 AUTH FUNCTIONS
  // =========================

  Future<void> signIn(String email, String password) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      uid = await _repo.signIn(email, password);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      uid = await _repo.signUp(email, password);
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _repo.signOut();
  }

  // =========================
  // 🔔 FCM FUNCTIONS
  // =========================

  /// 🔹 Fungsi ini dipanggil SEKALI setiap user login
  /// Tujuannya:
  /// - Mengambil token FCM yang sedang aktif
  /// - Menyimpannya ke Firestore
  ///
  /// Kenapa perlu?
  /// - onTokenRefresh TIDAK selalu terpanggil saat login
  /// - User lama bisa punya token tapi belum pernah disimpan
  Future<void> _saveInitialFcmToken(String uid) async {
    final token = await FirebaseMessaging.instance.getToken();

    if (token == null) return;

    await FirebaseFirestore.instance.collection('users').doc(uid).set(
      {'fcmToken': token},
      SetOptions(merge: true), // tidak menimpa field lain
    );
  }

  /// 🔹 Listener untuk perubahan token FCM
  /// Dipakai untuk jangka panjang selama user login
  ///
  /// Akan terpanggil jika:
  /// - user ganti device
  /// - reinstall aplikasi
  /// - Firebase memperbarui token
  void _listenFcmToken(String uid) {
    /// Pastikan tidak ada listener ganda
    _fcmSub?.cancel();

    _fcmSub = FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'fcmToken': token,
      }, SetOptions(merge: true));
    });
  }
}
