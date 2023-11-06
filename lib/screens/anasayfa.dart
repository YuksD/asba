import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:ilkproje/components/caller_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ilkproje/constants/last_caller.dart';
import 'package:ilkproje/constants/home_screen_strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  List<CallLogEntry> _callLogEntries = [];
  String isim = 'Abuziddin';
  String numara = '05554443322';
  String sirket = 'taksabaklak';
  String sure = '671';
  String tarih = '11:11:1111 11:11';

  @override
  void initState() {
    super.initState();
    _fetchCallLog(); // Uygulama başladığında çağrı kaydını getir.
  }
    Future<void> sendHttpRequest() async {
    String sURL = "https://diademo.ws.dia.com.tr/api/v3/gts/json  DEGISTIRILECEK";

    var headers = {
      'Content-Type': 'application/json',
    };

    // SESSION ID MANUEL YAZILMALI
    var jsonWS = {
      "gts_notlar_ekle": {
        "session_id": "", // Session ID'yi güncelleyin
        "firma_kodu": 34,
        "donem_kodu": 1,
        "kart": {
          "_key_gts_gorev": 0,
          "_key_gts_gorusme_kategori": 0,
          "_key_gts_gorusme_kategorileri": null,
          "_key_scf_carikart": {"carikartkodu": "0000008"},
          "_key_scf_satiselemani": 0,
          "_key_scf_siparis": 0,
          "_key_scf_teklif": 0,
          "_key_shy_servisformu": {"fisno": "000009"},
          "_key_sis_kullanici": {"kullaniciadi": "ws"},
          "_key_sis_rehber_karti": 0,
          "_key_sis_seviyekodu": 0,
          "gorusmesekli": 1,
          "harcananzaman": sure,
          "harcananzamanturu": "D",
          "konu": "Parça değişimi hakkında",
          "note": "yanlış getirilen parçanın yenisi ile değişimi",
          "saat": "15:55:18",
          "tarih": "2017-03-25"
        }
      }
    };

    var response = await http.post(Uri.parse(sURL),
        headers: headers, body: jsonEncode(jsonWS));

    if (response.statusCode == 200) {
      print("result WS: " + response.body);
    } else {
      print("HTTP isteği başarısız oldu: ${response.statusCode}");
    }
  }

  Future<void> _fetchCallLog() async {
    final Iterable<CallLogEntry> entries = await CallLog.get();
    if (entries.isNotEmpty) {
      setState(() {
        _callLogEntries = entries.toList();
      });
    }
  }
  
  Future<void> _getCallerInfo(String phoneNumber, String konusmaSuresi, String konusmaTarihi) async {

      // Telefon rehberinden kişiyi bul
      bool isGranted = await Permission.contacts.status.isGranted;
      if(!isGranted) {isGranted = await Permission.contacts.request().isGranted;}
      Iterable<Contact> contacts = await ContactsService.getContactsForPhone(phoneNumber);

      if (contacts.isNotEmpty) {
        // Son arayan kişinin bilgilerini al
        Contact lastCaller = contacts.first;
        setState(() {
          tarih = konusmaTarihi;
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
        });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(HomeScreenStrings.title)),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LastCallerInfo(
                title: LastCallerStrings.name,
                content: isim ?? LastCallerStrings.noData),
              spaceMedium(),

              LastCallerInfo(
                title: LastCallerStrings.phoneNumber,
                content: numara ?? LastCallerStrings.noData),
              spaceMedium(),

              LastCallerInfo(
                title: LastCallerStrings.company,
                content: sirket ?? LastCallerStrings.noData),
              spaceMedium(),
        
              LastCallerInfo(
                title: LastCallerStrings.callDuration,
                content: minSec(sure??'6000')),
              spaceMedium(),
              
              LastCallerInfo(
                title: LastCallerStrings.callDate,
                content: tarih ?? LastCallerStrings.noData),
              spaceMedium(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8, // Ekranın yarısı kadar genişlik
                    child: TextField(
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
            
              ElevatedButton(
                onPressed: () {
                  if (_callLogEntries.isNotEmpty) {
                    String phoneNumber = _callLogEntries.first.number ?? LastCallerStrings.noData;
                    String konusmaSuresi = _callLogEntries.first.duration.toString();
                    String konusmaTarihi = DateTime.fromMillisecondsSinceEpoch(_callLogEntries.first.timestamp?? 1635400000000)
                    .toLocal().toString().split('.')[0].toString();
                    _getCallerInfo(phoneNumber,konusmaSuresi,konusmaTarihi);}
                  else {sirket = LastCallerStrings.emptyCallLog;}
                },
                child: const Text(HomeScreenStrings.pullLastCallerButton),
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

String minSec(String stringSaniye) {
  int saniye = int.parse(stringSaniye);
  int dakika = saniye ~/ 60; // Saniyeleri dakika cinsinden hesapla
  int kalanSaniye = saniye % 60; // Kalan saniyeleri hesapla

  return '$dakika dakika $kalanSaniye saniye';
}
