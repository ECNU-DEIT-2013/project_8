import 'package:dialog/dialog.dart';
import "package:dialog/src/dialog_class.dart";
import "dart:async";
import "dart:html";
import 'dart:convert';
import 'package:dnd/dnd.dart';
import 'dart:math';


class UserElement{
  String UserId;
  String UserName;
  String UserSex;
  int UserMessages;
  }

class TeacherElement {
  String TeacherId;
  String TeacherName;
}

class CourseElement{
  String CourseId;
  String CourseName;
  int CourseAverage;
}

class Message{
  String message;
  int zan;
  int mesNum;

  DivElement container = new DivElement();//整个容器
  DivElement MesContain =new DivElement();//标签本身
  DivElement closeButton = new DivElement();//关闭标签的按钮
  DivElement label = new DivElement(); //标签上面的留言信息
  DivElement zanButton = new DivElement();//点赞的按钮
  DivElement alarmButton = new DivElement();//举报的按钮

  Message( String message,int zan,int mesNum,String color,String containerID){
    String id = "MesDiv"+mesNum.toString();
    this.message = message;
    this.mesNum = mesNum;
    this.zan = zan;
    container = querySelector('#'+containerID);


    LoadClose();
    LoadLabel();
    LoadZan();
    LoadAlarm();
    LoadMesContain(id,color);

    MesContain.onDrag.listen(DragMesContain);
    MesContain.style.border = '1px solid silver';

    print("Finish loading");
  }//构造函数
  DragMesContain(Event e){

  }
  LoadMesContain(String id,String color){
    Random random = new Random();
    var positionX = random.nextInt(42);
    var positionY = random.nextInt(29);

    MesContain
      ..classes.add("MesDiv")
      ..id = id;
    MesContain.style
      ..backgroundColor=color
      ..width="300px"
      ..height= "200px"
      ..position = 'absolute'
      ..marginLeft = positionX.toString()+'%'
      ..marginTop = positionY.toString()+'%' ;
    container.children.add(MesContain);
    Draggable draggable = new Draggable(querySelector('#'+MesContain.id),
    avatarHandler: new AvatarHandler.original());

  }//加载标签
  LoadClose(){
    closeButton.id = "Close"+mesNum.toString();
    closeButton
      ..style.fontFamily = "SimHei"
      ..style.padding = "10px"
      ..style.float = "right"
      ..style.color = "#333333"
      ..text = 'x';
    MesContain.children.add(closeButton);
    closeButton.onClick.listen(ClickClose);
  }//加载标签上的关闭按钮
  LoadLabel(){
    label.text = message;
    label.style
      ..position = "relative"
      ..width = "85%"
      ..float = "right"
      ..height = "65%"
      ..marginRight = "20px"
      ..fontFamily="SimHei"
      ..fontSize = "14px"
      ..color= '#333333';
    MesContain.children.add(label);
  }//加载标签上的留言
  LoadZan(){
    zanButton.style
      ..color = "#333333"
      ..fontFamily = "SimHei"
      ..marginLeft = "10%"
      ..fontSize = "13px"
      ..float = "left";
    zanButton
      ..id = "Zan"+mesNum.toString()
      ..text = "❤("+zan.toString()+')';
    MesContain.children.add(zanButton);
  }//加载标签上的赞
  LoadAlarm(){
    alarmButton.style
      ..color = "#333333"
      ..fontFamily = "SimHei"
      ..marginRight = "10%"
      ..fontSize = "13px"
      ..float = "right";
    alarmButton
      ..id="Alarm"+mesNum.toString()
      ..text = "举报";
    MesContain.children.add(alarmButton);
  }//加载标签上的举报
  ClickAlarm(Event e){

  }
  ClickZan(Event e){
    zan = zan + 1;
  }
  ClickClose(Event e){
    MesContain.remove();
  }
}


Future<String> addMessageDialog([String message = "", String value = ""]) async {
  Completer c = new Completer();
  LabelElement label = new LabelElement()
    ..classes.add("control-label")
    ..htmlFor = "dialogInput"
    ..text = message;
  BRElement br = new BRElement();
  BRElement br2 = new BRElement();
  TextAreaElement input = new TextAreaElement()
    ..classes.add("form-control")
    ..id = "dialogInput"
    ..value = value;
  Dialog addMessageDialog = new Dialog([label, br,br2, input], "添加新留言", true);
  addMessageDialog.showDialog();
  input.focus();
  addMessageDialog.dialogBackdrop.onClick.first.then((_) {
    c.complete(null);addMessageDialog.closeDialog();
  });
  querySelectorAll(".modal button").forEach((ButtonElement buttons) {
    buttons.onClick.first.then((e) {
      if (e.target == addMessageDialog.okButton) {
        c.complete(input.value);
      } else {        c.complete(null);      }
      addMessageDialog.closeDialog();
    });
    buttons.onKeyDown.listen((e) {
      if (e.keyCode == KeyCode.ESC) {   c.complete(null);addMessageDialog.closeDialog();      }
    });
  });
  input.onKeyDown.listen((e) {
    if (e.keyCode == KeyCode.ENTER) {      e.preventDefault(); c.complete(input.value);
    addMessageDialog.closeDialog();    }
    else if (e.keyCode == KeyCode.ESC) {      c.complete(null);
    addMessageDialog.closeDialog();    }
  });
  return c.future;
}//重新写了一个dialog类，代码来源是prompt，添加留言就会调用它


