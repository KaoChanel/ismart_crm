import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import 'containerProduct.dart';
import 'package:ismart_crm/globals.dart' as globals;

// Show Dialog function
void _showDialog(context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return alert dialog object
      return AlertDialog(
        elevation: 0,
        title: new Text('I am Title'),
        content: Container(
          height: 150.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Icon(Icons.toys),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text(' First Item'),
                  ),
                ],
              ),
              new SizedBox(
                height: 20.0,
              ),
              new Row(
                children: <Widget>[
                  new Icon(Icons.toys),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text(' Second Item'),
                  ),
                ],
              ),
              new SizedBox(
                height: 20.0,
              ),
              new Row(
                children: <Widget>[
                  new Icon(Icons.toys),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: new Text('Third Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

dynamic _selectDate(BuildContext context, DateTime _selectedDate,
    TextEditingController _textEditController) async {
  DateTime newSelectedDate = await showDatePicker(
    context: context,
    initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
    firstDate: DateTime(1995),
    lastDate: DateTime(2030),
    // builder: (BuildContext context, Widget child) {
    //   return Theme(
    //     data: ThemeData.dark().copyWith(
    //       colorScheme: ColorScheme.dark(
    //         primary: Colors.deepPurple,
    //         onPrimary: Colors.white,
    //         surface: Colors.blueGrey,
    //         onSurface: Colors.yellow,
    //       ),
    //       dialogBackgroundColor: Colors.blue[500],
    //     ),
    //     child: child,
    //   );
    // }
  );

  if (newSelectedDate != null) {
    _selectedDate = newSelectedDate;
    _textEditController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);

    // _textEditingController..text = DateFormat.yMMMd().format(_selectedDate)..selection = TextSelection.fromPosition(TextPosition(
    //       offset: _textEditingController.text.length,
    //       affinity: TextAffinity.upstream));
  }
}

Widget SaleOrderDetails() {
  return DataTable(
    columns: const <DataColumn>[
      DataColumn(
        label: Text(
          'ลำดับ',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'ประเภท',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'รหัสสินค้า',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'ชื่อสินค้า',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'จำนวน',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'ราคา / หน่วย',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'ส่วนลด',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'ยอดสุทธิ',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          '',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          '',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    ],
    rows: const <DataRow>[
      DataRow(
        cells: <DataCell>[
          DataCell(Text('1')),
          DataCell(Text('-')),
          DataCell(Text('Student')),
          DataCell(Text('Sarah')),
          DataCell(Text('19')),
          DataCell(Text('Student')),
          DataCell(Text('Sarah')),
          DataCell(Text('19')),
          DataCell(Text('Student')),
          DataCell(Text('Student')),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(Text('2')),
          DataCell(Text('-')),
          DataCell(Text('Student')),
          DataCell(Text('Sarah')),
          DataCell(Text('19')),
          DataCell(Text('Student')),
          DataCell(Text('Sarah')),
          DataCell(Text('19')),
          DataCell(Text('Student')),
          DataCell(Text('Student')),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(Text('3')),
          DataCell(Text('-')),
          DataCell(Text('Student')),
          DataCell(Text('Sarah')),
          DataCell(Text('19')),
          DataCell(Text('Student')),
          DataCell(Text('Sarah')),
          DataCell(Text('19')),
          DataCell(Text('Student')),
          DataCell(Text('Student')),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(Text('4')),
          DataCell(Text('-')),
          DataCell(Text('Student')),
          DataCell(Text('Sarah')),
          DataCell(Text('19')),
          DataCell(Text('Student')),
          DataCell(Text('Sarah')),
          DataCell(Text('19')),
          DataCell(Text('Student')),
          DataCell(Text('Student')),
        ],
      ),
      DataRow(
        cells: <DataCell>[
          DataCell(Text('5')),
          DataCell(Text('-')),
          DataCell(Text('Student')),
          DataCell(Text('Sarah')),
          DataCell(Text('19')),
          DataCell(Text('Student')),
          DataCell(Text('Sarah')),
          DataCell(Text('19')),
          DataCell(Text('Student')),
          DataCell(Text('Student')),
        ],
      ),
    ],
  );
}

class SaleOrder extends StatefulWidget {
  @override
  _SaleOrderState createState() => _SaleOrderState();
}

class _SaleOrderState extends State<SaleOrder> {
  DateTime _docuDate = DateTime.now();
  DateTime _shiptoDate = DateTime.now().add(new Duration(hours: 24));
  DateTime _orderDate;
  TextEditingController txtDocuNo;
  TextEditingController txtSONo;
  TextEditingController txtDeptCode;
  TextEditingController txtCopyDocuNo;
  TextEditingController txtEmpCode;
  TextEditingController txtEmpName;
  TextEditingController txtCustCode;
  TextEditingController txtCustName;
  TextEditingController txtCreditType;
  TextEditingController txtCredit;
  TextEditingController txtStatus;
  TextEditingController txtRemark;
  TextEditingController txtDocuDate = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  TextEditingController txtShiptoDate = TextEditingController(
      text: DateFormat('dd/MM/yyyy')
          .format(DateTime.now().add(new Duration(hours: 24))));
  TextEditingController txtOrderDate = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Sale Order"),
          ),
        ),
        body: ListView(children: [
          Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 11),
                    padding: EdgeInsets.all(10),
                    width: 350,
                    //color: Colors.indigo,
                    child: Text(
                      'หัวบิล การสั่งสินค้า',
                      style: GoogleFonts.sarabun(
                          color: Colors.white, fontSize: 20),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(0)),
                      color: Colors.indigo,
                      // boxShadow: [
                      //   BoxShadow(color: Colors.green, spreadRadius: 3),
                      // ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(children: [
                Flexible(
                  flex: 2,
                  child: ListTile(
                    //
                    title: TextFormField(
                      initialValue: '00001',
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "เลขที่",
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ListTile(
                    title: TextFormField(
                      controller: txtDocuDate,
                      // initialValue: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                      readOnly: true,
                      onTap: () {
                        setState(() async {
                          _docuDate = await showDatePicker(
                            context: context,
                            initialDate:
                                _docuDate != null ? _docuDate : DateTime.now(),
                            firstDate: DateTime(1995),
                            lastDate: DateTime(2030),
                          );
                          txtDocuDate.text = DateFormat('dd/MM/yyyy').format(_docuDate);
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "วันที่เอกสาร",
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ListTile(
                    //leading: const Icon(Icons.person),
                    title: TextFormField(
                      initialValue: 'ฝ่ายขาย',
                      readOnly: true,
                      onTap: () {
                        //_showDialog(context);
                      },
                      decoration: InputDecoration(
                        // filled: true,
                        // fillColor: Colors.amberAccent[100],
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "แผนก",
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ListTile(
                    title: TextFormField(
                      controller: txtShiptoDate,
                      readOnly: true,
                      onTap: () {
                        setState(() async {
                          _shiptoDate = await showDatePicker(
                            context: context,
                            initialDate:
                            _shiptoDate != null ? _shiptoDate : DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(new Duration(hours: 168)),
                          );
                          txtShiptoDate.text = DateFormat('dd/MM/yyyy').format(_shiptoDate);
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "วันที่ส่ง (ปกติ 1 วัน)",
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 15),
              Row(children: [
                Flexible(
                  flex: 2,
                  child: ListTile(
                    title: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "เลขที่ใบสั่งซื้อลูกค้า",
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ListTile(
                    title: TextField(
                      controller: txtOrderDate,
                      readOnly: true,
                      onTap: () {
                        setState(() async {
                          _orderDate = await showDatePicker(
                            context: context,
                            initialDate:
                            _orderDate != null ? _orderDate : DateTime.now(),
                            firstDate: DateTime(1995),
                            lastDate: DateTime(2030),
                          );
                          txtOrderDate.text = DateFormat('dd/MM/yyyy').format(_orderDate);
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'วันที่สั่งซื้อลูกค้า',
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ListTile(
                    //leading: const Icon(Icons.person),
                    title: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        labelText: 'จากใบเสนอราคา',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 15),
              Row(children: [
                Flexible(
                  flex: 2,
                  child: ListTile(
                    title: TextFormField(
                      enabled: false,
                      initialValue: globals.employee?.empCode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "รหัสพนักงาน",
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ListTile(
                    title: TextFormField(
                      enabled: false,
                      initialValue: globals.employee?.empName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'ชื่อพนักงาน',
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 15),
              Row(children: [
                Flexible(
                  flex: 2,
                  child: ListTile(
                    title: TextFormField(
                      enabled: false,
                      initialValue: globals.customer?.custCode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "รหัสลูกค้า",
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ListTile(
                    title: TextFormField(
                      enabled: false,
                      initialValue: globals.customer?.custName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'ชื่อลูกค้า',
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 15),
              Row(children: [
                Flexible(
                  flex: 2,
                  child: ListTile(
                    title: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "ประเภทเครดิต",
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ListTile(
                    title: TextFormField(
                      //initialValue: globals.customer?,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'เครดิต',
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ListTile(
                    //leading: const Icon(Icons.person),
                    title: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        labelText: 'สถานะ',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(height: 15),
              Row(children: [
                Flexible(
                  flex: 6,
                  child: ListTile(
                    title: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "หมายเหตุ",
                      ),
                    ),
                  ),
                ),
              ]),
              Row(
                children: [
                  SizedBox(height: 80),
                  Container(
                    margin: EdgeInsets.only(top: 11),
                    padding: EdgeInsets.all(10),
                    width: 350,
                    child: Text(
                      'สถานที่จัดส่ง',
                      style: GoogleFonts.sarabun(
                          color: Colors.white, fontSize: 20),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(0)),
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
              Row(children: [
                Flexible(
                  flex: 2,
                  child: ListTile(
                    title: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "สถานที่ส่งจริง",
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ListTile(
                    title: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'สถานที่ส่ง',
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ListTile(
                    //leading: const Icon(Icons.person),
                    title: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        labelText: 'ส่งจังหวัด',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                ),
              ]),
              Row(
                children: [
                  SizedBox(height: 80),
                  Container(
                    margin: EdgeInsets.only(top: 11),
                    padding: EdgeInsets.all(10),
                    width: 350,
                    child: Text(
                      'รายการสินค้าขาย',
                      style: GoogleFonts.sarabun(
                          color: Colors.white, fontSize: 20),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(0)),
                      color: Colors.indigo,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                      margin: EdgeInsets.only(top: 13, left: 30),
                      child: RaisedButton.icon(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      MasterDetailContainer()))
                        },
                        icon: Icon(Icons.add_circle_outline_outlined,
                            color: Colors.white),
                        color: Colors.green,
                        splashColor: Colors.green,
                        padding: EdgeInsets.all(10),
                        label: Text(
                          'เพิ่มรายการสินค้า',
                          style: GoogleFonts.sarabun(
                              fontSize: 14, color: Colors.white),
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 13, left: 20),
                      child: RaisedButton.icon(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MasterDetailContainer()))
                        },
                        icon: Icon(Icons.local_fire_department,
                            color: Colors.white),
                        color: Colors.deepOrange,
                        padding: EdgeInsets.all(10),
                        label: Text(
                          'เพิ่มรายการด่วน',
                          style: GoogleFonts.sarabun(
                              fontSize: 14, color: Colors.white),
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 13, left: 20),
                      child: RaisedButton.icon(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MasterDetailContainer()))
                        },
                        icon: Icon(Icons.list, color: Colors.white),
                        color: Colors.blueAccent,
                        padding: EdgeInsets.all(10),
                        label: Text(
                          'เพิ่มรายการโปรโมชั่น',
                          style: GoogleFonts.sarabun(
                              fontSize: 14, color: Colors.white),
                        ),
                      )),
                ],
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    SaleOrderDetails(),
                  ])),
              Row(
                children: [
                  SizedBox(height: 80),
                  Container(
                    margin: EdgeInsets.only(top: 11),
                    padding: EdgeInsets.all(10),
                    width: 350,
                    child: Text(
                      'ท้ายบิล การสั่งสินค้า',
                      style: GoogleFonts.sarabun(
                          color: Colors.white, fontSize: 20),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(0)),
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
            ],
          )
        ]));
  }
}
