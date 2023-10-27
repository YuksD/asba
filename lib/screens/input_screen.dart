// import 'package:flutter/material.dart';

// class InputScreen extends StatefulWidget {
//   @override
//   _InputScreenState createState() => _InputScreenState();
// }

// class _InputScreenState extends State<InputScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController numberController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Arama Bilgileri Girişi')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(labelText: 'Aranan Kişi'),
//             ),
//             TextField(
//               controller: numberController,
//               decoration: InputDecoration(labelText: 'Numara'),
//             ),
//             ElevatedButton(
//   onPressed: () {
//     Navigator.pushNamed(
//       context,
//       '/home',
//       arguments: {
//         'callerName': nameController.text,
//         'callerNumber': numberController.text,
//       },
//     );
//   },
//   child: Text('Görüntüle'),
// )

//           ],
//         ),
//       ),
//     );
//   }
// }
