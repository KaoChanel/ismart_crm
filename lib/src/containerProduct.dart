import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismart_crm/models/product.dart';
import 'package:ismart_crm/globals.dart' as globals;
import 'package:http/http.dart' as http;

import 'item_product.dart';
import 'item_product_detail.dart';

// Widget _buildMobileLayout() {
//   return ItemListing(
//     // Since we're on mobile, just push a new route for the
//     // item details.
//     itemSelectedCallback: (item) {
//       Navigator.push(/* ... */);
//     },
//   );
// }

class MasterDetailContainer extends StatefulWidget {
  const MasterDetailContainer({ Key key }) : super(key: key);

  @override
  _MasterDetailContainerState createState() => _MasterDetailContainerState();
}

class _MasterDetailContainerState extends State<MasterDetailContainer> {
  static const int kTabletBreakpoint = 400;
  double _goodQty = 1;
  double _discount;
  String _discountType;
  double _goodPrice = 0;
  double _total = 0;
  Product _selectedItem = globals.selectedProduct;
  List<Product> allProduct = globals.allProduct;
  TextEditingController txtKeyword = new TextEditingController();

  Future<void> getPrice() async {
    var response = await http.get('${globals.publicAddress}/api/product/${_selectedItem?.goodCode}/$_goodQty');
    Map values = json.decode(response.body);

    setState(() {
      _goodPrice = double.parse(values['price'].toString());
      _total = double.parse(values['total'].toString());
      print('Price / Unit: '+_goodPrice.toString()+' Total: '+values['total'].toString());
    });
  }

  Widget _buildTabletLayout() {
    // For tablets, return a layout that has item listing on the left
    // and item details on the right.
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 30,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
            child: Stack(children: [
              Column(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [

                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: txtKeyword,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontStyle: FontStyle.italic),
                              hintText: 'ชื่อลูกค้า, รหัสลูกค้า่',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              String query = txtKeyword.text;
                              setState(() {
                                allProduct = globals.allProduct
                                    .where((x) =>
                                x.goodName1
                                    .toLowerCase()
                                    .contains(query) ||
                                    x.goodCode
                                        .toLowerCase()
                                        .contains(query))
                                    .toList();
                              });
                            },
                            //style: ButtonStyle(padding:),
                            icon: Icon(Icons.search),
                            label: Text(
                              'ค้นหาสินค้า',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(flex: 2, child: SizedBox(),),
                      ],
                    ),
                    color: Colors.transparent,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: ItemProduct(
                    // Instead of pushing a new route here, we update
                    // the currently selected item, which is a part of
                    // our state now.
                    allProduct: allProduct,
                    selectedItem: _selectedItem,
                    itemSelectedCallback: (item) {
                      setState(() {
                        _selectedItem = item;
                        getPrice();
                        // globals.customer = item;
                        print('Item selected: ${item.goodName1}');
                      });
                    },
                  ),
                ),
              ]),
            ]),
          ),
        ),
        Flexible(
          flex: 4,
          child: ItemProductDetail(
            // The item details just blindly accepts whichever
            // item we throw in its way, just like before.
            product: _selectedItem,
            goodQty: _goodQty,
            goodPrice: _goodPrice,
            total: _total,
            isInTabletLayout: true,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    if (shortestSide < kTabletBreakpoint) {
      //content = _buildMobileLayout();
      content = _buildTabletLayout();
    } else {
      content = _buildTabletLayout();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(child: Text('สั่งสินค้ารายการที่ ', style: GoogleFonts.sarabun(fontSize: 20),)),
      ),
      body: content,
    );
  }
}