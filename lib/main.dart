import 'package:drift/native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_mate/const/provider_classes.dart';
import 'package:lift_mate/screen/home_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lift_mate/database/drift_database.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final database = LocalDatabase();
  //final database = LocalDatabase(NativeDatabase.memory());

  GetIt.I.registerSingleton<LocalDatabase>(database);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FitnessLogProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExerciseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => StateProvider(),
        ),
      ],
      child: MaterialApp(
        home: const HomeScreen(),
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
          ),
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ko', ''),
          Locale('en', ''),
        ],
      ),
    ),
  );
}
