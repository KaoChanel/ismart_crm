import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ismart_crm/models/product.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:ismart_crm/globals.dart' as globals;

class ItemProductDetail extends StatefulWidget {
  // const ItemListDetails({ Key key }) : super(key: key);
  const ItemProductDetail({
    @required this.isInTabletLayout,
    @required this.product,
    this.goodQty,
    this.goodPrice,
    this.total
  });

  final bool isInTabletLayout;
  final Product product;
  final goodQty;
  final goodPrice;
  final total;

  @override
  _ItemProductDetailState createState() => _ItemProductDetailState();
}
class _ItemProductDetailState extends State<ItemProductDetail> {
  final currency = new NumberFormat("#,##0.00", "en_US");
  bool _isFreeProduct = false;
  double _goodQty = 0;
  double _discount;
  String _discountType;
  double _goodPrice = 0;
  double _total = 0;
  TextEditingController txtGoodName = TextEditingController();
  TextEditingController txtGoodCode = TextEditingController();
  TextEditingController txtQty = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  TextEditingController txtDiscountType = TextEditingController();
  TextEditingController txtDiscount = TextEditingController();
  TextEditingController txtTotal = TextEditingController();
  TextEditingController txtTotalNet = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrice();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txtGoodName.dispose();
    txtGoodCode.dispose();
    txtQty.dispose();
    txtPrice.dispose();
    txtDiscountType.dispose();
    txtDiscount.dispose();
    txtTotal.dispose();
  }

  Future<void> getPrice() async {
    var response = await http.get('${globals.publicAddress}/api/product/${widget.product?.goodCode}/$_goodQty');
    Map values = json.decode(response.body);
    //print('Price / Unit: '+values['price']+'/n Total: '+values['total']);
    setState(() {
      _goodPrice = double.parse(values['price'].toString());
      txtPrice.text = _goodPrice.toStringAsFixed(2) ?? '0';
      print('Price / Unit: '+_goodPrice.toString()+'/n Total: '+values['total'].toString());
    });
    //return values['price'];
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      //getPrice();
      txtGoodCode.text = widget.product?.goodCode;
      txtGoodName.text = widget.product?.goodName1;
      txtQty.text = currency.format(widget.goodQty) ?? '1';
      txtPrice.text = currency.format(widget.goodPrice) ?? '0';
      txtTotal.text = currency.format(widget.total) ?? '0';
      // txtDiscountType.text = _discountType ?? '0';
      // txtDiscount.text = _discount.toStringAsFixed(1) ?? '0';
      // txtTotalNet.text = _total.toStringAsFixed(1) ?? '0';
    });
    final TextTheme textTheme = Theme
        .of(context)
        .textTheme;
    final Widget content = ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text('ชื่อสินค้า',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18))
                ),
                Flexible(
                    child: ListTile(
                      title: TextFormField(
                        controller: txtGoodName,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "ชื่อสินค้า",
                        ),
                      ),
                    )),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'เช็คสต๊อค',
                      style: TextStyle(fontSize: 18),
                    ),
                    style:
                    ElevatedButton.styleFrom(padding: EdgeInsets.all(12))),
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text('รหัสสินค้า',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18))
                ),
                Flexible(
                  flex: 4,
                  child: ListTile(
                    //
                    title: TextFormField(
                      controller: txtGoodCode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        labelText: "รหัสสินค้า",
                      ),
                    ),
                  ),
                ),

                Flexible(
                  flex: 2,
                  child:
                CheckboxListTile(
                  value: _isFreeProduct,
                  onChanged: (bool value) {
                    setState(() {
                      _isFreeProduct = value;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text('สินค้าแถม ?'),
                )
                )
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text('จำนวน',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18))
                ),
                Flexible(
                  child: ListTile(
                    //
                    title: TextFormField(
                      controller: txtQty,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        //floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "จำนวน",
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text('ราคา / หน่วย',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18))
                ),
                Flexible(
                  flex: 6,
                  child: ListTile(
                    title: TextFormField(
                      controller: txtPrice,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        labelText: "ราคา / หน่วย",
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text('ราคา',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18))
                ),
                Flexible(
                  flex: 6,
                  child: ListTile(
                    //
                    title: TextFormField(
                      controller: txtTotal,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        labelText: "ราคา",
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text('รวมราคา',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18))
                ),
                Flexible(
                  flex: 6,
                  child: ListTile(
                    //
                    title: TextFormField(
                      controller: txtTotal,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        labelText: "รวมราคา",
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'THB',
                      style: TextStyle(fontSize: 18),
                    ),
                    style:
                    ElevatedButton.styleFrom(padding: EdgeInsets.all(12))),
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text('ส่วนลด',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18))
                ),
                Flexible(
                  flex: 6,
                  child: ListTile(
                    //
                    title: TextFormField(
                      controller: txtDiscount,
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        labelText: "ส่วนลด",
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      '%',
                      style: TextStyle(fontSize: 18),
                    ),
                    style:
                    ElevatedButton.styleFrom(padding: EdgeInsets.all(12))),
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text('รวมสุทธิ',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18))
                ),
                Flexible(
                  flex: 6,
                  child: ListTile(
                    title: TextFormField(
                      readOnly: true,
                      controller: txtTotalNet,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        labelText: "รวมสุทธิ",
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text('Promotion Code',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18))
                ),
                Flexible(
                  flex: 6,
                  child: ListTile(
                    title: TextFormField(
                      initialValue: '',
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        labelText: "Promotion Code",
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {

                    },
                    //icon: Icon(Icons.),
                    child: Text(
                      'Coupon',
                      style: TextStyle(fontSize: 18),
                    ),
                    style:
                    ElevatedButton.styleFrom(padding: EdgeInsets.all(12), primary: Colors.deepOrangeAccent)),
              ],
            ),

            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                    width: 100,
                    child: Text('หมายเหตุสินค้า',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18))
                ),
                Flexible(
                  flex: 6,
                  child: ListTile(
                    title: TextFormField(
                      initialValue: '',
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        labelText: "หมายเหตุสินค้า",
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),

                Expanded(
                  flex: 6,
                  child: ElevatedButton.icon(
                    onPressed: (){

                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green, padding: EdgeInsets.only(top:15,bottom: 15)),
                    label: Text('เพิ่มรายการสั่ง', style: TextStyle(fontSize: 22),),
                    icon: Icon(Icons.add_circle_outline, size: 30,)
                  )
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            // Text(
            //   item?.title ?? 'No item selected!',
            //   style: textTheme.headline,
            // ),
            // Text(
            //   item?.subtitle ?? 'Please select one on the left.',
            //   style: textTheme.subhead,
            // ),
          ],
        )
      ],
    );

    if (widget.isInTabletLayout) {
      return Center(child: content);
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.product.goodName2)),
      ),
      body: ListView(children: [
        Center(child: content),
      ]),
    );
  }
}
