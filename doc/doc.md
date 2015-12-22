| �ؼ�id          |  ����               |
| ----------------|---------------------|
| IdInput         | ��¼ʱID�����      |
| KeyInput        | ��¼���������      |
| MessageArea     | ���������ı���      |
| Space           | ����ռλ��div       |
| ID              | ID�����ǰ���label |
| PASSWORD        | ����������label   |
| LOGIN           | ��¼��ť            |

页面元素命名规则：
        元素ID均首字母大写，如'User'
        元素CSS应用class也为首字母大写，如'.User'
        元素在dart中作对象声明时为小写，如‘DivElement user = new DivElement();’

html中元素id说明
| 元素ID          |   类型       | 说明                             |
|-----------------|--------------|----------------------------------|
| MainCon         | Div          | 总的容器                         |
| Background      | Div          | 背景容器                         |
| LeftBack        | Div          | 左边容器                         |
| RightBack       | Div          | 右边容器                         |
| Bottom          | Div          | 底部条                           |
| Form            | Div          | 登录框容器                       |
| User            | Input输入框  | 用户名输入框                     |
| Password        | Input输入框  | 密码输入框                       |
| Buttons         | Div          | 登录确认和清空按钮的容器         |
| Commit          | Div（按钮）  | 登录确认按钮                     |
| addMessageDialog| Dialog继承类 | 用来添加留言的dialog类           |
| myMessage       |上一行的实例  | 就是首页点了添加留言后出来的     |
| addComments     | 函数         | index.dart里的添加留言函数       |