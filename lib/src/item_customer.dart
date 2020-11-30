import 'package:flutter/material.dart';
import 'package:ismart_crm/models/item.dart';
import 'package:ismart_crm/models/customer.dart';
import 'package:http/http.dart' as http;

class ItemCustomer extends StatefulWidget {
  ItemCustomer({
    @required this.itemSelectedCallback,
    this.selectedItem,
  });

  final ValueChanged<Item> itemSelectedCallback;
  final Item selectedItem;

  @override
  _ItemCustomerState createState() => _ItemCustomerState();
}

class _ItemCustomerState extends State<ItemCustomer> {
  Customer _customer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> GetCustomers(String _EmpId){
    String strUrl = '';
    var response = http.get(strUrl);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: items.map((item) {
        return ListTile(
          title: Text(item.title),
          onTap: () => widget.itemSelectedCallback(item),
          selected: widget.selectedItem == item,
        );
      }).toList(),
    );
  }
}