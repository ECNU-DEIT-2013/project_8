import 'dart:io';
import 'package:sqljocky/sqljocky.dart';
import 'package:rest_frame/rest_frame.dart';
import 'dart:convert';
import'dart:async';
//import 'ClassData.dart';


Router router1 = new Router();
Router login = new Router();
Router addMessage = new Router();
var decoded;//用来接收client端发送的消息

main() async{
  addMessage.post(postAddMessage, "/addmessage");
  login.post(getLogin, "/login");
  //login.post(postLogin, "/login");
  router1.get(getStock, "/stock");
  var server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8008);
  print("Serving at ${server.address}:${server.port}");
  listenForRequests(server);
}

String getStock() {
  return "[rest_test ：) get stock]";
  //你可以在这里添加各种数据操作，然后以json返回
}

Future<String> getLogin() async{//登录实现，连接数据库
  //String a = "[rest_test ：) get Login]";
  print("you,diao,yong,o");
  var tag = 'false';
  List b = JSON.decode(decoded);//对客户端传过来的信息解码
  var Username = b[0];
  var Password = b[1];
  var pool = new ConnectionPool(host: '52.8.67.180',port: 3306, user: 'dec2013stu', password: 'dec2013stu', db: 'stu_10130340211', max: 5);
  var results = await pool.query('SELECT * FROM user where studentID = "${Username}"and password ="${Password}" ');//查找匹配输入的用户信息
  await results.forEach((row) {
    print('${row.studentID},${row.password}');
    tag = 'true';
  });
  if (tag=='true') {
    print('oktologin');}
  else {print ('error');}
  return tag;
  //用get写login的话，这边可以核对好了然后传一个true，没核对传一个false，那边看看是true还是false然后决定发回什么响应
}


postAddMessage( )async{//添加留言的函数
  var pool = new ConnectionPool(host: '52.8.67.180', port: 3306, user: 'dec2013stu', password: 'dec2013stu', db: 'stu_10130340245');
  print('adding...');
  var addAdd = await pool.prepare('Insert into MessageList (UserNum,Message,Star) values (?,?,?)');
  await addAdd.execute([decoded[0],decoded[1],decoded[2]]);
}

void handleRequest(HttpRequest request,Router routen) {
  routen.route(request);
}

void addCorsHeaders(HttpResponse res) {
  res.headers.add("Access-Control-Allow-Origin", "*");
  res.headers.add("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
  res.headers.add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
}

listenForRequests(HttpServer requests) async {
  await for (HttpRequest request in requests){
    addCorsHeaders(request.response);
    print('accept');//测试是否接收到client端的request

    if (request.uri.path=="/login"){//登录功能的实现
      //decoded = await request.transform(UTF8.decoder.fuse(JSON.decoder)).first;
      decoded = await request.transform(UTF8.decoder).join();//获取客户端传来的数据
      print(decoded);
      print("login!!");
      //handleRequest(request,login);
      var tag=await getLogin();
      if ( tag=='true')
      { await request.response
        ..headers.contentType = new ContentType("application", "json", charset: "utf-8");
       await request.response.write(JSON.encode('1'));//告诉客户端信息匹配成功
       request
      // ..response.write('1')
      // ..response.write(tag)
        ..response.close();
       print('gottagggggggg')  ;
      }
      else
      {await request.response
        ..headers.contentType = new ContentType("application", "json", charset: "utf-8");
      request
        ..response.write('0')//告诉客户端信息是错误的
        ..response.close();
        //request.response
      }
      // ..write('0')
      //..write(tag)
      //..close();}

      //String tag = await getLogin();
      // request.response
      //..write(tag)
      //..close();
    }//调用route为login的时候get的函数
    else if(request.uri.path=="/stock"){
      handleRequest(request,router1);}//调用route为stock的时候的函数
    else if(request.uri.path=="/addmessage"){
      decoded = await request.transform(UTF8.decoder.fuse(JSON.decoder)).first;//解码client端send过来的一个List;
      //decoded = await request.transform(UTF8.decoder).join();
      //decoded = await request.transform(JSON.decoder).first;
      print(decoded);
      handleRequest(request,addMessage);//加留言的函数
    }
    else print("Can't find");}
}

