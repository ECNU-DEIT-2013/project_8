import 'dart:io';
import 'package:sqljocky/sqljocky.dart';
import'dart:convert';

main() async {
  List a = new List();
  var pool = new ConnectionPool(host: '52.8.67.180',port: 3306, user: 'dec2013stu', password: 'dec2013stu', db: 'stu_10130340211', max: 5);
  var results = await pool.query('SELECT * FROM user where userID like "${Username}"and password like"${Password}" ');
  results.forEach((row) {
    print('${row.userID},${row.password}');
    a.add('"${row.userID},${row.password}"');
  });

  var server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4,8080);
  print("Serving at ${server.address}:${server.port}");
  await for (var request in server) {
    request.response.headers
      ..add('Access-Control-Allow-Origin', '*')
      ..add('Access-Control-Allow-Methods', 'POST, OPTIONS')
      ..add('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');

    request.response
      ..headers.contentType = new ContentType("application", "json", charset: "utf-8")
      ..write(a)
      ..close();
  }
}