import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ismart_crm/globals.dart' as globals;
import 'package:ismart_crm/models/saleOrder_header.dart';
import 'package:intl/intl.dart';
import 'package:ismart_crm/api_service.dart';
import 'saleOrderEdit.dart';

class StatusTransferDoc extends StatefulWidget {
  @override
  _StatusTransferDocState createState() => _StatusTransferDocState();
}

class _StatusTransferDocState extends State<StatusTransferDoc> {
  bool sort = true;
  List<SaleOrderHeader> tempSOHD;
  SaleOrderHeader selectedItem;
  List<SaleOrderHeader> selectedTempSOHD = new List<SaleOrderHeader>();
  String _selectedType = 'ทั้งหมด';
  String _selectedStatus = 'ทั้งหมด';
  String _selectedSort = 'สถานะเอกสาร (Z-A)';
  ApiService _apiService = new ApiService();

  static const _docType = [
    'ทั้งหมด',
    'เข้าเยี่ยม',
    'บันทึกการเข้าเยี่ยม',
    'ใบเสนอราคา',
    'สั่งสินค้า',
    'แจ้งคืนสินค้า',
    'แบบสอบถาม',
  ];

  static const _status = [
    'ทั้งหมด',
    'ฉบับร่าง',
    'พร้อมส่ง',
    'ส่งแล้ว',
  ];

  static const _orderBy = [
    'สถานะเอกสาร (Z-A)',
    'สถานะเอกสาร (A-Z)',
    'วันที่บันทึก (Z-A)',
    'วันที่บันทึก (A-Z)',
    'ประเภทเอกสาร (Z-A)',
    'ประเภทเอกสาร (A-Z)',
    'เลขที่เอกสาร (Z-A)',
    'เลขที่เอกสาร (A-Z)',
    'รหัสลูกค้า (Z-A)',
    'รหัสลูกค้า (A-Z)',
    'ชื่อลูกค้า (Z-A)',
    'ชื่อลูกค้า (A-Z)',
  ];

