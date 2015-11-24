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
  SelectElement classesselector = new SelectElement();      ///课程选择的下拉列表
  classesselector.id='Classesselector';
  DivElement rbk=querySelector('#RightBack');
  rbk.children.add(classesselector);
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


}

void UserEvent(MouseEvent event){          ///点击用户名输入框
  InputElement user = querySelector('#User');
  if(user.value=='请输入用户名') user.value = '';
}

void PasswordEvent(MouseEvent event){
  InputElement password = querySelector('#Password');
  if(password.value=='请输入密码') password.value = '' ;
}