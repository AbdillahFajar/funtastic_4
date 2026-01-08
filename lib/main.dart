import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:funtastic_4/data/services/user_service.dart';
import 'package:funtastic_4/presentation/screens/app_entry.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/env.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/repositories/auth_repository.dart';
import 'data/services/firestore_service.dart';
import 'data/services/auth_service.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/profile_provider.dart';
import 'data/services/storage_service.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//Persiapan untuk proyek flutter menerima notifikasi ketika dalam situasi background (aplikasi masih digunakan tapi sedang di-minimize) atau saat terminated (aplikasi sedang tidak digunakan). 
//Harapan : Notifikasinya muncul di bar hape android

//Start
//1. Inisialisasi plugin FlutterLocalNotificationsPlugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//2. Definisikan AndroidNotificationChannel untuk membuat channel notifikasi android, agar pada saat pengiriman notifikasi, data yang dikirim, sesuai dengan channelId
const AndroidNotificationChannel channelId = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

//3. Tambahkan fungsi khusus untuk menerima notifikasi saat aplikasi sedang dalam situasi background atau terminate
@pragma('vm: entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //4. Lakukan lagi inisilasisasi Firebase, karena proses penerimaan notifikasi ini terpisah dengan proses load aplikasi dengan fungsi main
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Menangani pesan background:${message.messageId}");
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey);

  //Set up proyek agar bisa menerima notifikasi dengan situasi background atau terminate
  //1. Panggil fungsi _firebaseMessagingBackgroundHandler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //2. Panggil channel notifikasi untuk android yang sudah dibuat tadi
  await flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>() ?.createNotificationChannel(channelId);
  
  //3. Inisialisasi plugin AndroidInitializationSettings untuk inisialisasi aplikasi ketika notifikasi muncul di hape Android
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
    // 'assets/icons/note.png' //inisialisasinya dengan menambahakn ikon aplikasi
    '@mipmap/ic_launcher' // pake default ikon dari flutter kalo gak bisa pake ikon aplikasi sendiri
  );

  //3.1 (Opsional): Inisialisasi plugin DarwinInitializationSettings untuk inisialisasi aplikasi ketika notifikasi muncul di hape IOS
  const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings();

  //4. Cocokkan plugin inisialisasi tadi sesuai dengan OS:
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin
  );

  //5. 
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
      //
      print("Notification tapped: ${notificationResponse.payload}");
    },
  );
  //END

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepo = AuthService();
    final UserRepository userRepo = FirestoreService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authRepo)),
        ChangeNotifierProvider(create: (_) => ProfileProvider(userRepo)),
        Provider<StorageService>(create: (_) => StorageService()),
        Provider<UserService>(create: (_) => UserService())
      ],
      child: MaterialApp(
        title: 'Simple Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF0D47A1)),
          fontFamily: "Poppins",
        ),
        home: AppEntry(),
      ),
    );
  }
}
