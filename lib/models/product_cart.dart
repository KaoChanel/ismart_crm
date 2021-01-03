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
    this.vatGroupId,
    this.vatRate,
    this.vatGroupCode,
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
  int vatGroupId;
  int vatRate;
  String vatGroupCode;
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

  Map<String, dynamic> toJson() => {
    "rowIndex": rowIndex == null ? null : rowIndex,
    "goodId": goodId == null ? null : goodId,
    "goodCode": goodCode == null ? null : goodCode,
    "goodName1": goodName1 == null ? null : goodName1,
    "goodName2": goodName2 == null ? null : goodName2,
    "goodNameEng1": goodNameEng1 == null ? null : goodNameEng1,
    "goodNameEng2": goodNameEng2 == null ? null : goodNameEng2,
    "goodBillName": goodBillName == null ? null : goodBillName,
    "mainGoodUnitId": mainGoodUnitId == null ? null : mainGoodUnitId,
    "saleGoodUnitId": saleGoodUnitId,
    "subGoodUnitId": subGoodUnitId,
    "buyGoodUnitId": buyGoodUnitId == null ? null : buyGoodUnitId,
    "vatgroupId": vatGroupId == null ? null : vatGroupId,
    "vatRate": vatRate == null ? null : vatRate,
    "vatgroupCode": vatGroupCode == null ? null : vatGroupCode,
    "vatType": vatType == null ? null : vatType,
    "goodTypeFlag": goodTypeFlag == null ? null : goodTypeFlag,
    "goodCateId": goodCateId == null ? null : goodCateId,
    "inactive": inactive == null ? null : inactive,
    "goodGroupId": goodGroupId == null ? null : goodGroupId,
    "goodTypeId": goodTypeId == null ? null : goodTypeId,
  };

}