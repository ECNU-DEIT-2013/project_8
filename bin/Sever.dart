import 'dart:io';
import 'package:sqljocky/sqljocky.dart';

class UserList{
  var Num,Name,Phone,Key;
  var Age,Gender;
  UserList(var a,var b,var c,var d,var e,var f){
    Num=a;Name=b;Gender=c;Age=d;Phone=e;Key=f;
  }
}

main() async {
  var server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8008);
  print("Serving at ${server.address}:${server.port}");

  await for (var request in server) {
    request.response.headers
      ..add('Access-Control-Allow-Origin', '*')
      ..add('Access-Control-Allow-Methods', 'POST, OPTIONS')
      ..add('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');

    print('Server is OK');
    request.response
      ..headers.contentType = new ContentType("application", "json", charset: "utf-8")
      ..write('test')
      ..close();
  }
}

getData(var host, var port, var user, var password, var db,var sql,var results,var resultString) async{
  var pool = new ConnectionPool(host: host, port: port, user:user, password: password, db:db);
  var results =await pool.query(sql);

  results.forEach((row) {
    resultString.add('"UserNum: ${row.UserNum};   UserName:${row.UserName};   UserPhone:${row[2]}"');
     print('ok');
   });
}//显示数据

InsertData(var sql,List a ) async{
  var query1 = await pool.prepare(sql);
  var result = await query1.execute(a);
}//插入数据，在其他函数里调用的基础函数

AddMessage(var sql) async{

}//加留言的函数

AddHeat() async{

}//加热度的函数


