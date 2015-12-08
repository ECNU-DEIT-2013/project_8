import 'dart:html';
import 'dart:convert';
import 'package:dialog/dialog.dart';
import "package:dialog/src/dialog_class.dart";
import "dart:async";
import "ClassData.dart";

bool myorall;
int mystarcount;

void main() {
  querySelector('#Commit')              ///Commit为确认登录按钮
    ..onClick.listen(LogIn);            ///logIn()为按下确认键登录进入主页面的子函数
  querySelector('#Clear')               ///Clear()为清空按钮
    ..onClick.listen(ClearLog);         ///ClearLog()为清空登录页面的函数
  querySelector('#User')                ///User为用户名输入框
    ..placeholder='请输入用户名'
    ..classes.add('User');
  querySelector('#Password')            ///Password为密码输入框
    ..placeholder='请输入密码';
  querySelector('#LeftBack')
    ..classes.add('LeftBack');
  querySelector('#RightBack')
    ..classes.add('RightBack');
}

 addComments(Event e) async{
  var myMessage = await addMessageDialog("请在这里输入你的留言", "");
  if(myMessage != null&&mystarcount!=0){
      alert(myMessage.toString()+'\n留言添加成功！');
       List message = ['5',myMessage,mystarcount];
      var path = 'http://127.0.0.1:8008/addmessage';
      var httpRequest = new HttpRequest();
      httpRequest
        ..open('POST', path)
        ..send(JSON.encode(message));
      }else if(myMessage==null){
    window.alert("请输入留言哦！");
      }else if (mystarcount==0){
    window.alert("你还没有打分哦！");
  }

}//添加留言的函数

void ClearLog(MouseEvent event){      ///清空按钮功能
  InputElement user = querySelector('#User');
  user.value='';
  InputElement password = querySelector('#Password');
  password.value='';
}

void LogIn(MouseEvent event){           ///登录按钮功能
  myorall = true;
  DivElement form = querySelector('#Form');
  form.remove();
  querySelector('#LeftBack')
    ..classes.clear()
    ..classes.add('LeftBack1');
  querySelector('#RightBack')
    ..classes.clear()
    ..classes.add('RightBack1');
  DivElement rightback=querySelector('#RightBack');

  DivElement myclass = new DivElement();
  myclass.id = 'Myclass';
  myclass.classes
    ..clear()
    ..add('Myclass');
  rightback.children.add(myclass);
  DivElement myclassbt = new DivElement();
  DivElement blank = new DivElement();
  DivElement otherclassbt = new DivElement();
  myclassbt.id = 'Myclassbt';
  blank.id = 'Blank';
  otherclassbt.id = 'Otherclassbt';
  myclassbt.text = '我的课程';
  otherclassbt.text = '全部课程';
  myclassbt.classes
    ..clear()
    ..add('Myclassbt');
  blank.classes
    ..clear()
    ..add('Blank');
  blank.text = '↔';
  otherclassbt.classes
    ..clear()
    ..add('Otherclassbt1');
  myclass.children
    ..add(myclassbt)
    ..add(blank)
    ..add(otherclassbt);
  otherclassbt.onClick.listen(Classesshift);

  DivElement selects = new DivElement();
  selects.classes.add('Selects');
  rightback.children.add(selects);
  DivElement classesselectip = new DivElement();
  classesselectip.id = 'Classesselectip';
  classesselectip.text = '选择课程';
  classesselectip.classes
      ..clear()
      ..add('Classesselecttip');
  selects.children.add(classesselectip);

  SelectElement classesselector = new SelectElement();      ///课程选择的下拉列表
  classesselector.id='Classesselector';
  classesselectip.children.add(classesselector);
  int classsum;
  classsum = 10;      ///注意该数据为该学生课程总数，请用Select+Sum 语句从数据库中统计该学生选课的总数，以便加入下拉列表中
  List<String> classes = ["Chinese","Math","English","Physics","Chemistry","Biology","History","Geography","Politics","Information Technology"];
  ///该List存放的是该学生选择的课程，请加入客户端向服务器端的请求和数据的接收，放入List中
  for(int i=0;i<classsum;i++){
    OptionElement option = new OptionElement();
    option.text = classes[i];
    print(classes[i]);
    classesselector.children.add(option);
    print(classes[i]+"done");
  }
  classesselector.classes
      ..clear()
      ..add('Classesselector');

  DivElement teacherselecttip = new DivElement();
  teacherselecttip.id = 'Teacherselecttip';
  teacherselecttip.text = '选择教师';
  teacherselecttip.classes
    ..clear()
    ..add('Teacherselecttip');
  selects.children.add(teacherselecttip);

  SelectElement teacherselector = new SelectElement();      ///课程选择的下拉列表
  teacherselector.id='Teacherselector';
  teacherselecttip.children.add(teacherselector);
  int teachersum;
  teachersum = 10;      ///注意该数据为教师总数，请用Select+Sum 语句从数据库中统计教师的总数，以便加入下拉列表中
  List<String> teachers = ["Chinese","Math","English","Physics","Chemistry","Biology","History","Geography","Politics","Information Technology"];
  ///该List存放的是教师的名称，请加入客户端向服务器端的请求和数据的接收，放入List中
  for(int j=0;j<teachersum;j++){
    OptionElement option1 = new OptionElement();
    option1.text = teachers[j];
    print(teachers[j]);
    teacherselector.children.add(option1);
    print(teachers[j]+"done");
  }
  teacherselector.classes
    ..clear()
    ..add('Teacherselector');

  DivElement submitselect = new DivElement();
  submitselect.id = 'Submitselect';
  submitselect.classes
    ..clear()
    ..add('Submitselect');
  submitselect.text='查看评教';
  selects.children.add(submitselect);

  mystarcount = 0;    ///这个整形为个人对某课程的评分，初始未评分为0
  Loadmystar(mystarcount);           ///此处加载的是个人的评分星数


  DivElement saymywords = new DivElement();
  saymywords.id = 'Saymywords';
  saymywords.text = '我要评教';
  saymywords.classes
    ..clear()
    ..add('Saymywords');
  rightback.children.add(saymywords);
  querySelector('#Saymywords').onClick.listen(addComments);
}

