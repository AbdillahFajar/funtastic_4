import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:funtastic_4/main.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({super.key});

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  // menyiapkan variable yang akan di isi melalui data notification final.
  String _message = "Belum ada notifikasi"; //isi awal

  @override
  void initState() {
    super.initState();
    //panggil fungsi FCM (Firebase Cloud Message)
    setupFCM();
  }

  Future<void> setupFCM() async {
    //Fungsi ini akan:
    //1. Melakukan konfigurasi FCM
    print("Menyiapkan Firebase Cloud Messaging");
    final messaging = FirebaseMessaging.instance;

    //2. Meminta izin user agar notifikasi bisa muncul di hapenya
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print("Status izin: ${settings.authorizationStatus}");

    //Bikin pemberitahuan ketika izin notifikasi ditolak
    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      print("User menolak izin notifikasi");

      setState(() {
        _message =
            "Izin notifikasi aplikasi ditolak. Silahkan aktifkan di pengaturan Android/IOS Anda";
      });
      return; //Hentikan setup FCM
    }

    //3. Mendapatkan token FCM. Disclaimer: Token ini bukanlah Access Token dan token ini hanya untuk satu akun user yang login saja, yang terdaftar di firebase authentication dan firestore collection users
    String? token = await messaging.getToken();
    print(
      "TOKEN SAYA:$token",
    ); //Jangan lupa untuk copy token ini agar bisa melakukan tes notifikasi di firebase messaging atau dari postman

    //Tampilkan pesan notifikasi ketika aplikasi dalam keadaan terminated (lagi gak dipakai)
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();

    if (initialMessage != null && initialMessage.notification != null) {
      setState(() {
        _message =
            "${initialMessage.notification!.title}\n${initialMessage.notification!.body}";
      });
    }

    //Tampilkan pesan notifikasi ketika aplikasi dalam keadaan background (sedang dipakai, tapi user lagi gak ada di dalam aplikasinya)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notif diklik dari background");
      if (message.notification != null) {
        setState(() {
          _message =
              "${message.notification!.title}\n${message.notification!.body}";
        });
      }
    });

    //4. Menerima notifikasi saat aplikasi sedang dalam situasi foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Menerima pesan foreground:${message.messageId}");
      RemoteNotification? remoteNotification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;

      if (message.notification != null) {
        setState(() {
          _message =
              "${message.notification!.title}\n${message.notification!.body}";
        });

        try {
          // Tampilkan notifikasi di bar hape user.
          flutterLocalNotificationsPlugin.show(
            remoteNotification!.hashCode,
            remoteNotification.title,
            remoteNotification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channelId.id,
                channelId.name,
                channelDescription: channelId.description,
                icon: androidNotification?.smallIcon ?? '@mipmap/ic_launcher',
                importance: Importance.max,
                priority: Priority.high,
                showWhen: true,
              ),
            ),
          );
          print(
            "Notifikasi foreground ditampilkan: ${remoteNotification.title}",
          );
        } catch (e) {
          print("Error saat menampilkan notifikasi foreground: $e");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          _message, //tampilkan pesan notifikasinya di sini
          style: TextStyle(fontSize: 15),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
