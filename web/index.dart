import 'dart:html';


void main() {
  querySelector('#Commit')
    ..onClick.listen(LogIn);
  querySelector('#Clear')
    ..onClick.listen(ClearLog);
  querySelector('#User')
    ..placeholder='请输入用户名'
    ..classes.add('User')
    ..onClick.listen(UserEvent);
  querySelector('#Password')
    ..placeholder='请输入密码'
    ..onClick.listen(PasswordEvent);
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
  DivElement form = querySelector('#Form');
  form.remove();
  querySelector('#LeftBack')
    ..classes.clear()
    ..classes.add('LeftBack1');
  querySelector('#RightBack')
    ..classes.clear()
    ..classes.add('RightBack1');
  DivElement rightback=querySelector('#RightBack');

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

}

void UserEvent(MouseEvent event){          ///点击用户名输入框
  InputElement user = querySelector('#User');
  if(user.value=='请输入用户名') user.value = '';
}

void PasswordEvent(MouseEvent event){
  InputElement password = querySelector('#Password');
  if(password.value=='请输入密码') password.value = '' ;
}