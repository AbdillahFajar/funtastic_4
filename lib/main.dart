import 'package:funtastic_4/data/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:funtastic_4/screens/splash_screen.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey);
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
        home: SplashScreen(),
      ),
    );
  }
}
