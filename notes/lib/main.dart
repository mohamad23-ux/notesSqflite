import 'dart:io';

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:notes/provider/caloriesProvider.dart';
import 'package:notes/provider/pro.dart';
import 'package:notes/service/gym/addexercise.dart';
import 'package:notes/service/subject/addSubject.dart';
import 'package:notes/service/subject/extrasubject.dart';
import 'package:notes/view/HomePage.dart';
import 'package:notes/service/notes/addnotes.dart';
import 'package:notes/view/caloriesCalc.dart';
import 'package:notes/view/extra/calc.dart';

import 'package:notes/view/extra/information.dart';
import 'package:notes/view/extra/seasons.dart';
import 'package:notes/view/extra/watch.dart';
import 'package:notes/view/gym.dart';
import 'package:notes/view/svu.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  initializeDateFormatting();

  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Pro()),
        ChangeNotifierProvider(create: (_) => Caloriesprovider()),
        //  ChangeNotifierProvider(create: (_) => caloriesCalc()),
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
    // PopupMenU.context = context;
    return MaterialApp(
      // locale: Locale('en'),
      // theme: ThemeData(fontFamily:ArabicTextStyle(arabicFont: arabicFont) ),
      debugShowCheckedModeBanner: false,
      title: 'Sigma Muslim',
      routes: {
        "addnotes": (context) => const addNotes(),
        "HomePage": (context) => const Homepage(),
        "SVU": (context) => const SVU(),
        "addSubject": (context) => const addSubject(),
        "gym": (context) => const Gym(),
        "addexercise": (context) => const addExercise(),
        "watch": (context) => const Watch(),
        "seasons": (context) => const Seasons(),
        "calc": (context) => const calc(),
      },
      theme: ThemeData(
          textTheme: Theme.of(context)
              .textTheme
              .apply(fontFamily: ArabicFont.avenirArabic)),
      home: const Homepage(),
    );
  }
}
