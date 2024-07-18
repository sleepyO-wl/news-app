import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

import 'package:news_app/screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/services/auth_service.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => AuthService(),
        ),
        Provider(
          create: (_) => NewsService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyNews',
      theme: theme,
      initialRoute: '/',
      routes: {
        '/': (context) => AuthScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
