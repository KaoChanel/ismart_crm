import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismart_crm/models/employee.dart';
import 'package:ismart_crm/src/launcher.dart';
import 'package:ismart_crm/widgets/bezierContainer.dart';
import 'package:ismart_crm/models/company.dart';
import 'package:http/http.dart' as http;
import 'package:ismart_crm/models/user.dart';
import 'package:ismart_crm/globals.dart' as globals;

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  User _user;
  Company compValue;
  TextEditingController txtUsername = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  bool _loginSuccess = false;

  @override
  void dispose() {
    super.dispose();
    txtUsername.dispose();
    txtPassword.dispose();
  }

  Future<void> getUser(String company, String username, String password) async {
    showLoaderDialog(context);
    http.Response response = await http.get(
        // '${globals.publicAddress}/login/LoginByEmpCode?_company=$company&_empcode=$username&password=$password'
        '${globals.publicAddress}/api/login/LoginByEmpCode/$company/$username/$password');
    print(response.body);
    var decode = jsonDecode(response.body);

    if (decode['empId'] != 0) {
      // _user = userFromJson(response.body);
      //
      // String strUrl = '${globals.publicAddress}/api/employees/$company/${_user.empId}';
      // response = await http.get(strUrl);

      globals.employee = employeeFromJson(response.body);
      globals.company = company;

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Launcher()));
    }
    else {
      showAlertDialog(context, 'เข้าสู่ระบบไม่สำเร็จ');
    }
    // Navigator.pop(context);
    print(_user);
}

  showLoaderDialog(BuildContext context){
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

@override
Widget build(BuildContext context) {
  final height = MediaQuery
      .of(context)
      .size
      .height;
  return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: -height * .15,
                right: -MediaQuery
                    .of(context)
                    .size
                    .width * .4,
                child: BezierContainer()),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: height * .1),
                    _title(),
                    SizedBox(height: 20),
                    _emailPasswordWidget(),
                    SizedBox(height: 20),
                    _companySelect(),
                    SizedBox(height: 20),
                    _submitButton(),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerRight,
                      child: Text('Forgot Password ?',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    _divider(),
                    //_facebookButton(),
                    SizedBox(height: height * .055),
                    _createAccountLabel(),
                  ],
                ),
              ),
            ),
            // Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ));
}

Widget _entryField(String title, TextEditingController controller,
    {bool isPassword = false}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
            controller: controller,
            obscureText: isPassword,
            textInputAction: TextInputAction.next,
            textCapitalization: isPassword == true ? TextCapitalization.none : TextCapitalization.characters,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true))
      ],
    ),
  );
}

showAlertDialog(BuildContext context, String _message) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
      FocusScope.of(context).requestFocus(new FocusNode());
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("แจ้งเตือน"),
    content: Text(_message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Widget _submitButton() {
  return InkWell(
    onTap: () {
      // showLoaderDialog(context);
      getUser(compValue.compCode, txtUsername.text, txtPassword.text);
      Navigator.pop(context);
      print("Username: " + txtUsername?.text + " Password: " + txtPassword?.text);
    },
    child: Container(
      width: MediaQuery
          .of(context)
          .size
          .width / 2,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xfffbb448), Color(0xfff7892b)])),
      child: Text(
        'เข้าสู่ระบบ',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}

Widget _divider() {
  return Container(
    width: 500,
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
        ),
        Text('or'),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    ),
  );
}

Widget _createAccountLabel() {
  return InkWell(
    // onTap: () {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => SignUpPage()));
    // },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Register',
            style: TextStyle(
                color: Color(0xfff79c4f),
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}

// Widget _title() {
//   return RichText(
//     textAlign: TextAlign.center,
//     text: TextSpan(
//         text: 'd',
//         style: GoogleFonts.portLligatSans(
//           textStyle: Theme.of(context).textTheme.display1,
//           fontSize: 30,
//           fontWeight: FontWeight.w700,
//           color: Color(0xffe46b10),
//         ),
//         children: [
//           TextSpan(
//             text: 'ev',
//             style: TextStyle(color: Colors.black, fontSize: 30),
//           ),
//           TextSpan(
//             text: 'rnz',
//             style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
//           ),
//         ]),
//   );
// }

Widget _title() {
  return Image(
    height: 200,
    image: AssetImage('assets/bisgroup-logo.png'),
  );
}

Widget _emailPasswordWidget() {
  return Container(
    width: MediaQuery
        .of(context)
        .size
        .width / 2,
    child: Column(
      children: <Widget>[
        _entryField("Username:", txtUsername),
        _entryField("Password:", txtPassword, isPassword: true),
      ],
    ),
  );
}

Widget _companySelect() {
  return Container(
      width: MediaQuery
          .of(context)
          .size
          .width / 2,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Company:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<Company>(
                value: compValue,
                isExpanded: true,
                items: companys.map((Company value) {
                  return DropdownMenuItem<Company>(
                    value: value,
                    child: Text(value.compName),
                  );
                }).toList(),
                onChanged: (Company value) {
                  setState(() {
                    compValue = value;
                    FocusScope.of(context).requestFocus(new FocusNode());
                    print(compValue.compCode);
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true)
            )
          ]));
}}
