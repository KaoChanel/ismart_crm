import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismart_crm/models/item.dart';

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
  Item _selectedItem;
  Widget _buildTabletLayout() {
    // For tablets, return a layout that has item listing on the left
    // and item details on the right.
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: ItemList(
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
          flex: 4,
          child: ItemListDetails(
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
      content = _buildTabletLayout();
    } else {
      content = _buildTabletLayout();
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('สั่งสินค้ารายการที่ ', style: GoogleFonts.sarabun(fontSize: 20),)),
      ),
      body: content,
    );
  }
}