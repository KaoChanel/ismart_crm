import 'dart:convert';

// Import the client from the Http Packages
import 'models/companies.dart';
import 'models/customer.dart';
import 'models/product.dart';
import 'models/goods_unit.dart';
import 'models/shipto.dart';
import 'models/saleOrder_header.dart';
import 'models/saleOrder_detail.dart';
import 'models/stock.dart';
import 'package:ismart_crm/src/saleOrder.dart';
import 'globals.dart' as globals;
import 'package:http/http.dart' show Client;

class ApiService {
  // Replace this with your computer's IP Address
  final String baseUrl = "https://smartsalesbis.com/api";
  Client client = Client();

  Future<void> getCompany() async {
    String strUrl = '${globals.publicAddress}/api/company/${globals.company}';
    var response = await client.get(strUrl);
      if (response.statusCode == 200) {
        globals.allCompany = companyFromJson(response.body);
      } else {
        globals.allCompany = null;
      }
  }

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

  Future<double> getPrice(String goodCode, double quantity) async {
    var response = await client.get(
        '${globals.publicAddress}/api/product/${globals.company}/$goodCode/$quantity');
    Map values = json.decode(response.body);

    return double.parse(values['price'].toString());
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

  Future<void> getStock() async {
    String strUrl;

    strUrl = '${globals.publicAddress}/api/stock/${globals.company}';
    var response = await client.get(strUrl).then((value) => {
    if (value.statusCode == 200) {
        globals.allStock = stockFromJson(value.body)
    } else {
      globals.allStock = null
      }
    });
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

  Future<List<SaleOrderHeader>> getSOHD() async {
    final response =
        await client.get("${globals.publicAddress}/api/SaleOrderHeader/${globals.company}");
    var data = saleOrderHeaderFromJson(response.body);

    if (response.statusCode == 200) {
      return data;
    } else {
      return null;
    }
  }

  List<SaleOrderHeader> getSOHDByEmp(int id) {
    final response = client.get('${globals.publicAddress}/api/SaleOrderHeader/GetTempSohdByEmp/${globals.company}/$id')
        .then((value) {
      if (value.statusCode == 200) {
        List<SaleOrderHeader> data = saleOrderHeaderFromJson(value.body);
        return data;
      } else {
        return null;
      }
    });
  }

  Future<List<SaleOrderDetail>> getSODT(int soID) async {
    //'${globals.publicAddress}/api/SaleOrderDetail/GetTempSodtByEmp/${globals.company}/$id'
    String strUrl = '${globals.publicAddress}/api/SaleOrderDetail/${globals.company}/$soID';
    final response = await client.get(strUrl);
      if (response.statusCode == 200) {
        var data = saleOrderDetailFromJson(response.body);
        return data;
      } else {
        return null;
      }
  }

  // Future<String> getDocNo() async {
  //   String strUrl =
  //       '${globals.publicAddress}/api/SaleOrderHeader/GenerateDocNo/${globals.company}';
  //   var response = await client.get(strUrl);
  //   print(response.statusCode);
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     return response.body;
  //   } else {
  //     return '';
  //   }
  // }

  Future<String> getDocNo() async {
    String strUrl =
        '${globals.publicAddress}/api/SaleOrderHeader/GenerateDocNo/${globals.company}';
    var response = await client.get(strUrl);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return '';
    }
  }

  Future<String> getRefNo() async {
    String strUrl =
        '${globals.publicAddress}/api/SaleOrderHeader/GenerateRefNo/${globals.company}';
    var response = await client.get(strUrl);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return '';
    }
  }

  // Create a new sohd
  Future<SaleOrderHeader> addSaleOrderHeader(SaleOrderHeader data) async {
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
      return SaleOrderHeader.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<bool> addSaleOrderDetail(List<SaleOrderDetail> data) async {
    final response = await client.post(
      "$baseUrl/SaleOrderDetail/${globals.company}/",
      headers: {"content-type": "application/json"},
      body: saleOrderDetailToJson(data),
    );

    var str = saleOrderDetailToJson(data);
    print(response.headers);
    print(response.body);
    print('Status Code: ${response.statusCode}');
    print('$str');

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

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

  Future<bool> updateSaleOrderDetail(List<SaleOrderDetail> data) async {
    final response = await client.put(
      "$baseUrl/SaleOrderDetail/${globals.company}",
      headers: {"content-type": "application/json"},
      body: saleOrderDetailToJson(data),
    );
    if (response.statusCode == 204) {
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