void Classesshift(MouseEvent event){      ///切换至全部课程
  myorall = false;
  querySelector('#RightBack').children.remove(querySelector('#Saymywords'));
  querySelector('#Myclassbt').classes
    ..clear()
    ..add('Myclassbt1');
  querySelector('#Otherclassbt').classes
    ..clear()
    ..add('Otherclassbt');
  querySelector('#Myclassbt').onClick.listen(Classesshift1);
  querySelector('#Stars').remove();
}

void Classesshift1(MouseEvent event){     ///切换至我的课程
  querySelector('#Myclassbt').classes
    ..clear()
    ..add('Myclassbt');
  querySelector('#Myclassbt').onClick.listen(Classesshift1);
  querySelector('#Otherclassbt').classes
    ..clear()
    ..add('Otherclassbt1');
  querySelector('#Otherclassbt').onClick.listen(Classesshift);
  DivElement rightback = querySelector('#RightBack');

  Loadmystar(mystarcount);       ///加载个人评星数

  if(myorall == false) {
    Loadsaymywords();

  }


}

void Loadsaymywords(){
  DivElement saymywords = new DivElement();
  saymywords.id = 'Saymywords';
  saymywords.text = '我要评教';
  saymywords.classes
    ..clear()
    ..add('Saymywords');
  querySelector('#RightBack').children.add(saymywords);
  querySelector('#Saymywords').onClick.listen(addComments);
}

void Loadmystar(int mystarcount){
  DivElement rightback = querySelector('#RightBack');
  DivElement stars = new DivElement();  ///评分（包括“我的评分”文字的整个容器）
  stars.id = 'Stars';
  stars.classes
    ..clear()
    ..add('Stars');
  rightback.children.add(stars);

  DivElement starstext = new DivElement();    ///文字
  starstext.id = 'Starstext';
  starstext.text='我的评分';
  starstext.classes
    ..clear()
    ..add('Starstext');
  stars.children.add(starstext);

  DivElement starscon= new DivElement();   ///星星容器
  starscon.id='Starscon';
  starscon.classes
    ..clear()
    ..add('Starscon');
  stars.children.add(starscon);

  DivElement star1 = new DivElement();
  star1.id = 'Star1';
  star1.text = '★';
  starscon.children.add(star1);
  Addstarspace();

  DivElement star2 = new DivElement();
  star2.id = 'Star2';
  star2.text = '★';
  starscon.children.add(star2);
  Addstarspace();

  DivElement star3 = new DivElement();
  star3.id = 'Star3';
  star3.text = '★';
  starscon.children.add(star3);
  Addstarspace();

  DivElement star4 = new DivElement();
  star4.id = 'Star4';
  star4.text = '★';
  starscon.children.add(star4);
  Addstarspace();

  DivElement star5 = new DivElement();
  star5.id = 'Star5';
  star5.text = '★';
  starscon.children.add(star5);


                            ///此处将数据库传到服务器传到客户端的评分数据赋给mystarcount变量，会自动调整评分的五角星
  if(mystarcount==0){                 ///这里用评分数来判断是否完成评分
                              ///如果未完成，则有鼠标经过的特效，如已评分，则将加载的评分数（1~5）
                              ///比如评了4分，则调用Star4()；
    star1.onMouseEnter.listen(Starin1);
    star2.onMouseEnter.listen(Starin2);
    star3.onMouseEnter.listen(Starin3);
    star4.onMouseEnter.listen(Starin4);
    star5.onMouseEnter.listen(Starin5);
    star1.onMouseOut.listen(Starout1);
    star2.onMouseOut.listen(Starout2);
    star3.onMouseOut.listen(Starout3);
    star4.onMouseOut.listen(Starout4);
    star5.onMouseOut.listen(Starout5);
    star1.onClick.listen(Clickstar1);
    star2.onClick.listen(Clickstar2);
    star3.onClick.listen(Clickstar3);
    star4.onClick.listen(Clickstar4);
    star5.onClick.listen(Clickstar5);

  }else if(mystarcount==1){
    Star1();
  }else if(mystarcount==2){
    Star2();
  }else if(mystarcount==3){
    Star3();
  }else if(mystarcount==4){
    Star4();
  }else if(mystarcount==5){
    Star5();
  }
}
void Addstarspace() {
  DivElement starscon = querySelector('#Starscon');
  DivElement space = new DivElement();
  space.classes
    ..clear()
    ..add('Space');
  starscon.children.add(space);
}

