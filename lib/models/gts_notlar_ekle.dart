// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    GtsNotlarEkle gtsNotlarEkle;

    Login({
        required this.gtsNotlarEkle,
    });

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        gtsNotlarEkle: GtsNotlarEkle.fromJson(json["gts_notlar_ekle"]),
    );

    Map<String, dynamic> toJson() => {
        "gts_notlar_ekle": gtsNotlarEkle.toJson(),
    };
}

class GtsNotlarEkle {
    String sessionId;
    int firmaKodu;
    int donemKodu;
    Kart kart;

    GtsNotlarEkle({
        required this.sessionId,
        required this.firmaKodu,
        required this.donemKodu,
        required this.kart,
    });

    factory GtsNotlarEkle.fromJson(Map<String, dynamic> json) => GtsNotlarEkle(
        sessionId: json["session_id"],
        firmaKodu: json["firma_kodu"],
        donemKodu: json["donem_kodu"],
        kart: Kart.fromJson(json["kart"]),
    );

    Map<String, dynamic> toJson() => {
        "session_id": sessionId,
        "firma_kodu": firmaKodu,
        "donem_kodu": donemKodu,
        "kart": kart.toJson(),
    };
}

class Kart {
    int keyGtsGorev;
    int keyGtsGorusmeKategori;
    dynamic keyGtsGorusmeKategorileri;
    KeyScfCarikart keyScfCarikart;
    int keyScfSatiselemani;
    int keyScfSiparis;
    int keyScfTeklif;
    KeyShyServisformu keyShyServisformu;
    KeySisKullanici keySisKullanici;
    int keySisRehberKarti;
    int keySisSeviyekodu;
    int gorusmesekli;
    String harcananzaman;
    String harcananzamanturu;
    String konu;
    String note;
    String saat;
    DateTime tarih;

    Kart({
        required this.keyGtsGorev,
        required this.keyGtsGorusmeKategori,
        required this.keyGtsGorusmeKategorileri,
        required this.keyScfCarikart,
        required this.keyScfSatiselemani,
        required this.keyScfSiparis,
        required this.keyScfTeklif,
        required this.keyShyServisformu,
        required this.keySisKullanici,
        required this.keySisRehberKarti,
        required this.keySisSeviyekodu,
        required this.gorusmesekli,
        required this.harcananzaman,
        required this.harcananzamanturu,
        required this.konu,
        required this.note,
        required this.saat,
        required this.tarih,
    });

    factory Kart.fromJson(Map<String, dynamic> json) => Kart(
        keyGtsGorev: json["_key_gts_gorev"],
        keyGtsGorusmeKategori: json["_key_gts_gorusme_kategori"],
        keyGtsGorusmeKategorileri: json["_key_gts_gorusme_kategorileri"],
        keyScfCarikart: KeyScfCarikart.fromJson(json["_key_scf_carikart"]),
        keyScfSatiselemani: json["_key_scf_satiselemani"],
        keyScfSiparis: json["_key_scf_siparis"],
        keyScfTeklif: json["_key_scf_teklif"],
        keyShyServisformu: KeyShyServisformu.fromJson(json["_key_shy_servisformu"]),
        keySisKullanici: KeySisKullanici.fromJson(json["_key_sis_kullanici"]),
        keySisRehberKarti: json["_key_sis_rehber_karti"],
        keySisSeviyekodu: json["_key_sis_seviyekodu"],
        gorusmesekli: json["gorusmesekli"],
        harcananzaman: json["harcananzaman"],
        harcananzamanturu: json["harcananzamanturu"],
        konu: json["konu"],
        note: json["note"],
        saat: json["saat"],
        tarih: DateTime.parse(json["tarih"]),
    );

    Map<String, dynamic> toJson() => {
        "_key_gts_gorev": keyGtsGorev,
        "_key_gts_gorusme_kategori": keyGtsGorusmeKategori,
        "_key_gts_gorusme_kategorileri": keyGtsGorusmeKategorileri,
        "_key_scf_carikart": keyScfCarikart.toJson(),
        "_key_scf_satiselemani": keyScfSatiselemani,
        "_key_scf_siparis": keyScfSiparis,
        "_key_scf_teklif": keyScfTeklif,
        "_key_shy_servisformu": keyShyServisformu.toJson(),
        "_key_sis_kullanici": keySisKullanici.toJson(),
        "_key_sis_rehber_karti": keySisRehberKarti,
        "_key_sis_seviyekodu": keySisSeviyekodu,
        "gorusmesekli": gorusmesekli,
        "harcananzaman": harcananzaman,
        "harcananzamanturu": harcananzamanturu,
        "konu": konu,
        "note": note,
        "saat": saat,
        "tarih": "${tarih.year.toString().padLeft(4, '0')}-${tarih.month.toString().padLeft(2, '0')}-${tarih.day.toString().padLeft(2, '0')}",
    };
}

class KeyScfCarikart {
    String carikartkodu;

    KeyScfCarikart({
        required this.carikartkodu,
    });

    factory KeyScfCarikart.fromJson(Map<String, dynamic> json) => KeyScfCarikart(
        carikartkodu: json["carikartkodu"],
    );

    Map<String, dynamic> toJson() => {
        "carikartkodu": carikartkodu,
    };
}

class KeyShyServisformu {
    String fisno;

    KeyShyServisformu({
        required this.fisno,
    });

    factory KeyShyServisformu.fromJson(Map<String, dynamic> json) => KeyShyServisformu(
        fisno: json["fisno"],
    );

    Map<String, dynamic> toJson() => {
        "fisno": fisno,
    };
}

class KeySisKullanici {
    String kullaniciadi;

    KeySisKullanici({
        required this.kullaniciadi,
    });

    factory KeySisKullanici.fromJson(Map<String, dynamic> json) => KeySisKullanici(
        kullaniciadi: json["kullaniciadi"],
    );

    Map<String, dynamic> toJson() => {
        "kullaniciadi": kullaniciadi,
    };
}
