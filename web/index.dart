import 'dart:html';
import 'dart:convert';
import 'package:dialog/dialog.dart';
import "package:dialog/src/dialog_class.dart";
import "dart:async";
import "ClassData.dart";
import 'dart:math';
import 'dart:math' show Random;

bool myorall;             ///该变量true为我的课程，false为全部课程
int mystarcount;          ///该变量存放某门课程的评分数
bool timeortag;           ///该变量true为时间轴，false为标签模式

void main() {
  querySelector('#Commit')              ///Commit为确认登录按钮
    ..onClick.listen(LogIn);            ///logIn()为按下确认键登录进入主页面的子函数
  querySelector('#Clear')               ///Clear()为清空按钮
    ..onClick.listen(ClearLog);         ///ClearLog()为清空登录页面的函数
  InputElement user = querySelector('#User');                ///User为用户名输入框
    user
    ..placeholder='请输入用户名'
    ..classes.add('User');
  InputElement password = querySelector('#Password');       ///Password为密码输入框
  password.placeholder='请输入密码';
  querySelector('#LeftBack')
    ..classes.add('LeftBack');
  querySelector('#RightBack')
    ..classes.add('RightBack');
}

 addComments(Event e) async{
  var myMessage = await addMessageDialog("请在这里输入你的留言", "");
  if(myMessage != null){
      alert(myMessage.toString()+'\n留言添加成功！');
       List message = ['5',myMessage];
      var path = 'http://127.0.0.1:8008/addmessage';
      var httpRequest = new HttpRequest();
      httpRequest
        ..open('POST', path)
        ..send(JSON.encode(message));
      }

}//添加留言的函数

void ClearLog(MouseEvent event){      ///清空按钮功能
  InputElement user = querySelector('#User');
  user.value='';
  InputElement password = querySelector('#Password');
  password.value='';
}

void LogIn(MouseEvent event){           ///登录按钮功能
  myorall = true;                     ///登录后默认为我的课程
  timeortag = true;                   ///登录后默认时间轴模式

  addButtons();                        ///加入右边栏的部件


  DivElement lefttop= new DivElement();
  lefttop.id = 'Lefttop';
  lefttop.classes
    ..clear()
    ..add('Lefttop');
  querySelector('#LeftBack').children.add(lefttop);

  DivElement leftmain= new DivElement();
  leftmain.id = 'Leftmain';
  leftmain.classes
    ..clear()
    ..add('Leftmain');
  querySelector('#LeftBack').children.add(leftmain);

  DivElement tagtime = new DivElement();
  tagtime.id = 'Tagtime';
  tagtime.text='时间顺序';
  tagtime.classes
    ..clear()
    ..add('Tagtime');
  querySelector('#Lefttop').children.add(tagtime);

  DivElement tagtag = new DivElement();
  tagtag.id = 'Tagtag';
  tagtag.text='标签模式';
  tagtag.classes
    ..clear()
    ..add('Tagtag1');
  querySelector('#Lefttop').children.add(tagtag);
  tagtag.onClick.listen(Modeshift);
}

void addButtons(){
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
  submitselect.onClick.listen(Checkclass);        ///点击查看评教按钮向左边容器中加入评教内容

  mystarcount = 0;    ///这个整形为个人对某课程的评分，初始未评分为0
  Loadmystar(mystarcount);           ///此处加载的是个人的评分星数

  DivElement saymywords = new DivElement();
  saymywords.id = 'Saymywords';
  saymywords.text = '我要评教';
  saymywords.classes
    ..clear()
    ..add('Saymywords');
  rightback.children.add(saymywords);
  querySelector('#Saymywords').onClick.listen(addComments);///

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

  mystarcount=3;        ///此整形存放全部课程中某一课程的总评分
  Loadmystar(mystarcount);
  querySelector('#Starstext').text='全部评分';
}

void Classesshift1(MouseEvent event){     ///切换至我的课程
                                          ///每次切换需传输我的某课程的评分
  querySelector('#Myclassbt').classes
    ..clear()
    ..add('Myclassbt');
  querySelector('#Myclassbt').onClick.listen(Classesshift1);
  querySelector('#Otherclassbt').classes
    ..clear()
    ..add('Otherclassbt1');
  querySelector('#Otherclassbt').onClick.listen(Classesshift);
  DivElement rightback = querySelector('#RightBack');

  querySelector('#Stars').remove();
  querySelector('#RightBack').children.remove(querySelector('#Saymywords'));

    mystarcount=0;              ///每次切换需传输我的某课程的评分,初始为0
    Loadmystar(mystarcount);
    myorall=true;
    Loadsaymywords();
}

void Modeshift(MouseEvent event){               ///转换到标签模式
  timeortag=false;
  DivElement tagtime=querySelector('#Tagtime');
  tagtime.classes
    ..clear()
    ..add('Tagtime1');
  DivElement tagtag=querySelector('#Tagtag');
  tagtag.classes
    ..clear()
    ..add('Tagtag');
  querySelector('#Tagtime').onClick.listen(Modeshift1);
}

