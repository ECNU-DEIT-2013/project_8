import 'dart:html';
import 'dart:convert';

List classList = new List();
List teacherList = new List();
SelectElement classesselector = new SelectElement();
SelectElement teacherselector = new SelectElement();

void main() {
  querySelector('#Commit')
    ..onClick.listen(LogIn);
  querySelector('#Clear')
    ..onClick.listen(ClearLog);
  querySelector('#User')
    ..placeholder='请输入用户名'
    ..classes.add('User');
  querySelector('#Password')
    ..placeholder='请输入密码';
  querySelector('#LeftBack')
    ..classes.add('LeftBack');
  querySelector('#RightBack')
    ..classes.add('RightBack');
}

void ClearLog(MouseEvent event){      ///清空按钮功能
  InputElement user = querySelector('#User');
  user.value='';
  InputElement password = querySelector('#Password');
  password.value='';
}


void LogIn(MouseEvent event){           ///登录按钮功能

  var path= 'http://127.0.0.1:8008/myclass';
  var httpRequest = new HttpRequest();
  httpRequest
    ..open('GET', path)
    ..onLoadEnd.listen((e) => requestComplete(httpRequest))
    ..send('');

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

  //SelectElement classesselector = new SelectElement();      ///课程选择的下拉列表
  classesselector.id='Classesselector';
  classesselectip.children.add(classesselector);

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

 // SelectElement teacherselector = new SelectElement();      ///课程选择的下拉列表
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

}

void Classesshift(MouseEvent event){
  querySelector('#Myclassbt').classes
    ..clear()
    ..add('Myclassbt1');
  querySelector('#Otherclassbt').classes
    ..clear()
    ..add('Otherclassbt');
  querySelector('#Myclassbt').onClick.listen(Classesshift1);

  classesselector.children.clear();
  var path = 'http://127.0.0.1:8008/allclass';
  var httpRequest = new HttpRequest();
  httpRequest
    ..open('GET', path)
    ..onLoadEnd.listen((e) => requestComplete(httpRequest))
    ..send('');
}

void Classesshift1(MouseEvent event) {
  querySelector('#Myclassbt').classes
    ..clear()
    ..add('Myclassbt');
  querySelector('#Myclassbt').onClick.listen(Classesshift1);
  querySelector('#Otherclassbt').classes
    ..clear()
    ..add('Otherclassbt1');
  querySelector('#Otherclassbt').onClick.listen(Classesshift);

  classesselector.children.clear();
  var path = 'http://127.0.0.1:8008/myclass';
  var httpRequest = new HttpRequest();
  httpRequest
    ..open('GET', path)
    ..onLoadEnd.listen((e) => requestComplete(httpRequest))
    ..send('');
}


requestComplete(HttpRequest request) {
  if (request.status == 200) {
    List<String> classList = JSON.decode(request.responseText);
    for(int i=0;i<classList.length;i++){
      OptionElement option = new OptionElement();
      option.text = classList[i];
      print(classList[i]);
      classesselector.children.add(option);
      print(classList[i]+"done");
    }
  } else {
    querySelector('#Myclassbt').text='nanguo';
  }
}
