import 'package:ismart_crm/models/item.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ItemCustomerDetail extends StatefulWidget {
  // const ItemListDetails({ Key key }) : super(key: key);
  const ItemCustomerDetail({
    @required this.isInTabletLayout,
    @required this.item,
  });

  final bool isInTabletLayout;
  final Item item;

  @override
  _ItemCustomerDetailState createState() => _ItemCustomerDetailState();
}
class _ItemCustomerDetailState extends State<ItemCustomerDetail> {

  bool _isFreeProduct = false;
  @override
  Widget build(BuildContext context) {
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
                    child: Text('ชื่อลูกค้า',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18))
                ),
                Flexible(
                    child: ListTile(
                      title: TextFormField(
                        initialValue: '',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "ชื่อลูกค้า",
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
                    child: Text('รหัสลูกค้า',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18))
                ),
                Flexible(
                  flex: 4,
                  child: ListTile(
                    //
                    title: TextFormField(
                      initialValue: '',
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        labelText: "รหัสลูกค้า",
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
                    child: Text('จำนวน',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 18))
                ),
                Flexible(
                  child: ListTile(
                    //
                    title: TextFormField(
                      initialValue: '',
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
                      initialValue: '',
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
                      initialValue: '',
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
                      initialValue: '',
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
                      initialValue: '',
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
                      initialValue: '',
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
                  width: 115,
                ),

                Expanded(
                    flex: 6,
                    child: ElevatedButton.icon(
                        onPressed: (){

                        },
                        style: ElevatedButton.styleFrom(primary: Colors.green, padding: EdgeInsets.only(top:15,bottom: 15)),
                        label: Text('เลือกลูกค้ารายนี้', style: TextStyle(fontSize: 22),),
                        icon: Icon(Icons.check, size: 30,)
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
        title: Center(child: Text(widget.item.title)),
      ),
      body: ListView(children: [
        Center(child: content),
      ]),
    );
  }
}
