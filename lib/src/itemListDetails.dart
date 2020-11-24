import 'package:ismart_crm/models/item.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ItemListDetails extends StatelessWidget {
  ItemListDetails({
    @required this.isInTabletLayout,
    @required this.item,
  });

  final bool isInTabletLayout;
  final Item item;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Widget content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.grey,
          child: Row(
            children: [
              SizedBox(height: 20,),
              Flexible(
                flex: 6,
                child: ListTile(
                  //
                  title: TextFormField(
                    initialValue: '',
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "รหัสสินค้า",
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        // Text(
        //   item?.title ?? 'No item selected!',
        //   style: textTheme.headline,
        // ),
        // Text(
        //   item?.subtitle ?? 'Please select one on the left.',
        //   style: textTheme.subhead,
        // ),
      ],
    );

    if (isInTabletLayout) {
      return Center(child: content);
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(item.title)),
      ),
      body: ListView(
          children: [
            Center(child: content),
          ]
      ),
    );
  }
}
