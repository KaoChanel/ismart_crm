import 'package:meta/meta.dart';

class ProductCart {
  ProductCart({
    this.rowIndex,
    this.productCartId,
    this.goodId,
    this.goodCode,
    this.goodName1,
    this.goodName2,
    this.goodNameEng1,
    this.goodNameEng2,
    this.goodBillName,
    this.mainGoodUnitId,
    this.saleGoodUnitId,
    this.subGoodUnitId,
    this.buyGoodUnitId,
    this.vatType,
    this.goodTypeFlag,
    this.goodCateId,
    this.inactive,
    this.goodGroupId,
    this.goodTypeId,
    this.goodPrice,
    this.goodQty,
    this.goodAmount,
    this.discount,
    this.isFree,
  });

  int rowIndex;
  String productCartId;
  int goodId;
  String goodCode;
  String goodName1;
  String goodName2;
  String goodNameEng1;
  String goodNameEng2;
  String goodBillName;
  int mainGoodUnitId;
  dynamic saleGoodUnitId;
  dynamic subGoodUnitId;
  int buyGoodUnitId;
  int vatType;
  String goodTypeFlag;
  int goodCateId;
  String inactive;
  int goodGroupId;
  int goodTypeId;
  double goodPrice;
  double goodQty;
  double goodAmount;
  double discount;
  String discountType;
  bool isFree;

}