import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CallLogEntry> _callLogEntries = [];

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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              _callLogEntries.isNotEmpty
                  ? _callLogEntries.first.name ?? 'Bilgi Yok'
                  : 'Bilgi Yok',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Son Arayan Numara:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              _callLogEntries.isNotEmpty
                  ? _callLogEntries.first.formattedNumber ?? 'Bilgi Yok'
                  : 'Bilgi Yok',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

                        Text(
              'Son Arayan Kişi:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              _callLogEntries.isNotEmpty
                  ? _callLogEntries.first.name ?? 'Bilgi Yok'
                  : 'Bilgi Yok',
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: _fetchCallLog,
              child: Text('Yeniden Getir'),
            ),
          ],
        ),
      ),
    );
  }
}
