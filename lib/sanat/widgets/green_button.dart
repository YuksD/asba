import 'package:flutter/material.dart';

class GreenButton extends StatelessWidget {
  const GreenButton({super.key, required this.buton_adi, required this.isUseable});

    final String buton_adi;
    final bool isUseable;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

            style: ElevatedButton.styleFrom(
              
              backgroundColor: (isUseable == true) ? Color.fromARGB(255, 24, 147, 124): const Color.fromARGB(5, 24, 147, 124), // Arka plan rengi
              foregroundColor: Colors.white, 
              side: BorderSide(color: Colors.white, width: 1.8, ),
              elevation: 1
          

               
            ),
            onPressed: () {              
            },
            child: Text(buton_adi, style: TextStyle(letterSpacing: 1, fontSize: 15)),
          );
  }
}