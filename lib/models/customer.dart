// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  Customer({
    this.rowId,
    this.custId,
    this.custCode,
    this.custName,
    this.custNameEng,
    this.shortName,
    this.taxId,
    this.custAddr1,
    this.custAddr2,
    this.district,
    this.amphur,
    this.province,
    this.postCode,
    this.tel,
    this.fax,
    this.email,
    this.lineId,
    this.cardNo,
    this.busiTypeId,
    this.creditType,
    this.creditState,
    this.creditDays,
  });

  int rowId;
  int custId;
  String custCode;
  String custName;
  dynamic custNameEng;
  String shortName;
  String taxId;
  dynamic custAddr1;
  dynamic custAddr2;
  String district;
  String amphur;
  String province;
  String postCode;
  dynamic tel;
  dynamic fax;
  dynamic email;
  dynamic lineId;
  dynamic cardNo;
  int busiTypeId;
  dynamic creditType;
  String creditState;
  int creditDays;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    rowId: json["rowId"] == null ? null : json["rowId"],
    custId: json["custId"] == null ? null : json["custId"],
    custCode: json["custCode"] == null ? null : json["custCode"],
    custName: json["custName"] == null ? null : json["custName"],
    custNameEng: json["custNameEng"],
    shortName: json["shortName"] == null ? null : json["shortName"],
    taxId: json["taxId"] == null ? null : json["taxId"],
    custAddr1: json["custAddr1"],
    custAddr2: json["custAddr2"],
    district: json["district"] == null ? null : json["district"],
    amphur: json["amphur"] == null ? null : json["amphur"],
    province: json["province"] == null ? null : json["province"],
    postCode: json["postCode"] == null ? null : json["postCode"],
    tel: json["tel"],
    fax: json["fax"],
    email: json["email"],
    lineId: json["lineId"],
    cardNo: json["cardNo"],
    busiTypeId: json["busiTypeId"] == null ? null : json["busiTypeId"],
    creditType: json["creditType"],
    creditState: json["creditState"] == null ? null : json["creditState"],
    creditDays: json["creditDays"] == null ? null : json["creditDays"],
  );

  Map<String, dynamic> toJson() => {
    "rowId": rowId == null ? null : rowId,
    "custId": custId == null ? null : custId,
    "custCode": custCode == null ? null : custCode,
    "custName": custName == null ? null : custName,
    "custNameEng": custNameEng,
    "shortName": shortName == null ? null : shortName,
    "taxId": taxId == null ? null : taxId,
    "custAddr1": custAddr1,
    "custAddr2": custAddr2,
    "district": district == null ? null : district,
    "amphur": amphur == null ? null : amphur,
    "province": province == null ? null : province,
    "postCode": postCode == null ? null : postCode,
    "tel": tel,
    "fax": fax,
    "email": email,
    "lineId": lineId,
    "cardNo": cardNo,
    "busiTypeId": busiTypeId == null ? null : busiTypeId,
    "creditType": creditType,
    "creditState": creditState == null ? null : creditState,
    "creditDays": creditDays == null ? null : creditDays,
  };
}
