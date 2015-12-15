import 'dart:io';
import 'package:sqljocky/sqljocky.dart';
import 'package:rest_frame/rest_frame.dart';
import 'dart:convert';
import'dart:async';

Router router1 = new Router();
Router login = new Router();
Router myclass = new Router();
Router addMessage = new Router();
Router allclass = new Router();
var decoded;//用来接收client端发送的消息
List classList = new List();
List teacherList = new List();
List twoList = new List();

main() async{
  addMessage.post(postAddMessage, "/addmessage");
  login.get(getLogin, "/login");
  //login.post(postLogin, "/login");
  router1.get(getStock, "/stock");
  myclass.get(getMyclass, "/myclass");
  allclass.get(getAllclass,"/allclass");
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


getMyclass(HttpRequest request) async{   //获取我的课程列表
  var pool=new ConnectionPool(host: '52.8.67.180', port: 3306, user: 'dec2013stu', password: 'dec2013stu', db: 'stu_10130340211');
  var results = await pool.query('select curriculumname from curriculum where curriculumID in (select curriculumID from xuanke where studentID = 101)');
  var tearesults = await pool.query('select teachername from teacher where teacherID in(select teacherID from curriculum where curriculumID in (select curriculumID from xuanke where studentID = 101))');
  //需把登陆页面获得的学号替换掉select里的101
  await results.forEach((row) {
    classList.add('"${row[0]}"');
    print(classList);
  });
  await tearesults.forEach((row) {
    teacherList.add('"${row[0]}"');
    print(teacherList);
  });
}

getAllclass(HttpRequest request) async{   //获取所有课程列表
  var pool=new ConnectionPool(host: '52.8.67.180', port: 3306, user: 'dec2013stu', password: 'dec2013stu', db: 'stu_10130340211');
  var results = await pool.query('select curriculumname from curriculum');
  var tearesults = await pool.query('select teachername from teacher where teacherID in(select teacherID from curriculum)');
  print('connect2!');
  await results.forEach((row) {
    classList.add('"${row[0]}"');
    print(classList);
  });
  await tearesults.forEach((row) {
    teacherList.add('"${row[0]}"');
    print(teacherList);
  });
}

void handleRequest(HttpRequest request,Router routen) {
  routen.route(request);
  print('handle!');
}

void addCorsHeaders(HttpResponse res) {
  res.headers.add("Access-Control-Allow-Origin", "*");
  res.headers.add("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
  res.headers.add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
}

listenForRequests(HttpServer requests) async {
  await for (HttpRequest request in requests){
    var res= request.response;
    addCorsHeaders(res);
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
    else if(request.uri.path=="/myclass") {
      print('myclass!~!~!!');
      await getMyclass(request);
      await request.response
      //..headers.add(HttpHeaders.CONTENT_TYPE, "application/json");
      ..headers.contentType = new ContentType("application", "json", charset: "utf-8");
      twoList = [classList,teacherList];
      print(twoList);
      res.write(twoList);
      res.close();
      classList = [];
      teacherList = [];
    }
    else if(request.uri.path=="/allclass") {
      print('allclass!!!!~~~!!~~~');
      await getAllclass(request);
      await request.response
        //..headers.add(HttpHeaders.CONTENT_TYPE, "application/json");
        ..headers.contentType = new ContentType("application", "json", charset: "utf-8");
      twoList = [classList,teacherList];
      print(twoList);
      res.write(twoList);
      res.close();
      classList = [];
      teacherList = [];
    }
    else print("Can't find");
    }
}

