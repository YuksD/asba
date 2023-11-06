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
  String isim = 'Abuziddin';
  String numara = '05554443322';
  String sirket = 'taksabaklak';
  String sure = '671';
  String tarih = '11:11:1111 11:11';
  String saat = '10:10:10';

  String isim2 = 'Usman';
  String numara2 = '05255252525';
  String sirket2 = 'Taklaci';
  String sure2 = '1322';
  String tarih2 = '12:12:1212 12:12';

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
          saat = tarihVeSaat[10];
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
              spaceSmall(),

              LastCallerInfo(
                title: LastCallerStrings.phoneNumber,
                content: numara ?? LastCallerStrings.noData),
              spaceSmall(),

              LastCallerInfo(
                title: LastCallerStrings.company,
                content: sirket ?? LastCallerStrings.noData),
              spaceSmall(),
        
              LastCallerInfo(
                title: LastCallerStrings.callDuration,
                content: minSec(sure??'6000')),
              spaceSmall(),
              
              LastCallerInfo(
                title: LastCallerStrings.callDate,
                content: tarih ?? LastCallerStrings.noData),
              spaceSmall(),

              LastCallerInfo(
                title: LastCallerStrings.callHour,
                content: saat ?? LastCallerStrings.noData),
              spaceSmall(),

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
                        debugPrint(aciklamaAl);
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
              ElevatedButton(onPressed: () {
                 isim = isim2;
                 numara = numara2;
                 sirket = sirket2;
                 sure = sure2;
                 tarih = tarih2; 
              }, child: const Text('İkinci Faz'))
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
