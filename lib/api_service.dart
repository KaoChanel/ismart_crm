import 'dart:convert';

// Import the client from the Http Packages
import 'models/customer.dart';
import 'models/product.dart';
import 'models/goods_unit.dart';
import 'models/shipto.dart';
import 'models/saleOrder_header.dart';
import 'models/saleOrder_detail.dart';
import 'package:ismart_crm/src/saleOrder.dart';
import 'globals.dart' as globals;
import 'package:http/http.dart' show Client;

class ApiService {
  // Replace this with your computer's IP Address
  final String baseUrl = "http://103.225.27.252/api";
  Client client = Client();

// Get All sohd
  Future<void> getCustomer() async {
    String strUrl =
        '${globals.publicAddress}/api/customers/${globals.company}/${globals.employee.empId}';
    var response = await client.get(strUrl);

    if (response.statusCode == 200) {
      globals.allCustomer = customerFromJson(response.body);
    } else {
      globals.allCustomer = null;
    }
  }

  Future<void> getProduct() async {
    String strUrl;

    strUrl = '${globals.publicAddress}/api/product/${globals.company}';
    var response = await client.get(strUrl);

    if (response.statusCode == 200) {
      globals.allProduct = productFromJson(response.body);
    } else {
      globals.allProduct = null;
    }
  }

  Future<void> getUnit() async {
    String strUrl;

    strUrl = '${globals.publicAddress}/api/goodsunit/${globals.company}';
    var response = await client.get(strUrl);

    if (response.statusCode == 200) {
      globals.allGoodsUnit = goodsUnitFromJson(response.body);
    } else {
      globals.allGoodsUnit = null;
    }
  }

  Future<void> getShipto() async {
    String strUrl;
    strUrl = '${globals.publicAddress}/api/shipto/${globals.company}';
    final response = await client.get(strUrl);

    if (response.statusCode == 200) {
      globals.allShipto = shiptoFromJson(response.body);
    } else {
      globals.allShipto = null;
    }
  }

  Future<List<SaleOrderHeader>> getSaleOrderHeader() async {
    final response =
        await client.get("$baseUrl/SaleOrderHeader/${globals.company}");
    var data = saleOrderHeaderFromJson(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      return null;
    }
  }
  Future<List<SaleOrderHeader>> getSaleOrderHeaderById(int id) async {
    final response =
    await client.get("$baseUrl/SaleOrderHeader/${globals.company}/$id");
    var data = saleOrderHeaderFromJson(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      return null;
    }
  }

// Update an existing sohd
  Future<bool> updateSaleOrderHeader(SaleOrderHeader data) async {
    final response = await client.put(
      "$baseUrl/SaleOrderHeader/${globals.company}/${data.soid}",
      headers: {"content-type": "application/json"},
      body: json.encode(data.toJson()),
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

// Create a new sohd
  Future<bool> addSaleOrderHeader(SaleOrderHeader data) async {
    final response = await client.post(
      "$baseUrl/SaleOrderHeader/${globals.company}/",
      headers: {"content-type": "application/json"},
      body: json.encode(data.toJson()),
    );

    var str = json.encode(data.toJson());
    print(response.headers);
    print(response.body);
    print(json.encode(data.toJson()));
    print('Status Code: ${response.statusCode}');

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addSaleOrderDetail(List<SaleOrderDetail> data) async {
    final response = await client.post(
      "$baseUrl/SaleOrderDetail/${globals.company}/",
      headers: {"content-type": "application/json"},
      body: saleOrderDetailToJson(data),
    );

    var str = saleOrderDetailToJson(data);
    print(str);
    print(response.headers);
    print(response.body);
    print(json.encode(saleOrderDetailToJson(data)));
    print('Status Code: ${response.statusCode}');

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

// Delete a sohd
  Future<bool> deleteSaleOrderHeader(int Id) async {
    final response = await client.delete(
      "$baseUrl/SaleOrderHeader/$Id",
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }

// Get list of all Todo Statuses
  Future<List<String>> getStatuses() async {
    final response = await client.get("$baseUrl/Config");
    if (response.statusCode == 200) {
      var data = (jsonDecode(response.body) as List<dynamic>).cast<String>();
      return data;
    } else {
      return null;
    }
  }
}