  Future<List<SaleOrderHeader>> getSOHDByEmp(int id) async {
    try {
      String strUrl =
          '${globals.publicAddress}/api/SaleOrderHeader/GetTempSohdByEmp/${globals.company}/$id';
      final response = await http.get(strUrl);
      if (response.statusCode == 200) {
        return saleOrderHeaderFromJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Exception Get Sale Order'),
            content: Text(e.toString()),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.pop(context), child: Text('ตกลง'))
            ],
          ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        globals.tempSOHD.sort((a, b) => a.docuNo.compareTo(b.docuNo));
      } else {
        globals.tempSOHD.sort((a, b) => b.docuNo.compareTo(a.docuNo));
      }
    }
  }

  onSelectedRow(bool selected, SaleOrderHeader sohd) async {
    setState(() {
      if (selected) {
        selectedTempSOHD.add(sohd);
      } else {
        selectedTempSOHD.remove(sohd);
      }
    });
  }

  deleteSelected() async {
    setState(() {
      if (selectedTempSOHD.isNotEmpty) {
        List<SaleOrderHeader> temp = [];
        temp.addAll(selectedTempSOHD);
        for (SaleOrderHeader sohd in temp) {
          globals.tempSOHD.remove(sohd);
          selectedTempSOHD.remove(sohd);
        }
      }
    });
  }

  Widget dataBody(List<SaleOrderHeader> dataList) {
    int rowIndex = 1;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        sortColumnIndex: 0,
        sortAscending: sort,
        showCheckboxColumn: false,
        columns: [
          DataColumn(
            label: Text("ลำดับ", textAlign: TextAlign.center),
            numeric: false,
            tooltip: "ลำดับ",
          ),
          DataColumn(
            label: Text("สถานะเอกสาร", textAlign: TextAlign.center),
            tooltip: "สถานะเอกสาร",
          ),
          DataColumn(
            label: Text("วันที่บันทึก"),
            numeric: false,
            tooltip: "วันที่บันทึก",
          ),
          DataColumn(
            label: Text("วันที่ส่งสินค้า"),
            numeric: false,
            tooltip: "วันที่ส่งสินค้า",
          ),
          DataColumn(
              label: Text("เลขที่เอกสาร"),
              numeric: false,
              tooltip: "เลขที่เอกสาร",
              onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                onSort(columnIndex, ascending);
              }),
          DataColumn(
            label: Text("Reference No."),
            numeric: false,
            tooltip: "Reference No.",
          ),
          DataColumn(
              label: Text("รหัสลูกค้า"),
              numeric: false,
              tooltip: "รหัสลูกค้า",
              onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                onSort(columnIndex, ascending);
              }),
          DataColumn(
              label: Text("ชื่อลูกค้า"),
              numeric: false,
              tooltip: "ชื่อลูกค้า",
              onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                onSort(columnIndex, ascending);
              }),
        ],
        rows: dataList
                .asMap()
                .map((i, element) => MapEntry(
                    i,
                    DataRow(
                        // selected: selectedTempSOHD.contains(element),
                        selected: selectedItem == element ? true : false,
                        onSelectChanged: (isSelect) {
                          selectedItem = element;
                          onSelectedRow(isSelect, element);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SaleOrderEdit(
                                    saleOrderHD: element,
                                  )));
                          // if (element.isTransfer == 'N') {
                          //   selectedItem = element;
                          //   onSelectedRow(isSelect, element);
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => SaleOrderEdit(
                          //                 saleOrderHD: element,
                          //               )));
                          // } else {
                          //   showDialog(
                          //       context: context,
                          //       child: AlertDialog(
                          //         title: Text('แจ้งเตือน'),
                          //         content: Text(
                          //             'เลขที่เอกสาร ${element.docuNo} ถูกโอนแล้ว ไม่สามารถแก้ไขได้'),
                          //       ));
                          // }
                        },
                        cells: <DataCell>[
                          DataCell(
                            Center(
                              child: Text(
                                (i + 1).toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            //onTap: () {},
                          ),
                          DataCell(
                            Center(
                              child: Text(element.isTransfer == null
                                  ? ''
                                  : element.isTransfer == 'N'
                                      ? 'รอดำเนินการ'
                                      : 'ส่งเข้าระบบแล้ว',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: element.isTransfer == 'N' ? Colors.orange[600] : Colors.green,fontWeight: FontWeight.normal),),
                            ),
                            // onTap: () {
                            //   print('Selected ${element.isTransfer ?? ''}');
                            // },
                          ),
                          DataCell(
                            Text(element.docuDate == null
                                ? ''
                                : DateFormat('dd/MM/yyyy').format(element.docuDate)),
                          ),
                          DataCell(
                            Text(element.shipDate == null
                                ? ''
                                : DateFormat('dd/MM/yyyy').format(element.shipDate)),
                          ),
                          DataCell(
                            Text(element.docuNo ?? ''),
                          ),
                          DataCell(
                            Text(element.refNo ?? ''),
                          ),
                          DataCell(
                            Text(globals.allCustomer
                                    .firstWhere(
                                        (e) => e.custId == element.custId,
                                        orElse: null)
                                    .custCode ??
                                ''),
                          ),
                          DataCell(
                            Text(element.custName ?? ''),
                          ),
                        ])))
                .values
                ?.toList() ??
            <DataRow>[
              DataRow(cells: [
                DataCell(Text('-')),
                DataCell(Text('-')),
                DataCell(Text('-')),
                DataCell(Text('-')),
                DataCell(Text('-')),
                DataCell(Text('-')),
                DataCell(Text('-')),
                DataCell(Text('-')),
              ])
            ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // getSOHDByEmp(globals.employee.empId);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("สถานะ โอนรายการ"),
        ),
      ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(25),
          child: Row(
            children: [
              Expanded(
                  child: Row(children: [
                // Flexible(
                //     child: Text('ประเภทเอกสาร', style: TextStyle(fontSize: 16.0),)
                // ),
                Flexible(
                  child: InputDecorator(
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'ประเภทเอกสาร',
                        labelStyle: Theme.of(context)
                            .primaryTextTheme
                            .caption
                            .copyWith(color: Colors.black, fontSize: 16),
                        border: const OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(15.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          isDense: true,
                          // Reduces the dropdowns height by +/- 50%
                          icon: Icon(Icons.keyboard_arrow_down),
                          value: _selectedType,
                          items: _docType.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (selectedItem) => setState(
                            () => _selectedType = selectedItem,
                          ),
                        ),
                      )),
                )
              ])),
              Expanded(
                  child: Row(
                children: [
                  // Flexible(
                  //     child: Text('สถานะเอกสาร')
                  // ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'สถานะเอกสาร',
                        labelStyle: Theme.of(context)
                            .primaryTextTheme
                            .caption
                            .copyWith(color: Colors.black, fontSize: 16),
                        border: const OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(15.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          isDense: true,
                          // Reduces the dropdowns height by +/- 50%
                          icon: Icon(Icons.keyboard_arrow_down),
                          value: _selectedStatus,
                          items: _status.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (selectedItem) => setState(
                            () => _selectedStatus = selectedItem,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
              Expanded(
                  child: Row(
                children: [
                  //Flexible(child: Text('ค้นหา')),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                      child: TextFormField(
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: 'ค้นหา',
                      labelStyle: Theme.of(context)
                          .primaryTextTheme
                          .caption
                          .copyWith(color: Colors.black, fontSize: 16),
                      border: const OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(15.0),
                    ),
                  ))
                ],
              )),
              Expanded(
                  child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: 'เรียงลำดับตาม',
                        labelStyle: Theme.of(context)
                            .primaryTextTheme
                            .caption
                            .copyWith(color: Colors.black, fontSize: 16),
                        border: const OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(15.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          isDense: true,
                          // Reduces the dropdowns height by +/- 50%
                          icon: Icon(Icons.keyboard_arrow_down),
                          value: _selectedSort,
                          items: _orderBy.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (selectedItem) => setState(
                            () => _selectedSort = selectedItem,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 11),
              padding: EdgeInsets.all(10),
              width: 350,
              child: Text(
                'รายการเอกสาร (${globals.tempSOHD?.length ?? 0} เอกสาร)',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(0)),
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
        Row(
          children: [
            FutureBuilder(
                future: getSOHDByEmp(globals.employee.empId),
                builder:
                    (BuildContext context, AsyncSnapshot<Object> snapShot) {
                  if (snapShot.hasData) {
                    globals.tempSOHD = snapShot.data;
                    return Expanded(
                      child: dataBody(snapShot.data),
                    );
                  } else {
                    //return Expanded(child: Center(child: CircularProgressIndicator()));
                    return Expanded(
                      //child: dataBody(List<SaleOrderHeader>()),
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                          child: Center(
                              child: CircularProgressIndicator())),
                    );
                  }
                })
          ],
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {});
        },
      ),
    );
  }
}
