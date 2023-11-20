import 'package:flutter/material.dart';

class Baslik extends StatelessWidget {
  const Baslik({super.key, required this.baslik});
    final String baslik;

  @override
  Widget build(BuildContext context) {
    return Text(baslik, 
            style:TextStyle(
              fontWeight: FontWeight.bold, 
              color: const Color.fromARGB(255, 232, 245, 243),
              letterSpacing: 0.7, 
              shadows: List.filled(2, const Shadow(blurRadius: 0.5, color: Color.fromARGB(255, 177, 185, 182))) ), );
  }
}