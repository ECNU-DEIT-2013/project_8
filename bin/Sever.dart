import 'dart:io';
import 'package:sqljocky/sqljocky.dart';
import 'package:rest_frame/rest_frame.dart';
import 'dart:convert';
//import 'ClassData.dart';


Router router1 = new Router();
Router login = new Router();
Router addMessage = new Router();
var decoded;//用来接收client端发送的消息

main() async{
  addMessage.post(postAddMessage, "/addmessage");
  login.get(getLogin, "/login");
  //login.post(postLogin, "/login");
  router1.get(getStock, "/stock");
  var server = await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 8008);
  listenForRequests(server);
}

String getStock() {
  return "[rest_test ：) get stock]";
  //你可以在这里添加各种数据操作，然后以json返回
}

bool getLogin() {//测试
  String a = "[rest_test ：) get login]";
  bool tag= true;
  return tag;
  //用get写login的话，这边可以核对好了然后传一个true，没核对传一个false，那边看看是true还是false然后决定页面跳转？？
}


postAddMessage( )async{//添加留言的函数
  var pool = new ConnectionPool(host: '52.8.67.180', port: 3306, user: 'dec2013stu', password: 'dec2013stu', db: 'stu_10130340245');
  print('adding...');
  var addAdd = await pool.prepare('Insert into MessageList (UserNum,Message) values (?,?)');
  await addAdd.execute(decoded);
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

    if (request.uri.path=="/login"){
      handleRequest(request,login);}//调用route为login的时候get的函数
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

