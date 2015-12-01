import 'package:dialog/dialog.dart';
import "package:dialog/src/dialog_class.dart";
import "dart:async";
import "dart:html";

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
    if (e.keyCode == KeyCode.ENTER) {      e.preventDefault(); c.complete(input.value);  addMessageDialog.closeDialog();    }
    else if (e.keyCode == KeyCode.ESC) {      c.complete(null);addMessageDialog.closeDialog();    }
  });
  return c.future;
}//重新写了一个dialog类，代码来源是prompt，添加留言就会调用它


