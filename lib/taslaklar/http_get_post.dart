// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:ilkproje/models/login_model.dart';

// import 'dart:convert';
 
// postGtsNotlarEkle () async {
//   var response = await http
//   .post(Uri.parse('https://erten.ws.dia.com.tr/api/v3/gts_notlar_ekle/json'), body:
//   {
//       "gts_notlar_ekle": {
//         "session_id": "", // sessionId
//         "firma_kodu": 15,
//         "donem_kodu": 5,
//         "kart": {
//           "_key_gts_gorev": 0,
//           "_key_gts_gorusme_kategori": 0,
//           "_key_gts_gorusme_kategorileri": null,
//           "_key_scf_carikart": {"carikartkodu": "0000008"}, // ??? isim-sirket ???
//           "_key_scf_satiselemani": 0,
//           "_key_scf_siparis": 0,
//           "_key_scf_teklif": 0,
//           "_key_shy_servisformu": {"fisno": "000009"},
//           "_key_sis_kullanici": {"kullaniciadi": "ws"},// Arzu AYVAZ
//           "_key_sis_rehber_karti": 0,
//           "_key_sis_seviyekodu": 0,
//           "gorusmesekli": 1,
//           "harcananzaman": 0, // sure
//           "harcananzamanturu": "D",
//           "konu": "Parça değişimi hakkında", // konuAl
//           "note": "yanlış getirilen parçanın yenisi ile değişimi", // aciklamaAl
//           "saat": "15:55:18", // saat
//           "tarih": "2017-03-25" // tarih
//         }
//       }
//     }
//    );
// }

// class GetSessionID extends StatefulWidget {
//   const GetSessionID({super.key});

//   @override
//   State<GetSessionID> createState() => _GetSessionIDState();
// }

// class _GetSessionIDState extends State<GetSessionID> {
//   String? sessionId;

//   Future postLogin () async {
//     try {
//   final response = await http
//     .post(Uri.parse('https://erten.ws.dia.com.tr/api/v3/sis/json'), body:
//       {"login" :
//         {"username": "wsuser",
//         "password": "ws123",
//         "disconnect_same_user": true,
//         "lang": "tr", 
//         "params": {"apikey": "bfe21eb6-492c-444e-aa06-a4d1dd170ca9"}
//         }
//     }
//     );
//     if (response.statusCode == 200) {
//         var result = loginFromJson(response.body);
//         if (result != null) {
//           setState(() {
            
//             debugPrint(result.toString());
//           });
//         }
//       }
      
//     } catch (e) {
      
//       debugPrint(e.toString());
      
//     }

// }
//   @override
//   void initState() {

//     super.initState();
//     postLogin();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton(onPressed: postLogin, child: Text('POST LOGIN')),
//         ElevatedButton(onPressed: postGtsNotlarEkle, child: Text('GTS LOGIN')),
        
//         Container(color: Colors.red,height: 200,width: 200),
//       ],
//     );
//   }
// }



// void main() async {
//   String session_id = ""; // SESSION ID MANUEL YAZILMALI
//   int firma_kodu = 34;
//   int donem_kodu = 1;

//   String wsAdres = "https://diademo.ws.dia.com.tr/api/v3/sis/json";
//   String wsInput = """
//     {"login" :
//         {"username": "ws",
//          "password": "ws",
//          "disconnect_same_user": true,
//          "lang": "tr", 
//          "params": {"apikey": ""}
//         }
//     }
//   """;

//   var response = await http.post(
//     Uri.parse(wsAdres),
//     headers: {"Content-Type": "application/json;charset=UTF-8"},
//     body: wsInput,
//   );

//   if (response.statusCode == 200) {
//     print(response.body);
//   } else {
//     print("Error: ${response.statusCode}");
//   }
// }