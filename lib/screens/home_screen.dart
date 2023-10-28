import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CallLogEntry> _callLogEntries = [];
  String? isim;
  String? sirket;

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

Future<void> _getCallerInfo(String phoneNumber) async {
  try {
    // Telefon rehberinden kişiyi bul
    Iterable<Contact> contacts = await ContactsService.getContactsForPhone(phoneNumber);

    if (contacts.isNotEmpty) {
      // Son arayan kişinin bilgilerini al
      Contact lastCaller = contacts.first;
      setState(() {
        isim = lastCaller.displayName ?? 'Bilgi Yokk';
        sirket = lastCaller.company ?? 'Bilgi Yokk';
      });
    } else {
      // Eğer eşleşen kişi bulunamazsa, varsayılan değerleri kullan
      setState(() {
        isim = 'Bilgi Yokk';
        sirket = 'Bilgi Yokk';
      });
    }
  } catch (e) {
    // Hata yakalama işlemi
    debugPrint("Hata oluştu: $e");
    isim = 'Bilgii';
    // Hata olduğunda uygulamanın kapanmasını önlemek için gerekli önlemleri alabilirsiniz.
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Arama Detayı')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Son Arayan Kişi:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            Text(isim??'bosisim'
            ),
            SizedBox(height: 20),
            Text(
              'Son Arayan Numara:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            Text(
              _callLogEntries.isNotEmpty
                  ? _callLogEntries.first.formattedNumber ?? 'Bilgi 1'
                  : 'Bilgi 2',
              style: TextStyle(fontSize: 18)
            ),
            SizedBox(height: 20),
            Text(
              'Sirket:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(sirket??'bossirket'),
            ElevatedButton(
              onPressed: () {
                if (_callLogEntries.isNotEmpty) {
                  String phoneNumber = _callLogEntries.first.number ?? '';
                  _getCallerInfo(phoneNumber);
                }
                else{
                  sirket = 'calllogbos';
                }
              },
              child: Text('Kişi Bilgisini Al'),
            ),
          ],
        ),
      ),
    );
  }
}
