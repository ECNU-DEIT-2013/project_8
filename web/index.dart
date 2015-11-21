//import 'dart:html';
import 'dart:io';
import 'package:sqljocky/sqljocky.dart';

void main(){
//activate();
insertMess();
}

/*
void activate(){
  var Space = new DivElement();
  var IdInput = new  TextInputElement();
  var KeyInput = new PasswordInputElement();
  var ID = new LabelElement();
  var PASSWORD = new LabelElement();
  var LOGIN = new ButtonElement();
  querySelector('#container')
    ..children.add(ID)
    ..children.add(IdInput)
    ..children.add(Space)
    ..children.add(PASSWORD)
    ..children.add(KeyInput)
    ..children.add(Space)
    ..children.add(LOGIN);
  ID.text='Your ID Here:';
  LOGIN.text='Login';
  PASSWORD.text='Your Password:';
}
*/

insertMess()async{
  var pool=new ConnectionPool(host: 'localhost', port: 3306, user: 'root', password: '000000', db: 'mess_time', max: 5);
  //var results = await pool.query('select * from messtime');
  //return results.forEach((row){
  //  print('Message: ${row[0]},Time: ${row[1]}');
  // });
  var mess = 'this is a message';
  print(mess);
  var now = new DateTime.now();
  var query = await pool.prepare('insert into messtime (Message, Time) values (?,?)');
  var result = await query.execute(['${mess}', '${now}']);    //把一条留言和留言的本地时间插入数据库
}