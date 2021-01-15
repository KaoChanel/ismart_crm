import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ismart_crm/models/product.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:ismart_crm/globals.dart' as globals;
import 'package:ismart_crm/models/product_cart.dart';

class ItemProductDetail extends StatefulWidget {
  // const ItemListDetails({ Key key }) : super(key: key);
  ItemProductDetail(
      {@required this.isInTabletLayout,
      @required this.product,
      @required this.price,
        this.editedPrice,
        this.newPrice,
      this.quantity,
      this.total});

  final bool isInTabletLayout;
  final Product product;
  double price;
  final double quantity;
  final double total;
  double editedPrice = 0;
  double newPrice = 0;

  @override
  _ItemProductDetailState createState() => _ItemProductDetailState();
}

class _ItemProductDetailState extends State<ItemProductDetail> {
  final currency = new NumberFormat("#,##0.00", "en_US");
  bool _isFreeProduct = false;
  double _editedPrice = 0;
  double _goodQty;
  double _totalAmount;
  double _discount = 0;
  String _discountType = 'THB';
  double _totalNet = 0;
  String _unitName;
  globals.DiscountType discType;
  FocusNode focusQty = FocusNode();
  FocusNode focusPrice = FocusNode();
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
    globals.newPrice = widget.price;
    _isFreeProduct = globals.editingProductCart?.isFree ?? false;
    super.initState();
    //calculatedPrice(1, 0, widget.editedPrice);
    // txtQty = TextEditingController(text: _goodQty.toString());
    // txtQty.selection = new TextSelection(baseOffset: 0, extentOffset: _goodQty.toString().length,);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusQty.dispose();
    focusPrice.dispose();
    txtGoodName.dispose();
    txtGoodCode.dispose();
    txtQty.dispose();
    txtPrice.dispose();
    txtDiscountType.dispose();
    txtDiscount.dispose();
    txtTotal.dispose();
    txtTotalNet.dispose();
  }

  void setSelectedItem() {
    print('set Selected');
    setState(() {
      if (widget.product?.goodCode == null) {
        _goodQty = 0;
      }
      else {
        if (globals.editingProductCart?.goodCode == widget.product?.goodCode) {
          print('Compare < / Qty = $_goodQty');
          if (_goodQty == null) {
            _goodQty = widget.quantity;
            _discount = globals.editingProductCart?.discount;
            _discountType = globals.editingProductCart?.discountType;
          }
          //_isFreeProduct = globals.editingProductCart.isFree;
        } else if (txtGoodCode.text != widget.product?.goodCode) {
          _goodQty = 1;
          //globals.newPrice = 0;
          globals.newPrice = widget.price;
          print('txtGoodCode.text != widget.product?.goodCode');
        }
      }

      if(widget.product?.mainGoodUnitId != null){
        _unitName = globals.allGoodsUnit.firstWhere((element) => element.goodUnitId == widget.product.mainGoodUnitId).goodUnitName;
      }

      txtGoodCode.text = widget.product?.goodCode;
      txtGoodName.text = widget.product?.goodName1;
      // txtQty.text = currency.format(_goodQty) ?? '0.00';
      // txtPrice.text = currency.format(widget.price) ?? '0.00';
      // txtTotal.text = currency.format(_totalAmount) ?? '0.00';
      // txtDiscount.text = currency.format(_discount) ?? '0.00';
      // txtTotalNet.text = currency.format(_totalNet) ?? '0.00';
    });
  }

  void calculatedPrice(double _quantity, double _discountValue, double _price) {
    setState(() {
      _goodQty = _quantity;
      _discount = _discountValue;
      if (_isFreeProduct == true) {
        _totalAmount = 0;
        _totalNet = 0;
        _discount = 0;
      } else {
        if(_price != null){
          widget.editedPrice = 1;
          globals.newPrice = _price;
          _totalAmount = globals.newPrice * _goodQty;
          txtPrice.text = currency.format(globals.newPrice) ?? 'รอราคา...';
          print('Edited Price / Unit: ' +
              globals.newPrice.toString() +
              ' Total: ' +
              _totalNet.toString());
        }
        else{
          widget.editedPrice = 0;
          globals.newPrice = 0;
          _totalAmount = widget.price * _goodQty;
          txtPrice.text = currency.format(widget.price) ?? 'รอราคา...';
          print('Price / Unit: ' +
              widget.price.toString() +
              ' Total: ' +
              _totalNet.toString());
        }

        if (_discountType == 'PER') {
          //_discount = _total - (_total * _discount / 100);
        } else {
          //_discount = _total - _discount;
        }
      }

      _totalNet = _discountType == 'PER' ? _totalAmount - (_totalAmount * _discount / 100) : _totalAmount - _discount;
      txtQty.text = currency.format(_goodQty) ?? '0';
      // txtPrice.text = currency.format(widget.price) ?? 'รอราคา...';
      txtTotal.text = currency.format(_totalAmount) ?? '0';
      txtDiscount.text = currency.format(_discount) ?? '0';
      txtTotalNet.text = currency.format(_totalNet) ?? '0';

      print('Quantity: ' + _goodQty.toString());
    });
  }

  void addProductToCart() {
    int row = 1;
    
    if (globals.productCart.length > 0) {
      print('Product Cart not equal null. ${globals.productCart.length}');
      row = globals.productCart.last.rowIndex + 1;
    }

    print('Product Cart Length = ${globals.productCart.length}');
    print('Row Index = $row');

    if (globals.editingProductCart != null) {
      print('globals.editingProductCart != null');
      int startIndex = globals.productCart.indexWhere(
          (element) => element.rowIndex == globals.editingProductCart?.rowIndex);
      globals.productCart[startIndex].goodId = widget.product.goodId;
      globals.productCart[startIndex].goodCode = widget.product.goodCode;
      globals.productCart[startIndex].goodName1 = widget.product.goodName1;
      globals.productCart[startIndex].goodQty = _goodQty;
      if(widget.editedPrice > 0){
        globals.productCart[startIndex].goodPrice = globals.newPrice;
      }
      else{
        globals.productCart[startIndex].goodPrice = widget.price;
      }

      globals.productCart[startIndex].discount = _discount;
      globals.productCart[startIndex].discountType = _discountType;
      globals.productCart[startIndex].discountBase = _discountType == 'PER' ? _totalNet * _discount / 100 : _discount;
      globals.productCart[startIndex].goodAmount = _totalNet;
      globals.productCart[startIndex].isFree = _isFreeProduct;
      globals.productCart[startIndex].vatGroupId = widget.product.vatGroupId;
      globals.productCart[startIndex].vatGroupCode = widget.product.vatGroupCode;
      globals.productCart[startIndex].vatType = widget.product.vatType;
      globals.productCart[startIndex].vatRate = widget.product.vatRate;
      globals.editingProductCart = null;
      // List<ProductCart> temp = globals.productCart.where((element) => element.rowIndex == globals.editingProductCart.rowIndex).toList();
      // print('Index: $startIndex');
      // globals.productCart.replaceRange(startIndex, startIndex, temp);
      // print('Updated: ' + globals.editingProductCart.goodName1);
    } else {
      ProductCart order = new ProductCart()
        ..productCartId = UniqueKey().toString()
        ..rowIndex = row
        ..goodId = widget.product.goodId
        ..goodCode = widget.product.goodCode
        ..goodName1 = widget.product.goodName1
        ..mainGoodUnitId = widget.product.mainGoodUnitId
        ..goodQty = _goodQty
        ..goodPrice = widget.price
        ..discount = _discount
        ..discountType = _discountType
        ..discountBase = _discountType == 'PER' ? _totalNet * _discount / 100 : _discount
        ..goodAmount = _totalNet
        ..isFree = _isFreeProduct
        ..vatGroupId = widget.product.vatGroupId
        ..vatGroupCode = widget.product.vatGroupCode
        ..vatType = widget.product.vatType
        ..vatRate = widget.product.vatRate;

      if(widget.editedPrice > 0){
        order.goodPrice = globals.newPrice;
      }

      print('Add: ' + order.goodName1);
      globals.productCart.add(order);
    }

    Navigator.pop(context);
  }

  void _showStockDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return alert dialog object
        return AlertDialog(
          title: new Text('สต๊อคสินค้า'),
          content: Container(
            height: 150.0,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget setDiscountType() {
    print('set Discount type');
    if (_discountType == 'THB') {
      return Text('THB', style: TextStyle(fontSize: 18));
    } else {
      return Text('%', style: TextStyle(fontSize: 18));
    }
  }

  void showDiscountDialog(context){
    showDialog(
        context: context,
      builder: (BuildContext context){
       return AlertDialog(
            elevation: 0,
            title: new Text('ประเภทส่วนลด'),
            content: Container(
                width: 250,
                height: 180,
                child: ListView(children: [
                  ListTile(
                      onTap: () {
                        //discountType = globals.DiscountType.THB;
                        _discountType = 'THB';
                        Navigator.pop(context);
                        setState(() {});
                      },
                      selected: _discountType == 'THB',
                      selectedTileColor: Colors.black12,
                      title: Text('THB')),
                  ListTile(
                    onTap: () {
                      //discountType = globals.DiscountType.PER;
                      //globals.discountType = globals.DiscountType.PER;
                      _discountType = 'PER';
                      Navigator.pop(context);
                      setState(() {});
                    },
                    selected: _discountType == 'PER',
                    selectedTileColor: Colors.black12,
                    title: Text('%'),
                  )
                ])
            )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    setSelectedItem();

    if(globals.newPrice == 0){
      globals.newPrice = widget.price;
    }

      if(globals.newPrice != widget.price){
        calculatedPrice(_goodQty, _discount, globals.newPrice);
      }
    else{
        print('globals.newPrice == widget.price');
      calculatedPrice(_goodQty, _discount, null);
    }


    //calculatedPrice(_goodQty, _discount, null);
    //calculatedPrice(_goodQty, _discount, widget.editedPrice);

    print('Qty: ' + _goodQty.toString());
    print('Edited: ' + _editedPrice.toString());
    print('Widget newPrice: ' + globals.newPrice.toString());
    print('Widget Price: ' + widget.price.toString());

    final TextTheme textTheme = Theme.of(context).textTheme;
    final Widget content = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                  width: 130,
                  child: Text('ชื่อสินค้า',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18))),
              Flexible(
                  flex: 4,
                  child: ListTile(
                    title: TextFormField(
                      readOnly: true,
                      //enabled: false,
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
              Flexible(
                child: ElevatedButton(
                    onPressed: () {
                      _showStockDialog(context);
                    },
                    child: Text(
                      'เช็คสต๊อค',
                      style: TextStyle(fontSize: 18),
                    ),
                    style:
                        ElevatedButton.styleFrom(padding: EdgeInsets.all(12))),
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                  width: 130,
                  child: Text('รหัสสินค้า',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18))),
              Flexible(
                flex: 4,
                child: ListTile(
                  //
                  title: TextFormField(
                    readOnly: true,
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
                  child: CheckboxListTile(
                    value: _isFreeProduct,
                    onChanged: (bool value) {
                      setState(() {
                        _isFreeProduct = value;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text('สินค้าแถม ?'),
                  ))
            ],
          ),

          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                  width: 130,
                  child: Text('จำนวน',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18))),
              Flexible(
                flex: 2,
                child: ListTile(
                  title: TextFormField(
                    textAlign: TextAlign.right,
                    controller: txtQty,
                    focusNode: focusQty,
                    keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                    onTap: () {
                      txtQty.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: txtQty.value.text.length);
                    },
                    // onChanged: (value) {
                    //   //txtQty..text = value..selection = TextSelection.collapsed(offset: 0);
                    //   if(double.tryParse(value) != null){
                    //     calculatedPrice(double.parse(value));
                    //   }
                    // },
                    onEditingComplete: () {
                      setState(() {
                        calculatedPrice(double.parse(txtQty.text.replaceAll(',', '')), double.parse(txtDiscount.text.replaceAll(',', '')), globals.newPrice);
                        FocusScope.of(context).unfocus();
                      });
                    },
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
              Spacer()
            ],
          ),

          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                  width: 130,
                  child: Text('ราคา / หน่วย',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18))),
              Flexible(
                flex: 2,
                child: ListTile(
                  title: TextFormField(
                    controller: txtPrice,
                    focusNode: focusPrice,
                    keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                    onTap: () {
                      txtPrice.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: txtPrice.value.text.length);
                    },
                    onEditingComplete: () {
                        calculatedPrice(double.parse(txtQty.text.replaceAll(',', '')), double.parse(txtDiscount.text.replaceAll(',', '')), double.parse(txtPrice.text.replaceAll(',', '')));
                        FocusScope.of(context).unfocus();
                    },
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      labelText: "ราคา / หน่วย",
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  _unitName ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
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
                  width: 130,
                  child: Text('ราคา',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18))),
              Flexible(
                flex: 2,
                child: ListTile(
                  //
                  title: TextFormField(
                    readOnly: true,
                    controller: txtTotal,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      labelText: "ราคา",
                    ),
                  ),
                ),
              ),
              Spacer()
            ],
          ),

          // SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   children: [
          //     SizedBox(
          //         width: 130,
          //         child: Text('รวมราคา',
          //             textAlign: TextAlign.right,
          //             style: TextStyle(fontSize: 18))),
          //     Flexible(
          //       flex: 4,
          //       child: ListTile(
          //         //
          //         title: TextFormField(
          //           readOnly: true,
          //           controller: txtTotal,
          //           textAlign: TextAlign.right,
          //           decoration: InputDecoration(
          //             border: OutlineInputBorder(),
          //             contentPadding:
          //                 EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          //             labelText: "รวมราคา",
          //           ),
          //         ),
          //       ),
          //     ),
          //     Flexible(
          //       child: ElevatedButton(
          //           onPressed: () {},
          //           child: Text(
          //             'บาท',
          //             style: TextStyle(fontSize: 18),
          //           ),
          //           style:
          //               ElevatedButton.styleFrom(padding: EdgeInsets.all(12))),
          //     ),
          //   ],
          // ),

          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                  width: 130,
                  child: Text('ส่วนลด',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18))),
              Flexible(
                flex: 2,
                child: ListTile(
                  //
                  title: TextFormField(
                    controller: txtDiscount,
                    textAlign: TextAlign.right,
                    onTap: (){
                      txtDiscount.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: txtDiscount.value.text.length);
                    },
                    onEditingComplete: () {
                      setState(() {
                        calculatedPrice(double.parse(txtQty.text), double.parse(txtDiscount.text), null);
                        FocusScope.of(context).unfocus();
                      });
                    },
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      labelText: "ส่วนลด",
                    ),
                    // onChanged: (value) {
                    //   setState(() {
                    //     _discount = double.parse(value);
                    //     calculatedPrice(_goodQty);
                    //   });
                    // },
                  ),
                ),
              ),
              Flexible(
                child: ElevatedButton(
                    onPressed: () {
                      showDiscountDialog(context);
                    },
                    child: setDiscountType(),
                    style:
                        ElevatedButton.styleFrom(padding: EdgeInsets.all(12))),
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                  width: 130,
                  child: Text('รวมสุทธิ',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18))),
              Flexible(
                flex: 2,
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
              Flexible(
                child: Text(
                  'บาท',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
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
                  width: 130,
                  child: Text('Promotion   Code',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18))),
              Flexible(
                flex: 2,
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
              Flexible(
                flex: 1,
                child: ElevatedButton(
                    onPressed: () {},
                    //icon: Icon(Icons.),
                    child: Text(
                      'Coupon',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(12),
                        primary: Colors.deepOrangeAccent)),
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                  width: 130,
                  child: Text('หมายเหตุ     สินค้า',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18))),
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

          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        addProductToCart();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: EdgeInsets.only(top: 15, bottom: 15)),
                      label: Text(
                        globals.editingProductCart == null ? 'เพิ่มรายการสินค้า' : 'บันทึกการแก้ไข',
                        style: TextStyle(fontSize: 22),
                      ),
                      icon: Icon(
                        globals.editingProductCart == null ? Icons.add_circle_outline : Icons.edit,
                        size: 30,
                      )
                  ),
                ),
              ),
            ],
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
      ),
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
