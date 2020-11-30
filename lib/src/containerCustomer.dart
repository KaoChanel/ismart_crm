import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismart_crm/models/item.dart';

import 'item_customer.dart';
import 'item_customer_detail.dart';

// Widget _buildMobileLayout() {
//   return ItemListing(
//     // Since we're on mobile, just push a new route for the
//     // item details.
//     itemSelectedCallback: (item) {
//       Navigator.push(/* ... */);
//     },
//   );
// }

class ContainerCustomer extends StatefulWidget {
  const ContainerCustomer({ Key key }) : super(key: key);

  @override
  _ContainerCustomerState createState() => _ContainerCustomerState();
}

class _ContainerCustomerState extends State<ContainerCustomer> {
  static const int kTabletBreakpoint = 600;
  Item _selectedItem;
  Widget _buildTabletLayout() {
    // For tablets, return a layout that has item listing on the left
    // and item details on the right.
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: ItemCustomer(
            // Instead of pushing a new route here, we update
            // the currently selected item, which is a part of
            // our state now.
            itemSelectedCallback: (item) {
              setState(() {
                _selectedItem = item;
              });
            },
          ),
        ),
        Flexible(
          flex: 3,
          child: ItemCustomerDetail(
            // The item details just blindly accepts whichever
            // item we throw in its way, just like before.
            item: _selectedItem,
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
    } else {
      content = _buildTabletLayout();
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('เลือกลูกค้าของคุณ ', style: GoogleFonts.sarabun(fontSize: 20),)),
      ),
      body: content,
    );
  }
}