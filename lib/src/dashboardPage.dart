import 'package:flutter/material.dart';
import 'package:ismart_crm/widgets/navDrawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'saleOrder.dart';

class Item {
  const Item(this.name, this.icon);

  final String name;
  final Icon icon;
}

List<Item> users = <Item>[
  const Item(
      'Android',
      Icon(
        Icons.android,
        color: const Color(0xFF167F67),
      )),
  const Item(
      'Flutter',
      Icon(
        Icons.flag,
        color: const Color(0xFF167F67),
      )),
  const Item(
      'ReactNative',
      Icon(
        Icons.format_indent_decrease,
        color: const Color(0xFF167F67),
      )),
  const Item(
      'iOS',
      Icon(
        Icons.mobile_screen_share,
        color: const Color(0xFF167F67),
      )),
];

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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sale CRM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  State createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  Item selectedUser;
  List<Item> users = <Item>[
    const Item(
        'Android',
        Icon(
          Icons.android,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Flutter',
        Icon(
          Icons.flag,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'ReactNative',
        Icon(
          Icons.format_indent_decrease,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'iOS',
        Icon(
          Icons.mobile_screen_share,
          color: const Color(0xFF167F67),
        )),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Sale CRM'),
      ),
      body: DoubleBackToCloseApp(
    snackBar: const SnackBar(
    content: Text('Tap back again to leave', textAlign: TextAlign.center,)),
        child:
        SafeArea(
        child: ListView(
          children: <Widget>[
            Row(
              children: [
                //Padding(padding: null)
                Text("ลูกค้า : "),
                DropdownButton<Item>(
                  hint: Text("Select item"),
                  value: selectedUser,
                  onChanged: (Item Value) {
                    setState(() {
                      selectedUser = Value;
                    });
                  },
                  items: users.map((Item user) {
                    return DropdownMenuItem<Item>(
                      value: user,
                      child: Row(
                        children: <Widget>[
                          user.icon,
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            user.name,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
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
                      dashboardCard('สั่งสินค้า', 'assets/business_click.jpg'),
                      new Positioned.fill(
                          child: new Material(
                              color: Colors.transparent,
                              child: new InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SaleOrder())),
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
                            'บริการ', 'assets/business_inventory.jpg'))),
              ],
            ),
            Row(
              children: [
                Container(
                    height: 152.5,
                    width: 190,
                    child:
                        dashboardCard('บริการ', 'assets/business_support.jpg'))
              ],
            ),
          ],
        ),
      ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Main'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            title: Text('Reports'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outlined),
            title: Text('News'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            title: Text('Profile'),
          ),
        ],
        // currentIndex: _selectedIndex,
        // onTap: _onItemTapped,
      ),
    );
  }
}
