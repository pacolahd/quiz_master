import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as fui;
import 'package:flutter/material.dart';
import 'package:pacola_quiz/core/common/app/providers/theme_provider.dart';
import 'package:pacola_quiz/core/common/app/providers/user_provider.dart';
import 'package:pacola_quiz/core/resources/theme/app_theme.dart';
import 'package:pacola_quiz/core/services/injection_container.dart';
import 'package:pacola_quiz/core/services/router.dart';
import 'package:pacola_quiz/firebase_options.dart';
import 'package:pacola_quiz/src/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // ensure that the widgets binding is initialized before we call the init function
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Failed to initialize Firebase: $e');
  }
  fui.FirebaseUIAuth.configureProviders([(fui.EmailAuthProvider())]);

  // initialize the dependency injection container
  await init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardController(),
        ),

        // Add more providers here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pacola Quiz',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.watch<ThemeProvider>().themeMode,
      // home: const OnBoardingScreen(),
      onGenerateRoute: generateRoute,
    );
  }
}
