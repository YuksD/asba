import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
//import 'screens/input_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arama Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        //'/input': (context) => InputScreen(), // Giriş ekranını başlatan rota
      },
    );
  }
}
