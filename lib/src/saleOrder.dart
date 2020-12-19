import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismart_crm/models/shipto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'containerProduct.dart';
import 'package:http/http.dart' as http;
import 'package:ismart_crm/api_service.dart';
import 'package:ismart_crm/globals.dart' as globals;
import 'package:ismart_crm/models/saleOrder_header.dart';
import 'package:ismart_crm/models/saleOrder_detail.dart';

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

void _showShiptoDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return alert dialog object
      return AlertDialog(
        title: new Text('เลือกสถานที่จัดส่ง'),
        content: Container(
          height: 150.0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // new Row(
                //   children: <Widget>[
                //     new Icon(Icons.toys),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 8.0),
                //       child: new Text(' First Item'),
                //     ),
                //   ],
                // ),
                // new SizedBox(
                //   height: 20.0,
                // ),
                // new Row(
                //   children: <Widget>[
                //     new Icon(Icons.toys),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 8.0),
                //       child: new Text(' Second Item'),
                //     ),
                //   ],
                // ),
                // new SizedBox(
                //   height: 20.0,
                // ),
                // new Row(
                //   children: <Widget>[
                //     new Icon(Icons.toys),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 8.0),
                //       child: new Text('Third Item'),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class SaleOrder extends StatefulWidget {
  @override
  _SaleOrderState createState() => _SaleOrderState();
}

class _SaleOrderState extends State<SaleOrder> {
  ApiService _apiService = new ApiService();
  final currency = new NumberFormat("#,##0.00", "en_US");
  double vat = 0.7;
  double priceTotal = 0;
  double discountTotal = 0;
  double discountBill = 0;
  double priceAfterDiscount = 0;
  double vatTotal = 0.0;
  double netTotal = 0.0;
  DateTime _docuDate = DateTime.now();
  DateTime _shiptoDate = DateTime.now().add(new Duration(hours: 24));
  DateTime _orderDate;

  FocusNode focusDiscount = FocusNode();
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

  TextEditingController txtShiptoName;
  TextEditingController txtShiptoCode;
  TextEditingController txtShiptoProvince = new TextEditingController();
  TextEditingController txtShiptoAddress = new TextEditingController();
  TextEditingController txtShiptoRemark = new TextEditingController();
  TextEditingController txtPriceTotal = new TextEditingController();
  TextEditingController txtDiscountTotal = new TextEditingController();
  TextEditingController txtDiscountBill = new TextEditingController();
  TextEditingController txtPriceAfterDiscount = new TextEditingController();
  TextEditingController txtVatTotal = new TextEditingController();
  TextEditingController txtNetTotal = new TextEditingController();

  TextEditingController txtDocuDate = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  TextEditingController txtShiptoDate = TextEditingController(
      text: DateFormat('dd/MM/yyyy')
          .format(DateTime.now().add(new Duration(hours: 24))));
  TextEditingController txtOrderDate = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSelectedShipto();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusDiscount.dispose();
  }

  Widget setDiscountType(){
    if(globals.discountType == globals.DiscountType.THB){
      return Text('THB');
    }
    else{
      return Text('%');
    }
  }

  void calculateSummary(){
    //print(globals.productCart.length.toString());
    if(globals.productCart.length > 0){
      discountTotal = 0; priceTotal = 0;
      globals.productCart.forEach((element) {discountTotal += element.discount;});
      globals.productCart.forEach((element) {priceTotal += element.goodAmount;});
    }
    else{
      discountTotal = 0;
      priceTotal = 0;
      priceAfterDiscount = 0;
      globals.discountBill = 0;
      vatTotal = 0;
      netTotal = 0;
    }

    priceTotal = priceTotal - discountTotal;
    priceAfterDiscount = priceTotal - globals.discountBill;
    vatTotal = (priceAfterDiscount * vat) / 100;
    netTotal = priceAfterDiscount + vatTotal;

    setState(() {
      txtDiscountTotal.text = currency.format(discountTotal);
      txtPriceTotal.text = currency.format(priceTotal);
      txtDiscountBill.text = currency.format(globals.discountBill);
      txtPriceAfterDiscount.text = currency.format(priceAfterDiscount);
      txtVatTotal.text = currency.format(vatTotal);
      txtNetTotal.text = currency.format(netTotal);
    });
  }

  void setSelectedShipto() {
    setState(() {
      txtShiptoProvince.text = globals.selectedShipto.province ?? '';
      txtShiptoAddress.text = '${globals.selectedShipto.shiptoAddr1 ?? ''} '
          '${globals.selectedShipto?.shiptoAddr2 ?? ''} '
          '${globals.selectedShipto?.district ?? ''} '
          '${globals.selectedShipto?.amphur ?? ''} '
          '${globals.selectedShipto?.province ?? ''} '
          '${globals.selectedShipto?.postcode ?? ''}';
      txtShiptoRemark.text = globals.selectedShipto.remark ?? '';
    });
  }

  Widget getShiptoListWidgets(BuildContext context) {
    List<Shipto> shiptoList = globals.allShipto
        .where((element) => element.custId == globals.customer.custId)
        .toList();
    print(shiptoList);
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < shiptoList?.length; i++) {
      list.add(ListTile(
        title: Text(shiptoList[i].shiptoAddr1),
        //subtitle: Text(item?.custCode),
        onTap: () {
          globals.selectedShipto = shiptoList[i];
          Navigator.pop(context);
          setState(() {});
        },
        selected:
            globals.selectedShipto.shiptoAddr1 == shiptoList[i].shiptoAddr1,
        selectedTileColor: Colors.grey[200],
        hoverColor: Colors.grey,
      ));
    }
    return ListView(children: list);
  }

  Future<void> postSaleOrder() async {
    try
    {
      SaleOrderHeader header = new SaleOrderHeader();
      List<SaleOrderDetail> detail = new List<SaleOrderDetail>();

      /// document header.
      header.soid = 0;
      header.docuNo = txtDocuNo?.text ?? '';
      header.docuType = 104;
      header.docuDate = _docuDate;
      header.goodType = '1';
      header.docuStatus = 'Y';
      header.isTransfer = 'N';
      header.remark = txtRemark?.text ?? '';
      /// employee information.
      header.empId = globals.employee.empId;
      header.deptId = globals.employee.deptId;
      /// customer information.
      header.custId = globals.customer.custId;
      header.custName = globals.customer.custName;
      header.creditDays = globals.customer.creditDays;
      /// cost summary.
      header.sumGoodAmnt = netTotal;
      header.billAftrDiscAmnt = netTotal;
      header.netAmnt = netTotal;
      header.billDiscAmnt = discountBill;
      /// shipment to customer.
      header.shipToCode = globals.selectedShipto.shiptoCode;
      header.transpId = globals.selectedShipto.transpId;
      header.transpAreaId = globals.selectedShipto.transpAreaId;
      header.shipToAddr1 = globals.selectedShipto.shiptoAddr1;
      header.shipToAddr2 = globals.selectedShipto.shiptoAddr2;
      header.district = globals.selectedShipto.district;
      header.amphur = globals.selectedShipto.amphur;
      header.province = globals.selectedShipto.province;
      header.postCode = globals.selectedShipto.postcode;

      bool isSuccess = false;
      _apiService.addSaleOrderHeader(header).then((value) {
        isSuccess = value;
      });
      print('Add result: $isSuccess');
      if(isSuccess) {
        globals.productCart.map((e) {
          SaleOrderDetail obj = new SaleOrderDetail();
          obj.soid = header.soid;
          obj.listNo = e.rowIndex;
          obj.docuType = 104;
          obj.goodId = e.goodId;
          obj.goodCode = e.goodCode;
          obj.goodUnitId2 = e.mainGoodUnitId;
          obj.goodQty2 = e.goodQty;
          obj.goodPrice2 = e.goodPrice;
          obj.goodAmnt = e.goodAmount;
          obj.goodDiscAmnt = e.discount;
          detail.add(obj);
        });
      }
    }
    catch(e){
      showAboutDialog(
          context: context,
          applicationName: 'Post Sale Order Exception',
          applicationIcon: Icon(Icons.error_outline),
          children:[
            Text(e),
          ]);
    }
  }