void Modeshift1(MouseEvent event){              ///转换到时间轴
  timeortag=true;
  DivElement tagtime=querySelector('#Tagtime');
  tagtime.classes
    ..clear()
    ..add('Tagtime');
  DivElement tagtag=querySelector('#Tagtag');
  tagtag.classes
    ..clear()
    ..add('Tagtag1');
  querySelector('#Tagtag').onClick.listen(Modeshift);
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
    Star0();
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

void Checkclass(MouseEvent event){
  querySelector('#Leftmain').children.clear();
  int commentcount;                             ///该整形用于存放某课程的评价总数,从数据库获取
  commentcount=5;                              ///以而是条为例
  String thelatesttime='2015-12-01 20:24:15';///这个字符串存放最后评论的时间（要先转换成字符串！！）
  String theearliesttime='2015-11-25 13:40:15';///这个字符串存放最早评论的时间（要先转换成字符串！！）
  List<String> comments = ["2015-12-01 20:24:15","The class is very good!","15","2015-11-28 21:12:08","The teacher is fun!","8","2015-11-28 20:12:08","The teacher is nice!","5","2015-11-25 22:12:08","The teacher is cute!","6","2015-11-25 13:40:15","The lesson is great!","3"];
  ///comments这个LIST存放的是某个课程的评论数据，格式是时间+评论内容+赞数
  List<String> colors=["#6CBFEE","#00EEB1","#FF9BA1","#FFF9A4"];

  if(timeortag==true){///
    DivElement latesttime=new DivElement();     ///latesttime顾名思义为存放最后一条评论的时间，作为时间轴的头
    latesttime.id='Latesttime';
    latesttime.text=thelatesttime;
    latesttime.classes
      ..clear()
      ..add('Latesttime');
    querySelector('#Leftmain').children.add(latesttime);


    for(int i=1;i<=commentcount;i++){         ///该循环向时间轴上加入各个节点
      DivElement commentcon=new DivElement();     ///每个节点的底容器
      commentcon.id = 'Commentcon'+i.toString();
      commentcon.classes
        ..clear()
        ..add('CommentconTime');
      querySelector('#Leftmain').children.add(commentcon);

      DivElement timeline=new DivElement();       ///timeline为时间轴线，是一截截加进去的，不用理这个，只是一根线
      timeline.id = 'Timeline'+i.toString();
      timeline.classes
        ..clear()
        ..add('Timeline');
      querySelector('#Commentcon'+i.toString()).children.add(timeline);

      DivElement timepoint=new DivElement();      ///timepoint是时间轴图案上的节点图案，同样不用理它~
      timepoint.id='Timepoint'+i.toString();
      timepoint.classes
        ..clear()
        ..add('Timepoint');
      querySelector('#Commentcon'+i.toString()).children.add(timepoint);

      DivElement thecommentborder = new DivElement();   ///装饰用，不用管
      thecommentborder.id='Commentborder'+i.toString();
      if(i%2==1){
        thecommentborder.classes
          ..clear()
          ..add('CommentBDA');
      }else{
        thecommentborder.classes
          ..clear()
          ..add('CommentBDB');
      }
      querySelector('#Commentcon'+i.toString()).children.add(thecommentborder);

      DivElement thecomment=new DivElement();     ///每条评论的最终容器，终于写到这了,激动！
      thecomment.id='Comment'+i.toString();
      if(i%2==1){
        thecomment.classes
          ..clear()
          ..add('CommentA');
      }else{
        thecomment.classes
          ..clear()
          ..add('CommentB');
      }
      querySelector('#Commentcon'+i.toString()).children.add(thecomment);

      DivElement commenttext=new DivElement();                  ///此处将评论数据LIST里的评论文字放入评论框中！
      commenttext.id='Commenttext'+i.toString();
      commenttext.text=comments[(i-1)*3+1];                    ///(i-1)*3+1即comments那个LIST中相应的评论文字
      commenttext.classes
        ..clear()
        ..add('Commenttext');
      thecomment.children.add(commenttext);

      DivElement zan= new DivElement();
      zan.id='Zan'+i.toString();
      zan.text='赞（'+comments[(i-1)*3+2]+'）';
      int zanint=int.parse(comments[(i-1)*3+2]);
      zan.classes
        ..clear()
        ..add('zan');
      thecomment.children.add(zan);
      zan.onClick.listen((MouseEvent e)=>Dianzan(i,zanint,e));

      DivElement timeofcomment= new DivElement();
      timeofcomment.id='Timeofcomment';
      timeofcomment.text=comments[(i-1)*3];
      timeofcomment.classes
        ..clear()
        ..add('Timeofcomment');
      thecomment.children.add(timeofcomment);

      DivElement jubao= new DivElement();
      jubao.id='Jubao'+i.toString();
      jubao.text='举报！';
      jubao.classes
        ..clear()
        ..add('Jubao');
      thecomment.children.add(jubao);
      jubao.onClick.listen((MouseEvent e)=>Jubao(i,e));

    }
    DivElement earliesttime=new DivElement();     ///latesttime顾名思义为存放最后一条评论的时间，作为时间轴的头
    earliesttime.id='Earliesttime';
    earliesttime.text=theearliesttime;
    earliesttime.classes
      ..clear()
      ..add('Latesttime');
    querySelector('#Leftmain').children.add(earliesttime);
  }else {
    for (int j = 1; j <= commentcount; j++) {
      String commenttext=comments[(j-1)*3+1];
      int zan=int.parse(comments[(j-1)*3+2]);
      Random random = new Random();
      var msgcolorID = random.nextInt(4);
      String msgcolor=colors[msgcolorID];
      Message msg=new Message(commenttext,zan,j,msgcolor,'Leftmain');
      ///querySelector('#Leftmain').children.add(msg.MesContain);
    }
  }
}


void LoadCommentsTag(int j) {
  DivElement commentcon = new DivElement();
  commentcon.id = 'Comment'+j.toString();
  commentcon.classes
    ..clear()
    ..add('CommentconTag');
  querySelector('#Leftmain').children.add(commentcon);
}

void Dianzan(int i,int zanint,e){
  DivElement zan=querySelector('#Zan'+i.toString());
  zan.text='赞（'+(zanint+1).toString()+'）';
}

void Jubao(int i,e){

}