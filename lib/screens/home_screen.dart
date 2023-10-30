import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:ilkproje/components/caller_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ilkproje/constants/last_caller.dart';
import 'package:ilkproje/constants/home_screen_strings.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CallLogEntry> _callLogEntries = [];
  String? isim;
  String? numara;
  String? sirket;
  String? sure;
  String? tarih;


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

// void minSec(int saniye) {
//   double dakikaKusurat = saniye/60;
//   int dakika = dakikaKusurat.toInt();
  
// }
String minSec(String stringSaniye) {
  int saniye = int.parse(stringSaniye);
  int dakika = saniye ~/ 60; // Saniyeleri dakika cinsinden hesapla
  int kalanSaniye = saniye % 60; // Kalan saniyeleri hesapla

  return '$dakika dakika $kalanSaniye saniye';
}
