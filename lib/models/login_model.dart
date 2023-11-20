// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    LoginClass login;

    Login({
        required this.login,
    });

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        login: LoginClass.fromJson(json["login"]),
    );

    Map<String, dynamic> toJson() => {
        "login": login.toJson(),
    };
}

class LoginClass {
    String username;
    String password;
    bool disconnectSameUser;
    String lang;
    Params params;

    LoginClass({
        required this.username,
        required this.password,
        required this.disconnectSameUser,
        required this.lang,
        required this.params,
    });

    factory LoginClass.fromJson(Map<String, dynamic> json) => LoginClass(
        username: json["username"],
        password: json["password"],
        disconnectSameUser: json["disconnect_same_user"],
        lang: json["lang"],
        params: Params.fromJson(json["params"]),
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "disconnect_same_user": disconnectSameUser,
        "lang": lang,
        "params": params.toJson(),
    };
}

class Params {
    String apikey;

    Params({
        required this.apikey,
    });

    factory Params.fromJson(Map<String, dynamic> json) => Params(
        apikey: json["apikey"],
    );

    Map<String, dynamic> toJson() => {
        "apikey": apikey,
    };
}
