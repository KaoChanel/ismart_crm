import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'saleOrder.dart';
import 'containerCustomer.dart';
import 'package:flutter/cupertino.dart';
import 'package:ismart_crm/models/customer.dart';
import 'package:http/http.dart' as http;
import 'package:ismart_crm/globals.dart' as globals;

Widget _menuCard(String _path) {
  return Card(
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Image.asset(_path),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 5,
    margin: EdgeInsets.all(10),
  );
}

Card dashboardCard(String title, String path) {
  return Card(
      elevation: 8.0,
      margin: new EdgeInsets.all(8.0),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        // decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Container(
            // decoration: BoxDecoration(color: Colors.blueAccent),
            child: Center(
                child: Image(
              image: AssetImage(path),
              fit: BoxFit.contain,
            )),
            // Center(
            //     child: Icon(
            //       icon,
            //       size: 40.0,
            //       color: Colors.black,
            //     )),
          ),
          //SizedBox(height: 5.0),
          Container(
              color: Colors.blueAccent,
              padding: EdgeInsets.only(bottom: 6, top: 3),
              child: Center(
                child: new Text(title,
                    style: new TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        color: Colors.white)),
              ))
        ],
      ));
}

// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Sale CRM',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: DashboardPage(),
//     );
//   }
// }

class DashboardPage extends StatefulWidget {
  static const routeName = '/';

  State createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  TextEditingController txtCustomer = new TextEditingController();

  Future<void> getCustomer() async{
    String strUrl =
        '${globals.publicAddress}/api/customers/${globals.employee.empId}';
    var response = await http.get(strUrl);

    setState(() {
      globals.allCustomer = customerFromJson(response.body);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      //Padding(padding: null)
                      // SizedBox(
                      // width: 60,
                      // child: Text('ลูกค้า : ',
                      //       style: TextStyle(fontSize: 18)),
                      // ),
                      Flexible(
                          child: TextFormField(
                        readOnly: true,
                        //initialValue: 'โรงงานสัตว์เลี้ยง 55555',
                            controller: txtCustomer,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.arrow_drop_down),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          labelText: "ลูกค้าของคุณ",
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => ContainerCustomer())).then((value) {
                            setState(() {
                              txtCustomer.text = globals.customer?.custName;
                            });
                          });
                        },
                      )),
                    ],
                  )),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                          child: Stack(
                              //height: 200,
                              children: [
                        dashboardCard(
                            'ใบเสนอราคา', 'assets/business_drawing.jpg'),
                        new Positioned.fill(
                            child: new Material(
                                color: Colors.transparent,
                                child: new InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () => null,
                                )))
                      ]))),
                  Expanded(
                      child: Container(
                          child: Stack(
                              //height: 200,
                              children: [
                        dashboardCard(
                            'สั่งสินค้า', 'assets/business_click.jpg'),
                        new Positioned.fill(
                            child: new Material(
                                color: Colors.transparent,
                                child: new InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    if(globals.customer == null){
                                      return showDialog(
                                        context: context,
                                        builder: (BuildContext context) => new CupertinoAlertDialog(
                                          title: new Text("แจ้งเตือน"),
                                          content: new Text("กรุณาเลือกลูกค้าของคุณ", style: TextStyle(fontSize: 18),),
                                          actions: [
                                            CupertinoDialogAction(
                                                isDefaultAction: true, onPressed: () => Navigator.pop(context), child: Text("ปิดหน้าต่าง"))
                                          ],
                                        ),
                                      );
                                    }

                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => SaleOrder()));
                                  },
                                )))
                      ]))),
                  Expanded(
                      child: Container(
                          child: Stack(
                              //height: 200,
                              children: [
                        dashboardCard(
                            'เข้าเยี่ยม', 'assets/business_marketing.jpg'),
                        new Positioned.fill(
                            child: new Material(
                                color: Colors.transparent,
                                child: new InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () => null,
                                )))
                      ]))),
                  Expanded(
                      child: Container(
                          child: dashboardCard(
                              'เช็คสต๊อค', 'assets/business_inventory.jpg'))),
                ],
              ),
              Row(
                children: [
                  Container(
                      height: 152.5,
                      width: 190,
                      child: dashboardCard(
                          'บริการ', 'assets/business_support.jpg'))
                ],
              ),
            ],
          ),
        ),

    );
  }
}
