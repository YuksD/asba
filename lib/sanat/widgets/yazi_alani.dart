import 'package:flutter/material.dart';

class YaziAlani extends StatefulWidget {

  const YaziAlani({super.key, required this.baslik, required this.satir_sayisi, required Null Function(String metin) onChanged});
    final satir_sayisi;
    final baslik;

  @override
  State<YaziAlani> createState() => _YaziAlaniState();
}

class _YaziAlaniState extends State<YaziAlani> {
  TextEditingController yaziController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
                  controller: yaziController,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: widget.satir_sayisi,
                  decoration: InputDecoration(hintText: 'Lütfen ${widget.baslik} Giriniz.',hintStyle: TextStyle(color: Color.fromARGB(73, 0, 0, 0)),labelText: widget.baslik.toString().toUpperCase(),labelStyle: TextStyle(color: Color.fromARGB(255, 6, 161, 130),fontWeight: FontWeight.w500, letterSpacing: 3),alignLabelWithHint: false,floatingLabelBehavior: FloatingLabelBehavior.always,border: 
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25),),fillColor: Color.fromARGB(129, 253, 251, 251), filled: true),
                ),
    );
  }
}