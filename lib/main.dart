import 'package:flutter/material.dart';
import 'package:ilkproje/sanat/sanat.dart';
import 'package:ilkproje/screens/gts.dart';
import 'package:ilkproje/screens/tasarim/tasarim.dart';
import 'package:ilkproje/taslaklar/http_get_post.dart';
import 'screens/home_screen.dart';
//import 'screens/input_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arama Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => SanatSepet(),
       // '/home': (context) => HomeScreen(),

        //'/input': (context) => InputScreen(), // Giriş ekranını başlatan rota
      },
    );
  }
}