// Show Dialog function
  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object
        return AlertDialog(
            elevation: 0,
            title: new Text('สถานที่จัดส่ง'),
            content:
                Container(
                    width: 500,
                    height: 300,
                    child: getShiptoListWidgets(context)));
      },
    );
  }

  void showDiscountTypeDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object
        return AlertDialog(
            elevation: 0,
            title: new Text('ประเภทส่วนลด'),
            content:
            Container(
                width: 250,
                height: 180,
                child: ListView(
                  children:[
                    ListTile(
                      onTap: (){
                        //discountType = globals.DiscountType.THB;
                        globals.discountType = globals.DiscountType.THB;
                        Navigator.pop(context);
                        setState(() {});
                      },
                        selected: globals.discountType == globals.DiscountType.THB,
                        selectedTileColor: Colors.black12,
                        title: Text('THB')
                    ),
                    ListTile(
                      onTap: (){
                        //discountType = globals.DiscountType.PER;
                        globals.discountType = globals.DiscountType.PER;
                        Navigator.pop(context);
                        setState(() {});
                      },
                      selected: globals.discountType == globals.DiscountType.PER,
                      selectedTileColor: Colors.black12,
                      title: Text('%'),
                    )
                  ]
                )
            ));
      },
    );
  }

  Widget SaleOrderDetails() {
    return DataTable(
      showBottomBorder: true,
        columnSpacing: 26,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'ลำดับ',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
          ),
          DataColumn(
            label: Text(
              'ประเภท',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
          ),
          DataColumn(
            label: Text(
              'รหัสสินค้า',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
          ),
          DataColumn(
            label: Text(
              'ชื่อสินค้า',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
          ),
          DataColumn(
            numeric: true,
            label: Text(
              'จำนวน',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
          ),
          DataColumn(
            numeric: true,
            label: Text(
              'ราคา / หน่วย',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
          ),
          DataColumn(
            numeric: true,
            label: Text(
              'ส่วนลด',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
          ),
          DataColumn(
            numeric: true,
            label: Text(
              'ยอดสุทธิ',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
          ),
          DataColumn(
            label: Text(
              '',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          // DataColumn(
          //   label: Text(
          //     '',
          //     style: TextStyle(fontStyle: FontStyle.italic),
          //   ),
          // ),
        ],
        rows: globals.productCart
                ?.map((e) => DataRow(cells: [
                      DataCell(Text('${e.rowIndex}')),
                      DataCell(Text('${e.goodTypeFlag}')),
                      DataCell(Text('${e.goodCode}')),
                      DataCell(Text('${e.goodName1}')),
                      DataCell(Text('${currency.format(e.goodQty)}')),
                      DataCell(Text('${currency.format(e.goodPrice)}')),
                      DataCell(Text('${currency.format(e.discount)}')),
                      DataCell(Text('${currency.format(e.goodAmount)}')),
                      DataCell(Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          ContainerProduct('แก้ไขรายการสินค้า ลำดับที่ ', e))).then((value) {
                                setState(() {});
                              });
                            },
                            child: Icon(Icons.edit),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blueAccent),
                            ),
                          ),
                          SizedBox(width: 10,),
                          ElevatedButton(
                            onPressed: () {
                              //int removeIndex = globals.productCart.indexWhere((element) => element.rowIndex == e.rowIndex);
                              int index = 1;
                              globals.productCart.removeWhere(
                                  (element) => element.rowIndex == e.rowIndex);
                              globals.productCart.forEach((element) {element.rowIndex = index++;});
                              globals.editingProductCart = null;
                              print(globals.productCart?.length.toString());
                              setState(() {});
                            },
                            child: Icon(Icons.delete_forever),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.redAccent),
                            ),
                          )
                        ],
                      )),
                      // DataCell(ElevatedButton(
                      //     onPressed: () {},
                      //     child: Icon(Icons.delete_forever),
                      //   style: ButtonStyle(
                      //     backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                      //   ),)),
                    ]))
                ?.toList() ??
            <DataRow>[
              DataRow(cells: [
                DataCell(Text('ยังไม่มีรายการคำสั่ง')),
                DataCell(Text('ยังไม่มีรายการคำสั่ง')),
                DataCell(Text('ยังไม่มีรายการคำสั่ง')),
                DataCell(Text('ยังไม่มีรายการคำสั่ง')),
                DataCell(Text('ยังไม่มีรายการคำสั่ง')),
                DataCell(Text('ยังไม่มีรายการคำสั่ง')),
                DataCell(Text('ยังไม่มีรายการคำสั่ง')),
                DataCell(Text('ยังไม่มีรายการคำสั่ง')),
                DataCell(Text('ยังไม่มีรายการคำสั่ง')),
                DataCell(Text('ยังไม่มีรายการคำสั่ง')),
              ])
            ]);
  }

  Widget build(BuildContext context) {

    setSelectedShipto();
    calculateSummary();

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
                      color: Colors.deepPurple,
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
                          txtDocuDate.text =
                              DateFormat('dd/MM/yyyy').format(_docuDate);
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
                            initialDate: _shiptoDate != null
                                ? _shiptoDate
                                : DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(new Duration(hours: 168)),
                          );
                          txtShiptoDate.text =
                              DateFormat('dd/MM/yyyy').format(_shiptoDate);
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
                            initialDate: _orderDate != null
                                ? _orderDate
                                : DateTime.now(),
                            firstDate: DateTime(1995),
                            lastDate: DateTime(2030),
                          );
                          txtOrderDate.text =
                              DateFormat('dd/MM/yyyy').format(_orderDate);
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
                  flex: 1,
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
                  flex: 1,
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
                      initialValue: globals.customer?.creditDays.toString(),
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
                    title: TextFormField(
                      //initialValue: globals.customer?.,
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
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Flexible(
                  flex: 2,
                  child: ListTile(
                    title: TextFormField(
                      initialValue: globals.customer?.custName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "ชื่อสถานที่ส่งจริง",
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ListTile(
                    title: TextFormField(
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
                    title: TextFormField(
                      controller: txtShiptoProvince,
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                SizedBox(height: 80),
                Flexible(
                  flex: 6,
                  child: ListTile(
                    title: TextFormField(
                      //initialValue: globals.customer?.,
                      controller: txtShiptoAddress,
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
                    child: SizedBox(
                  height: 47,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        //_showShiptoDialog(context);
                        _showDialog(context);
                      },
                      icon: Icon(Icons.airport_shuttle),
                      label: Text('สถานที่ส่ง')),
                )),
                Flexible(
                    child: SizedBox(
                  height: 47,
                  child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          globals.selectedShipto = globals.allShipto.firstWhere(
                              (element) =>
                                  element.custId == globals.customer.custId &&
                                  element.isDefault == 'Y');
                        });
                        Fluttertoast.showToast(
                            msg: "ใช้ค่าเริ่มต้นเรียบร้อย",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black54,
                            textColor: Colors.white,
                            fontSize: 18.0);
                      },
                      icon: Icon(Icons.refresh),
                      label: Text('ค่าเริ่มต้น')),
                )),
              ]),
              Row(children: [
                SizedBox(height: 60),
                Flexible(
                  flex: 6,
                  child: ListTile(
                    title: TextFormField(
                      controller: txtShiptoRemark,
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
                      'รายการสินค้าขาย',
                      style: GoogleFonts.sarabun(
                          color: Colors.white, fontSize: 20),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(0)),
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                      margin: EdgeInsets.only(top: 13, left: 30),
                      child: RaisedButton.icon(
                        onPressed: ()  {
                          globals.editingProductCart = null;
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      ContainerProduct('สั่งรายการสินค้า ลำดับที่ ', null))).then((value)
                          {
                            globals.editingProductCart = null;
                            setState(() {});
                          });
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
                        onPressed: () {
                        globals.editingProductCart = null;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                    ContainerProduct('สั่งรายการสินค้า ลำดับที่ ', null)
                              ));
                        },
                        icon: Icon(Icons.local_fire_department,
                            color: Colors.white),
                        color: Colors.deepOrange[400],
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
                        onPressed: () {
                          globals.editingProductCart = null;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContainerProduct('สั่งรายการสินค้า ลำดับที่ ', null)));
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
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.add_comment),
                      label: Text(
                        'ข้อความหมายเหตุ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  //Expanded(child: SizedBox()),
                  //Spacer(),
                  SizedBox(width: 235,),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('รวมส่วนลด',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      Flexible(
                        child: TextFormField(
                          readOnly: true,
                          controller: txtDiscountTotal,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            //labelText: "0.00",
                            //border: OutlineInputBorder()
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 8.0),
                        child: Text('รวมเงิน',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: TextFormField(
                            readOnly: true,
                            controller: txtPriceTotal,
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              //border: OutlineInputBorder()
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),

              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                      child:
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextFormField(
                                  maxLines: 8,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    labelText: "หมายเหตุ",
                                    //border: OutlineInputBorder()
                                  ),
                        ),
                      )
                  ),
                  //Spacer(),
                  SizedBox(width: 210,),
                  Expanded(
                      flex: 1,
                      child:
                      Column(
                          children:[
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 122,
                                  child: Text('ส่วนลดท้ายบิล',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: ElevatedButton(
                                      onPressed: (){
                                        showDiscountTypeDialog();
                                        focusDiscount.requestFocus();
                                      },
                                      child: setDiscountType()),
                                ),
                                Expanded(
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: txtDiscountBill,
                                        focusNode: focusDiscount,
                                        textAlign: TextAlign.right,
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        onEditingComplete: (){
                                          setState(() {
                                            globals.discountBill = double.tryParse(txtDiscountBill.text.replaceAll(',', ''));
                                          });
                                          FocusScope.of(context).unfocus();
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                          //border: OutlineInputBorder()
                                        ),
                                      ),
                                    ))
                              ],
                            ),

                            Row(
                              children: [
                                SizedBox(
                                  width: 195,
                                  child: Text('ยอดก่อนรวมภาษี',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        readOnly: true,
                                        controller: txtPriceAfterDiscount,
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                          //border: OutlineInputBorder()
                                        ),
                                      ),
                                    ))
                              ],
                            ),

                            Row(
                              children: [
                                SizedBox(
                                  width: 195,
                                  child: Text('ภาษี 7%',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        readOnly: true,
                                        controller: txtVatTotal,
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                          //border: OutlineInputBorder()
                                        ),
                                      ),
                                    )
                                )
                              ],
                            ),

                            Row(
                              children: [
                                SizedBox(
                                  width: 195,
                                  child: Text('รวมสุทธิ',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        readOnly: true,
                                        controller: txtNetTotal,
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                          //border: OutlineInputBorder()
                                        ),
                                      ),
                                    ),
                                )
                              ],
                            ),

                          ]))
                ],
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Expanded(
              //       flex: 1,
              //       child: TextFormField(
              //         readOnly: true,
              //         textAlign: TextAlign.right,
              //         maxLines: 8,
              //         decoration: InputDecoration(
              //           border: OutlineInputBorder(),
              //           contentPadding:
              //               EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              //           floatingLabelBehavior: FloatingLabelBehavior.always,
              //           labelText: "หมายเหตุ",
              //           //border: OutlineInputBorder()
              //         ),
              //       ),
              //     ),
              //     Spacer(),
              //     Expanded(
              //       flex: 1,
              //         child:
              //         Row(
              //             children: [
              //               Expanded(child: Row(
              //                 children: [
              //                   Text('ส่วนลดท้ายบิล'),
              //                   Expanded(flex:6,child: TextField())
              //                 ],
              //               )),
              //               Expanded(flex:8,child: Row(
              //                 children: [
              //                   Text('ส่วนลดท้ายบิล'),
              //                   Expanded(child: TextField())
              //                 ],
              //               )),
              //               // Expanded(child: TextField()),
              //               // Text('ส่วนลดท้ายบิล'),
              //               // Expanded(child: TextField()),
              //             ],
              //           ),
              //
              //         ),
              //   ],
              // ),
              Row(
                children: [
                  Expanded(
                    child:
                    Container(
                      height: 100,
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ElevatedButton(
                          onPressed: (){
                            postSaleOrder();
                            //print(jsonEncode(globals.productCart));
                          },
                          child: Text('ยืนยันคำสั่งสินค้า', style: TextStyle(fontSize: 20),)
                      ),
                    ),
                  )
                ],
              ),
              //SizedBox(height: 20,)
            ],
          )

        ]));
  }
}
