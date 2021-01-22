// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

List<Customer> customerFromJson(String str) => List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));

String customerToJson(List<Customer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customer {
  Customer({
    this.custId,
    this.custCode,
    this.custName,
    this.custStartDate,
    this.inactive,
    this.creditDays,
    this.taxId,
    this.custAddr1,
    this.custAddr2,
    this.district,
    this.amphur,
    this.province,
    this.postCode,
    this.custTypeName,
    this.brchName,
    this.saleAreaId,
    this.saleAreaName,
    this.custMapFullPath,
    this.empId,
    this.empCode,
    this.empName,
  });

  int custId;
  String custCode;
  String custName;
  dynamic custStartDate;
  String inactive;
  int creditDays;
  String taxId;
  String custAddr1;
  dynamic custAddr2;
  String district;
  String amphur;
  String province;
  String postCode;
  dynamic custTypeName;
  dynamic brchName;
  int saleAreaId;
  dynamic saleAreaName;
  dynamic custMapFullPath;
  int empId;
  String empCode;
  String empName;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    custId: json["custId"] == null ? null : json["custId"],
    custCode: json["custCode"] == null ? null : json["custCode"],
    custName: json["custName"] == null ? null : json["custName"],
    custStartDate: json["custStartDate"],
    inactive: json["inactive"] == null ? null : json["inactive"],
    creditDays: json["creditDays"] == null ? null : json["creditDays"],
    taxId: json["taxId"] == null ? null : json["taxId"],
    custAddr1: json["custAddr1"] == null ? null : json["custAddr1"],
    custAddr2: json["custAddr2"],
    district: json["district"] == null ? null : json["district"],
    amphur: json["amphur"] == null ? null : json["amphur"],
    province: json["province"] == null ? null : json["province"],
    postCode: json["postCode"] == null ? null : json["postCode"],
    custTypeName: json["custTypeName"],
    brchName: json["brchName"],
    saleAreaId: json["saleAreaId"] == null ? null : json["saleAreaId"],
    saleAreaName: json["saleAreaName"],
    custMapFullPath: json["custMapFullPath"],
    empId: json["empId"] == null ? null : json["empId"],
    empCode: json["empCode"] == null ? null : json["empCode"],
    empName: json["empName"] == null ? null : json["empName"],
  );

  Map<String, dynamic> toJson() => {
    "custId": custId == null ? null : custId,
    "custCode": custCode == null ? null : custCode,
    "custName": custName == null ? null : custName,
    "custStartDate": custStartDate,
    "inactive": inactive == null ? null : inactive,
    "creditDays": creditDays == null ? null : creditDays,
    "taxId": taxId == null ? null : taxId,
    "custAddr1": custAddr1 == null ? null : custAddr1,
    "custAddr2": custAddr2,
    "district": district == null ? null : district,
    "amphur": amphur == null ? null : amphur,
    "province": province == null ? null : province,
    "postCode": postCode == null ? null : postCode,
    "custTypeName": custTypeName,
    "brchName": brchName,
    "saleAreaId": saleAreaId == null ? null : saleAreaId,
    "saleAreaName": saleAreaName,
    "custMapFullPath": custMapFullPath,
    "empId": empId == null ? null : empId,
    "empCode": empCode == null ? null : empCode,
    "empName": empName == null ? null : empName,
  };
}
