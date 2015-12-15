import 'dart:html';
import 'dart:convert';

List classList = new List();
List teacherList = new List();
List twoList = new List();
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
  querySelector('#Classesselector').onChange.listen(ChangeTeachername);  //这是一条测试测试测试
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
  teacherselector.children.clear();
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
  teacherselector.children.clear();
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
    for(int i=0;i<classList[0].length;i++){
      OptionElement option = new OptionElement();
      option.text = classList[0][i];
      print(classList[0][i]);
      classesselector.children.add(option);
      print(classList[0][i]+"done");
    }
    for(int j=0;j<classList[1].length;j++){
      OptionElement option1 = new OptionElement();
      option1.text = classList[1][j];
      print(classList[1][j]);
      teacherselector.children.add(option1);
      print(classList[1][j]+"done");
    }
  } else {
    querySelector('#Myclassbt').text='nanguo';
  }
}

void ChangeTeachername(Event e){
  //var xuanze = document.getElementById('Classesselector').value;
  //var xuanze = querySelector('#Classesselector').text;
  var xuanze = classesselector.getElementsByClassName(SelectElement);
  //windows.alert(xuanze);
  querySelector('#Myclassbt').text= xuanze;
  for(int i=0;i<classList[0].length;i++) {
    if(xuanze==classList[0][i]){
      //teacherselector.value = classList[1][i];
      teacherselector.options.text = 'hahhah';
    }
  }
}