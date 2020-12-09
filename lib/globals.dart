library app.globals;
import 'models/employee.dart';
import 'package:ismart_crm/models/customer.dart';
import 'package:ismart_crm/models/product.dart';
import 'package:ismart_crm/models/product_cart.dart';
import 'package:ismart_crm/models/shipto.dart';

String publicAddress = 'http://103.225.27.252';
Employee employee;
Customer customer;
List<Customer> allCustomer;
Shipto selectedShipto;
List<Shipto> allShipto;
Product selectedProduct;
List<Product> allProduct;
ProductCart editingProductCart;
List<ProductCart> productCart = new List<ProductCart>();


