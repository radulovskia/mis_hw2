import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hw2/data/workout_data.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox("workout_database");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutData(),
      child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
      )
    );
  }
}