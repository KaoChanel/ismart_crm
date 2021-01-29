library app.globals;
import 'models/companies.dart';
import 'models/employee.dart';
import 'models/customer.dart';
import 'models/product.dart';
import 'models/product_cart.dart';
import 'models/stock.dart';
import 'models/shipto.dart';
import 'models/goods_unit.dart';
import 'models/saleOrder_header.dart';
import 'models/saleOrder_detail.dart';

enum DiscountType{ THB, PER }

String publicAddress = 'https://smartsalesbis.com';
String company;
List<Company> allCompany;
bool enableEditPrice = false;
DiscountType discountType = DiscountType.THB;
double discountBill = 0;
Employee employee;
Customer customer;
Customer selectedOrderCustomer;
List<Customer> allCustomer;
Shipto selectedShipto;
List<Shipto> allShipto;
Product selectedProduct;
List<Product> allProduct;
Stock selectedStock;
List<Stock> groupStock;
List<Stock> allStock;
ProductCart editingProductCart;
List<ProductCart> productCart = new List<ProductCart>();
List<GoodsUnit> allGoodsUnit = new List<GoodsUnit>();
double newPrice;
List<SaleOrderHeader> tempSOHD = new List<SaleOrderHeader>();

void clearOrder(){
  productCart = new List<ProductCart>();
  editingProductCart = null;
  selectedProduct = null;
  discountBill = 0;
}


