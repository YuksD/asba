import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:ilkproje/components/caller_info.dart';
import 'package:ilkproje/screens/gts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ilkproje/constants/last_caller.dart';
import 'package:ilkproje/constants/home_screen_strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ilkproje/models/login_model.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CallLogEntry> _callLogEntries = [];
  String isim = 'Ahmet';
  String numara = '05554443322';
  String sirket = 'Gediksiz';
  String sure = '671';
  String tarih = '2023-10-12 12:12:12';
  String saat = '10:10:10';

  String isim2 = 'Osman';
  String numara2 = '05255252525';
  String sirket2 = 'Sertel';
  String sure2 = '1322';
  String tarih2 = '2023-10-12 12:12:12';

  String konuAl = '';
  String aciklamaAl = '';
  

  @override
  void initState() {
    super.initState();
    _fetchCallLog(); // Uygulama başladığında çağrı kaydını getir.
  }

  Future<void> _fetchCallLog() async {
    final Iterable<CallLogEntry> entries = await CallLog.get();
    if (entries.isNotEmpty) {
      setState(() {
        _callLogEntries = entries.toList();
      });
    }
  }
  
  Future<void> _getCallerInfo(String phoneNumber, String konusmaSuresi, String konusmaTarihi, List<String> tarihVeSaat) async {

      // Telefon rehberinden kişiyi bul
      bool isGranted = await Permission.contacts.status.isGranted;
      if(!isGranted) {isGranted = await Permission.contacts.request().isGranted;}
      Iterable<Contact> contacts = await ContactsService.getContactsForPhone(phoneNumber);

      if (contacts.isNotEmpty) {
        // Son arayan kişinin bilgilerini al
        Contact lastCaller = contacts.first;
        setState(() {
          //konu =konuAl;
          tarih = tarihVeSaat[0];
          saat = tarihVeSaat[1];
          sure = konusmaSuresi;
          numara = phoneNumber;
          isim = lastCaller.displayName ?? LastCallerStrings.noData;
          sirket = lastCaller.company ?? LastCallerStrings.noData;
        });
      } else {
        // Eğer eşleşen kişi bulunamazsa, varsayılan değerleri kullan
        setState(() {
          isim = LastCallerStrings.noData;
          sirket = LastCallerStrings.noData;
          sure = minSec(sure);
        });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(HomeScreenStrings.title)),
      body: Center(
        child: SingleChildScrollView(
          child: Row(
            children: [
              //Container(child: GetSessionID(),),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // LastCallerInfo(
                  //   title: LastCallerStrings.name,
                  //   content: isim ?? LastCallerStrings.noData),
                  // spaceSmall(),
              
                  // LastCallerInfo(
                  //   title: LastCallerStrings.phoneNumber,
                  //   content: numara ?? LastCallerStrings.noData),
                  // spaceSmall(),
              
                  // LastCallerInfo(
                  //   title: LastCallerStrings.company,
                  //   content: sirket ?? LastCallerStrings.noData),
                  // spaceSmall(),
                      
                  // LastCallerInfo(
                  //   title: LastCallerStrings.callDuration,
                  //   content: minSec(sure??'6000')),
                  // spaceSmall(),
                  
                  // LastCallerInfo(
                  //   title: LastCallerStrings.callDate,
                  //   content: tarih ?? LastCallerStrings.noData),
                  // spaceSmall(),
              
                  // LastCallerInfo(
                  //   title: LastCallerStrings.callHour,
                  //   content: saat ?? LastCallerStrings.noData),
                  // spaceSmall(),
              
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8, // Ekranın yarısı kadar genişlik
                        child: TextField(
                          onChanged: (String metin){
                            konuAl = metin;
                            debugPrint(konuAl);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                            labelText: HomeScreenStrings.textBox1,
                              ),
                            ),
                          ),
                        spaceSmall(),
                      
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8, // Ekranın yarısı kadar genişlik
                        child: TextField(
                          onChanged: (String metin){
                            aciklamaAl = metin;
                          },                      
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                            labelText: HomeScreenStrings.textBox2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      spaceMedium(),
                      
                  // ElevatedButton(onPressed: () {
                  //   sure = minSec(sure).toString();
                  // }, child: Text('sure')),
                  ElevatedButton(
                    onPressed: () {
                      if (_callLogEntries.isNotEmpty) {
                        
                        String phoneNumber = _callLogEntries.first.number ?? LastCallerStrings.noData;
                        String konusmaSuresi = _callLogEntries.first.duration.toString();
                        String konusmaTarihi = DateTime.fromMillisecondsSinceEpoch(_callLogEntries.first.timestamp?? 1635400000000)
                        .toLocal().toString().split('.')[0].toString();
                        List<String>tarihVeSaat =konusmaTarihi.split(' ');
                        _getCallerInfo(phoneNumber,konusmaSuresi,konusmaTarihi,tarihVeSaat);}
                      else {sirket = LastCallerStrings.emptyCallLog;}
                    },
                    child: const Text(HomeScreenStrings.pullLastCallerButton),
                  ),
                  GetSessionID(saat: saat, konu: konuAl,aciklama: aciklamaAl,sure: sure, tarih: tarih),
                  
                  ElevatedButton(onPressed: () {
                     isim = isim2;
                     numara = numara2;
                     sirket = sirket2;
                     sure = sure2;
                     tarih = tarih2; 
                  }, child: const Text('İkinci Faz'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  SizedBox spaceMedium() => const SizedBox(height: 20);
  SizedBox spaceSmall() => const SizedBox(height: 10);
  
}

// void minSec(int saniye) {
//   double dakikaKusurat = saniye/60;
//   int dakika = dakikaKusurat.toInt();
// }
String minSec(String stringSaniye) {
  int saniye = int.parse(stringSaniye);
  int dakika = saniye ~/ 60; // Saniyeleri dakika cinsinden hesapla
  int kalanSaniye = saniye % 60; // Kalan saniyeleri hesapla

  return '$dakika.$kalanSaniye';
}


// class GetSessionID extends StatefulWidget {
//   const GetSessionID({super.key});

//   @override
//   State<GetSessionID> createState() => _GetSessionIDState();
// }

// class _GetSessionIDState extends State<GetSessionID> {
//   String? session_id;

//   Future PostLogin() async {
//   try{
//   //String session_id = ""; // SESSION ID MANUEL YAZILMALI
//   //int firma_kodu = 34;
//   //int donem_kodu = 1;

//   String wsAdres = "https://erten.ws.dia.com.tr/api/v3/sis/json";
//   String wsInput = """
//     {"login" :
//         {"username": "wsuser",
//          "password": "ws123",
//          "disconnect_same_user": true,
//          "lang": "tr", 
//          "params": {"apikey": "bfe21eb6-492c-444e-aa06-a4d1dd170ca9"}
//         }
//     }
//   """;

//   var response = await http.post(
//     Uri.parse(wsAdres),
//     headers: {"Content-Type": "application/json;charset=UTF-8"},
//     body: wsInput,
//   );

//   if (response.statusCode == 200) {
//     debugPrint(response.body);
//     Map<String, dynamic> jsonResponse = json.decode(response.body);
//     session_id = jsonResponse["msg"];
//     debugPrint(session_id);

//   } else {
//     debugPrint("Error: ${response.statusCode}");
//   }} catch(e) {
      
//        debugPrint(e.toString());

//   }
// }



//   Future PostGtsNotlarEkle() async {
//   try{
//   //String session_id = ""; // SESSION ID MANUEL YAZILMALI
//   int firma_kodu = 15;
//   int donem_kodu = 5;

//   String wsAdres = "https://erten.ws.dia.com.tr/api/v3/gts/json";
//   String wsInput = """
//     {"gts_notlar_ekle" :
//     {"session_id": "{$session_id}",
//      "firma_kodu": {$firma_kodu},
//      "donem_kodu": {$donem_kodu},
//      "kart":
//               {
//               "_key_gts_gorev": 0,
//               "_key_gts_gorusme_kategori": 0,
//               "_key_gts_gorusme_kategorileri": null,
//               "_key_scf_carikart": {"carikartkodu": "0000008"},
//               "_key_scf_satiselemani": 0,
//               "_key_scf_siparis": 0,
//               "_key_scf_teklif": 0,
//               "_key_shy_servisformu": {"fisno": "000009"},
//               "_key_sis_kullanici": {"kullaniciadi": "ws"},
//               "_key_sis_rehber_karti": 0,
//               "_key_sis_seviyekodu": 0,
//               "gorusmesekli": 1,
//               "harcananzaman": "17.00",
//               "harcananzamanturu": "D",
//               "konu": "enerciii",
//               "note": "burasi degistiyse bu is tamamdir",
//               "saat": "15:55:18",
//               "tarih": "2017-03-25"
//               }

//     }
// }
//   """;

//   var response = await http.post(
//     Uri.parse(wsAdres),
//     headers: {"Content-Type": "application/json;charset=UTF-8"},
//     body: wsInput,
//   );

//   if (response.statusCode == 200) {
//     debugPrint(response.body);
//     Map<String, dynamic> jsonResponse = json.decode(response.body);
//     session_id = jsonResponse["msg"];
//     debugPrint(session_id);

//   } else {
//     debugPrint("Error: ${response.statusCode}");
//   }} catch(e) {
      
//        debugPrint(e.toString());

//   }
// }



//   @override
//   Widget build(BuildContext context) {
//     return Column(
//        children: [
//          ElevatedButton(onPressed: PostLogin, child: Text('POST LOGIN')),
        
//          Container(color: Colors.blue,height: 200,width: 200),
//        ],
//      );
//   }
// }
