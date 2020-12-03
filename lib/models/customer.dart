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
  dynamic inactive;
  int creditDays;
  String taxId;
  dynamic custAddr1;
  dynamic custAddr2;
  String district;
  String amphur;
  Province province;
  String postCode;
  dynamic custTypeName;
  String brchName;
  dynamic saleAreaId;
  dynamic saleAreaName;
  String custMapFullPath;
  int empId;
  EmpCode empCode;
  EmpName empName;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    custId: json["custId"] == null ? null : json["custId"],
    custCode: json["custCode"] == null ? null : json["custCode"],
    custName: json["custName"] == null ? null : json["custName"],
    custStartDate: json["custStartDate"],
    inactive: json["inactive"],
    creditDays: json["creditDays"] == null ? null : json["creditDays"],
    taxId: json["taxId"] == null ? null : json["taxId"],
    custAddr1: json["custAddr1"],
    custAddr2: json["custAddr2"],
    district: json["district"] == null ? null : json["district"],
    amphur: json["amphur"] == null ? null : json["amphur"],
    province: json["province"] == null ? null : provinceValues.map[json["province"]],
    postCode: json["postCode"] == null ? null : json["postCode"],
    custTypeName: json["custTypeName"],
    brchName: json["brchName"] == null ? null : json["brchName"],
    saleAreaId: json["saleAreaId"],
    saleAreaName: json["saleAreaName"],
    custMapFullPath: json["custMapFullPath"] == null ? null : json["custMapFullPath"],
    empId: json["empId"] == null ? null : json["empId"],
    empCode: json["empCode"] == null ? null : empCodeValues.map[json["empCode"]],
    empName: json["empName"] == null ? null : empNameValues.map[json["empName"]],
  );

  Map<String, dynamic> toJson() => {
    "custId": custId == null ? null : custId,
    "custCode": custCode == null ? null : custCode,
    "custName": custName == null ? null : custName,
    "custStartDate": custStartDate,
    "inactive": inactive,
    "creditDays": creditDays == null ? null : creditDays,
    "taxId": taxId == null ? null : taxId,
    "custAddr1": custAddr1,
    "custAddr2": custAddr2,
    "district": district == null ? null : district,
    "amphur": amphur == null ? null : amphur,
    "province": province == null ? null : provinceValues.reverse[province],
    "postCode": postCode == null ? null : postCode,
    "custTypeName": custTypeName,
    "brchName": brchName == null ? null : brchName,
    "saleAreaId": saleAreaId,
    "saleAreaName": saleAreaName,
    "custMapFullPath": custMapFullPath == null ? null : custMapFullPath,
    "empId": empId == null ? null : empId,
    "empCode": empCode == null ? null : empCodeValues.reverse[empCode],
    "empName": empName == null ? null : empNameValues.reverse[empName],
  };
}

enum EmpCode { EMS_0045 }

final empCodeValues = EnumValues({
  "EMS-0045": EmpCode.EMS_0045
});

enum EmpName { EMPTY }

final empNameValues = EnumValues({
  "สโรชาพัชร์ บุณยะโสรัจจ์": EmpName.EMPTY
});

enum Province { EMPTY, PROVINCE, PURPLE, FLUFFY, SAMUTPRAKARN, TENTACLED, STICKY }

final provinceValues = EnumValues({
  "กทม.": Province.EMPTY,
  "จ.สมุทรปราการ": Province.FLUFFY,
  "จ.สมุทรปราการ ": Province.PROVINCE,
  "กรุงเทพมหานคร": Province.PURPLE,
  "Samutprakarn": Province.SAMUTPRAKARN,
  "จ.นนทบุรี": Province.STICKY,
  "จ.ปทุมธานี": Province.TENTACLED
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