void Starin1(MouseEvent event){
  Star1();
}

void Starin2(MouseEvent event){
  Star2();
}

void Starin3(MouseEvent event){
  Star3();
}

void Starin4(MouseEvent event){
  Star4();
}

void Starin5(MouseEvent event){
  Star5();
}

void Starout1(MouseEvent event){
  if(mystarcount==0) {
    Star0();
  }
}

void Starout2(MouseEvent event){
  if(mystarcount==0) {
    Star0();
  }
}

void Starout3(MouseEvent event){
  if(mystarcount==0) {
    Star0();
  }
}

void Starout4(MouseEvent event){
  if(mystarcount==0) {
    Star0();
  }
}

void Starout5(MouseEvent event){
  if(mystarcount==0) {
    Star0();
  }
}

void Star0(){
  querySelector('#Star1').classes
    ..clear()
    ..add('StarA');
  querySelector('#Star2').classes
    ..clear()
    ..add('StarA');
  querySelector('#Star3').classes
    ..clear()
    ..add('StarA');
  querySelector('#Star4').classes
    ..clear()
    ..add('StarA');
  querySelector('#Star5').classes
    ..clear()
    ..add('StarA');
}

void Star1(){
  querySelector('#Star1').classes
    ..clear()
    ..add('StarB');
  querySelector('#Star2').classes
    ..clear()
    ..add('StarA');
  querySelector('#Star3').classes
    ..clear()
    ..add('StarA');
  querySelector('#Star4').classes
    ..clear()
    ..add('StarA');
  querySelector('#Star5').classes
    ..clear()
    ..add('StarA');
}

void Star2(){
  querySelector('#Star1').classes
    ..clear()
    ..add('StarB');
  querySelector('#Star2').classes
    ..clear()
    ..add('StarB');
  querySelector('#Star3').classes
    ..clear()
    ..add('StarA');
  querySelector('#Star4').classes
    ..clear()
    ..add('StarA');
  querySelector('#Star5').classes
    ..clear()
    ..add('StarA');
}

void Star3(){
  querySelector('#Star1').classes
    ..clear()
    ..add('StarB');
  querySelector('#Star2').classes
    ..clear()
    ..add('StarB');
  querySelector('#Star3').classes
    ..clear()
    ..add('StarB');
  querySelector('#Star4').classes
    ..clear()
    ..add('StarA');
  querySelector('#Star5').classes
    ..clear()
    ..add('StarA');
}

void Star4(){
  querySelector('#Star1').classes
    ..clear()
    ..add('StarB');
  querySelector('#Star2').classes
    ..clear()
    ..add('StarB');
  querySelector('#Star3').classes
    ..clear()
    ..add('StarB');
  querySelector('#Star4').classes
    ..clear()
    ..add('StarB');
  querySelector('#Star5').classes
    ..clear()
    ..add('StarA');
}

void Star5(){
  querySelector('#Star1').classes
    ..clear()
    ..add('StarB');
  querySelector('#Star2').classes
    ..clear()
    ..add('StarB');
  querySelector('#Star3').classes
    ..clear()
    ..add('StarB');
  querySelector('#Star4').classes
    ..clear()
    ..add('StarB');
  querySelector('#Star5').classes
    ..clear()
    ..add('StarB');
}

void Clickstar1(MouseEvent event){                ///点击星星评分的函数，对应的每个函数评分完成后请将mystarcount里的整形上传数据库！！
  Star1();
  mystarcount=1;
  querySelector('#Stars').remove();
  querySelector('#RightBack').children.remove(querySelector('#Saymywords'));
  Loadmystar(mystarcount);
  Loadsaymywords();
}

void Clickstar2(MouseEvent event){
  Star2();
  mystarcount=2;
  querySelector('#Stars').remove();
  querySelector('#RightBack').children.remove(querySelector('#Saymywords'));
  Loadmystar(mystarcount);
  Loadsaymywords();

}

void Clickstar3(MouseEvent event){
  Star3();
  mystarcount=3;
  querySelector('#Stars').remove();
  querySelector('#RightBack').children.remove(querySelector('#Saymywords'));
  Loadmystar(mystarcount);
  Loadsaymywords();
}

void Clickstar4(MouseEvent event){
  Star4();
  mystarcount=4;
  querySelector('#Stars').remove();
  querySelector('#RightBack').children.remove(querySelector('#Saymywords'));
  Loadmystar(mystarcount);
  Loadsaymywords();
}

void Clickstar5(MouseEvent event){
  Star5();
  mystarcount=5;
  querySelector('#Stars').remove();
  querySelector('#RightBack').children.remove(querySelector('#Saymywords'));
  Loadmystar(mystarcount);
  Loadsaymywords();
}