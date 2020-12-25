library app.globals;
import 'models/employee.dart';
import 'package:ismart_crm/models/customer.dart';
import 'package:ismart_crm/models/product.dart';
import 'package:ismart_crm/models/product_cart.dart';
import 'package:ismart_crm/models/shipto.dart';
import 'models/goods_unit.dart';

enum DiscountType{ THB, PER }

String publicAddress = 'http://103.225.27.252';
String company;
bool enableEditPrice = false;
DiscountType discountType = DiscountType.THB;
double discountBill = 0;
Employee employee;
Customer customer;
List<Customer> allCustomer;
Shipto selectedShipto;
List<Shipto> allShipto;
Product selectedProduct;
List<Product> allProduct;
ProductCart editingProductCart;
List<ProductCart> productCart = new List<ProductCart>();
List<GoodsUnit> allGoodsUnit = new List<GoodsUnit>();

void clearOrder(){
  productCart = new List<ProductCart>();
  editingProductCart = null;
  selectedProduct = null;
  discountBill = 0;
}


