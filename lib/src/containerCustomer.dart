import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismart_crm/models/item.dart';
import 'package:ismart_crm/models/customer.dart';
import 'item_customer.dart';
import 'item_customer_detail.dart';
import 'package:ismart_crm/globals.dart' as globals;
import 'package:http/http.dart' as http;

// Widget _buildMobileLayout() {
//   return ItemListing(
//     // Since we're on mobile, just push a new route for the
//     // item details.
//     itemSelectedCallback: (item) {
//       Navigator.push(/* ... */);
//     },
//   );
// }

Widget SearchAreaWidgetOld() {
  return Container(
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        new ElevatedButton(
          // textColor: Colors.blueGrey,
          // color: Colors.white,
          child: new Text('SELECT ORANGES'),
          onPressed: () {},
        ),
        new FlatButton(
          textColor: Colors.blueGrey,
          color: Colors.white,
          child: new Text('SELECT TOMATOES'),
          onPressed: () {},
        ),
      ],
    ),
  );
}

class ContainerCustomer extends StatefulWidget {
  const ContainerCustomer({Key key}) : super(key: key);

  @override
  _ContainerCustomerState createState() => _ContainerCustomerState();
}

class _ContainerCustomerState extends State<ContainerCustomer> {
  static const int kTabletBreakpoint = 400;
  Customer _selectedItem = globals.customer;
  List<Customer> allCustomer = globals.allCustomer;
  TextEditingController txtKeyword = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    if (shortestSide < kTabletBreakpoint) {
      //content = _buildMobileLayout();
    } else {
      content = _buildTabletLayout();
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Center(
            child: Text(
          'เลือกลูกค้าของคุณ ',
          style: GoogleFonts.sarabun(fontSize: 20),
        )),
      ),
      body: content,
    );
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
                              hintText: 'ชื่อลูกค้า, รหัสลูกค้า, ที่อยู่',
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
                                  allCustomer = globals.allCustomer
                                      .where((x) =>
                                          x.custName
                                              .toLowerCase()
                                              .contains(query) ||
                                          x.custCode
                                              .toLowerCase()
                                              .contains(query) ||
                                          x.custAddr1
                                              .toLowerCase()
                                              .contains(query))
                                      .toList();
                                });
                              },
                              //style: ButtonStyle(padding:),
                              icon: Icon(Icons.search),
                              label: Text(
                                'ค้นหาลูกค้า',
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
                  child: ItemCustomer(
                    // Instead of pushing a new route here, we update
                    // the currently selected item, which is a part of
                    // our state now.
                    allCustomer: allCustomer,
                    selectedItem: _selectedItem,
                    itemSelectedCallback: (item) {
                      setState(() {
                        _selectedItem = item;
                        // globals.customer = item;
                        print('Item selected: ${item.custName}');
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
          child: ItemCustomerDetail(
            // The item details just blindly accepts whichever
            // item we throw in its way, just like before.
            customer: _selectedItem,
            isInTabletLayout: true,
          ),
        ),
        Flexible(
          flex: 1,
          child: searchAreaWidget(),
        ),
      ],
    );
  }

  Widget searchAreaWidget() {
    return ListView(children: [
      Column(children: [
        SizedBox(
          height: 15,
        ),
        ElevatedButton.icon(
            onPressed: () {
              setState(() {
                globals.customer = _selectedItem;
                globals.selectedShipto = globals.allShipto.firstWhere((element) => element.custId == globals.customer?.custId);
                print(globals.selectedShipto.shiptoAddr1);
              });

              Navigator.pop(context);
            },
            icon: Icon(Icons.check_circle_sharp),
            label: Text(
              'เลือกลูกค้า',
              style: TextStyle(fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(12), primary: Colors.green)),
      ]),
      SizedBox(
        height: 83,
      ),
      ElevatedButton(
          onPressed: () {},
          //icon: Icon(Icons.),
          child: Text(
            'Coupon',
            style: TextStyle(fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(12), primary: Colors.deepOrangeAccent)),
    ]);
  }
}
