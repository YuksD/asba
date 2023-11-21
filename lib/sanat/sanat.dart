import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ilkproje/sanat/widgets/baslik.dart';
import 'package:ilkproje/sanat/widgets/green_button.dart';
import 'package:ilkproje/sanat/widgets/gts_card.dart';
import 'package:ilkproje/sanat/widgets/gts_card_onlytitle.dart';
import 'package:ilkproje/sanat/widgets/yazi_alani.dart';
import 'package:ilkproje/screens/gts.dart';

  // String konuAl = '';
  // String aciklamaAl = '';
class SanatSepet extends StatelessWidget {
   SanatSepet(
    {super.key, 
    required this.isim, 
    required this.numara, 
    required this.sirket, 
    required this.tarih, 
    required this.saat, 
    required this.sure});
    
  final String isim;
  final String numara;
  final String sirket;
  final String tarih;
  final String saat;
  final String sure;
  String konuVer = 'a';
  String aciklamaAl = 'a';
  String konuAl = 'x';


  
  get validateName => null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 0,backgroundColor: const Color.fromARGB(255, 24, 147, 124),
          title: Baslik(baslik: 'GTS Not Ekleyici'),
          centerTitle: true,
          actions: const [Icon(Icons.person_4_sharp,color: Color.fromARGB(255, 232, 245, 243), size: 30), SizedBox(width: 20,)],
        ),
        body: Container(decoration: 
        const BoxDecoration(gradient: LinearGradient(colors: [Color.fromARGB(255, 254, 255, 255),Color.fromARGB(255, 139, 205, 186),], begin: Alignment.topCenter,end: Alignment.bottomRight)),height: 600,width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5,),
          
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(children: [
                  GTSCard(title: isim, subtitle: numara,iconData: Icons.person),
                  SizedBox(height: 5,),
                  GTSCardOnlyTitle(title: sirket,iconData: Icons.home_work_outlined),
                
                
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    GTSCard(title: saat, subtitle: tarih, iconData: Icons.calendar_month_outlined),
                    Spacer(),
                    GTSCardOnlyTitle(title: sure,iconData: Icons.watch_later_outlined),
                  ],
                ),
              ),
          
          
          
          
          
              SizedBox(height: 5,),
              TextField(
                  onChanged: (String metin){
                               konuAl = metin;
                               debugPrint(konuAl);
                             },
          
                    //controller: yaziController,
                    textCapitalization: TextCapitalization.sentences,
                    //maxLines: widget.satir_sayisi,
                    decoration: InputDecoration(hintText: 'Lütfen Giriniz.',hintStyle: TextStyle(color: Color.fromARGB(73, 0, 0, 0)),labelText: 'baslik',labelStyle: TextStyle(color: Color.fromARGB(255, 6, 161, 130),fontWeight: FontWeight.w500, letterSpacing: 3),alignLabelWithHint: false,floatingLabelBehavior: FloatingLabelBehavior.always,border: 
                      OutlineInputBorder(borderRadius: BorderRadius.circular(25),),fillColor: Color.fromARGB(129, 253, 251, 251), filled: true),
                  ),
          
          
          
              SizedBox(height: 15,),
              YaziAlani(baslik: 'Açıklama',satir_sayisi: 6,
              onChanged: (String metin){
                               String aciklamametni = metin;
                               debugPrint(aciklamaAl);
                             },
              ),
              Padding(  
                padding: EdgeInsets.all(8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    GreenButton(buton_adi: 'Kişi Al',isUseable: true),
                    Spacer(),
                    GetSessionID(saat: saat, konu: konuVer,aciklama: aciklamaAl,sure: sure, tarih: tarih),
                    Spacer(),
                    ElevatedButton(onPressed: () {
                      debugPrint(konuVer);
                      debugPrint(konuAl);

                      konuVer = konuAl;
                      debugPrint(konuVer);

                    }, child: Text('kv'))
                  ],
                ),
              )
            ],
          ),
        ),
        ),
      ),
    );
  }
}