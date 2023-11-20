import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ilkproje/sanat/widgets/baslik.dart';
import 'package:ilkproje/sanat/widgets/green_button.dart';
import 'package:ilkproje/sanat/widgets/gts_card.dart';
import 'package:ilkproje/sanat/widgets/gts_card_onlytitle.dart';
import 'package:ilkproje/sanat/widgets/yazi_alani.dart';

class SanatSepet extends StatelessWidget {
  const SanatSepet({super.key});
  
  get validateName => null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 0,backgroundColor: const Color.fromARGB(255, 24, 147, 124),
          title: Baslik(baslik: 'GTS Not Ekleyici'),
          centerTitle: true,
          actions: const [Icon(Icons.person_4_outlined,color: Color.fromARGB(255, 232, 245, 243)), SizedBox(width: 20,)],
        ),
        body: Container(decoration: 
        const BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 254, 255, 255),Color.fromARGB(255, 139, 205, 186),], begin: Alignment.topCenter,end: Alignment.bottomRight)),height: 600,width: double.infinity,
        child: const Column(
          children: [
            Spacer(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(children: [
                GTSCard(title: 'Burhan Altıntop', subtitle: '545 535 25 15',iconData: Icons.person),
                Spacer(),
                GTSCardOnlyTitle(title: 'avrupayakasi',iconData: Icons.home_work_outlined),
              
              
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  GTSCard(title: '15:57', subtitle: '18.12.2026', iconData: Icons.calendar_month_outlined),
                  Spacer(),
                  GTSCardOnlyTitle(title: '10 dakika \n27 saniye',iconData: Icons.watch_later_outlined),
                ],
              ),
            ),





            Spacer(),
            YaziAlani(baslik: 'Konu',satir_sayisi: 3,),
            SizedBox(height: 15,),
            YaziAlani(baslik: 'Açıklama',satir_sayisi: 6,),
            Padding(  
              padding: EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  GreenButton(buton_adi: 'Kişi Al',isUseable: true),
                  Spacer(),
                  GreenButton(buton_adi: 'Gönder',isUseable: true),
                  Spacer(),
                  GreenButton(buton_adi: 'Coming Soon',isUseable: false),
                  Spacer(),
                ],
              ),
            )
          ],
        ),
        ),
      ),
    );
  }
}