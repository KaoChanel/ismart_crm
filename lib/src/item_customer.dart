import 'package:flutter/material.dart';
import 'package:ismart_crm/models/customer.dart';
import 'package:http/http.dart' as http;
import 'package:ismart_crm/globals.dart' as globals;

class ItemCustomer extends StatefulWidget {
  ItemCustomer({
    @required this.itemSelectedCallback,
    this.selectedItem,
    this.allCustomer
  });

  final ValueChanged<Customer> itemSelectedCallback;
  final Customer selectedItem;
  List<Customer> allCustomer;

  @override
  _ItemCustomerState createState() => _ItemCustomerState();
}

class _ItemCustomerState extends State<ItemCustomer> {
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getScrollAtElement(widget.allCustomer?.indexWhere((x) => x.custCode == widget.selectedItem?.custCode));
    print(widget.allCustomer?.indexWhere((x) => x.custCode == widget.selectedItem?.custCode));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scroll.dispose();
  }

  void getScrollAtElement(int index){
    setState(() {
      //widget.allCustomer = globals.allCustomer;
      /// Wait till Build finish.
      WidgetsBinding.instance.addPostFrameCallback((_){
        //write or call your logic
        //code will run when widget rendering complete
        if(_scroll.hasClients) {
          _scroll.animateTo((72.0 * index),
              // 100 is the height of container and index of 6th element is 5
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        }
      });
    });
  }

  Widget searchAreaWidget(){
    return Flexible(
      child: new Container(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        child: Row(children:[
          new ElevatedButton(
            // textColor: Colors.blueGrey,
            // color: Colors.white,
            child: new Text('SELECT ORANGES'),
            onPressed: (){},
          ),
          new FlatButton(
            textColor: Colors.blueGrey,
            color: Colors.white,
            child: new Text('SELECT TOMATOES'),
            onPressed: (){},
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
        Scrollbar(
          controller: _scroll,
          isAlwaysShown: false,
          thickness: 3.0,
          radius: Radius.circular(20.0),
          child: ListView(
            controller: _scroll,
            children: widget.allCustomer?.map((item) {
              return Container(
                  decoration:
                  BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 0.5, color: Colors.black26)
                      )
                  ),
                child: ListTile(
                    title: Text(item?.custName),
                    subtitle: Text(item?.custCode),
                    onTap: () => widget.itemSelectedCallback(item),
                    selected: widget.selectedItem?.custCode == item?.custCode,
                    selectedTileColor: Colors.grey[200],
                    hoverColor: Colors.grey,
                  ),
              );
            })?.toList() ?? [],
    ),
        );
  }
}
