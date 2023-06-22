import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:juridentt/authentication/login/login.dart';
import 'package:juridentt/home.dart';
import 'package:juridentt/router.dart';
import 'package:provider/provider.dart';
import 'addcase/newcase_form.dart';
import 'addcase/provider.dart';
import 'provider1.dart';
import 'firebase_options.dart';

import 'package:firebase_performance/firebase_performance.dart'
    as firebase_performance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  firebase_performance.FirebasePerformance.instance
      .setPerformanceCollectionEnabled(true);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        // ChangeNotifierProvider<NewCaseFormProvider>(
        //   create: (context) => NewCaseFormProvider(),
        // ),
        ChangeNotifierProvider(create: (context) => ThemeChanger()),
        ChangeNotifierProvider(
          create: (context) => CaseFormState(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) => generateRoute(settings),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const Homescreen();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error} occured'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
