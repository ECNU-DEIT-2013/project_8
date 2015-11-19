import 'dart:html';

void main(){
activate();
}
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