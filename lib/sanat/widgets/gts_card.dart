import 'package:flutter/material.dart';

class GTSCard extends StatelessWidget {
  const GTSCard({super.key, required this.title, required this.subtitle, required this.iconData});
    final String title;
    final String subtitle;
    final IconData iconData;
    

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: const Color.fromARGB(255, 24, 147, 124),
      child: SizedBox(width: 180,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
            
            textColor: Color.fromARGB(255, 24, 147, 124),
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            title: Text(title,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14)),
            subtitle: Text(subtitle,style: TextStyle(fontSize: 13)),
            iconColor: Color.fromARGB(255, 24, 147, 124),
            tileColor: Color.fromARGB(255, 244, 249, 248),
            leading: Icon(iconData,size: 30),
          
          
                ),
        ),
      ),
          );
  }
}