// To parse this JSON data, do
//
//     final saleOrderHeader = saleOrderHeaderFromJson(jsonString);

import 'dart:convert';

List<SaleOrderHeader> saleOrderHeaderFromJson(String str) => List<SaleOrderHeader>.from(json.decode(str).map((x) => SaleOrderHeader.fromJson(x)));

String saleOrderHeaderToJson(List<SaleOrderHeader> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SaleOrderHeader {
  SaleOrderHeader({
    this.soid,
    this.saleAreaId,
    this.vatgroupId,
    this.empId,
    this.currTypeId,
    this.creditId,
    this.brchId,
    this.currId,
    this.transpAreaId,
    this.transpId,
    this.custId,
    this.deptId,
    this.docuNo,
    this.docuType,
    this.docuDate,
    this.validDays,
    this.expireDate,
    this.onHold,
    this.vatRate,
    this.vatType,
    this.goodType,
    this.shipToAddr1,
    this.shipToAddr2,
    this.district,
    this.amphur,
    this.province,
    this.tel,
    this.postCode,
    this.fax,
    this.contactName,
    this.condition,
    this.shipDays,
    this.creditDays,
    this.creditTermType,
    this.fixedRate,
    this.exchRate,
    this.exchDate,
    this.shipDate,
    this.printTime,
    this.sumIncludeAmnt,
    this.sumExcludeAmnt,
    this.sumGoodAmnt,
    this.baseDiscAmnt,
    this.billDiscFormula,
    this.billDiscAmnt,
    this.billAftrDiscAmnt,
    this.totaExcludeAmnt,
    this.totaBaseAmnt,
    this.vatamnt,
    this.netAmnt,
    this.attach,
    this.organName,
    this.remark,
    this.custPodate,
    this.statusRemark,
    this.custPono,
    this.vateffc,
    this.refSoid,
    this.commission,
    this.refNo,
    this.refDate,
    this.commissionAmnt,
    this.clearSo,
    this.fob,
    this.discVateffc,
    this.endCreditDate,
    this.miscChargFormula,
    this.miscChargAmnt,
    this.miscChargRemark,
    this.multiCurrency,
    this.exchType,
    this.fromFlag,
    this.custName,
    this.resvStr1,
    this.resvStr2,
    this.resvStr3,
    this.resvStr4,
    this.resvStr5,
    this.resvStr6,
    this.resvStr7,
    this.resvAmnt1,
    this.resvAmnt2,
    this.resvAmnt3,
    this.resvDate1,
    this.docuStatus,
    this.resvAmnt4,
    this.sotitle,
    this.shipToCode,
    this.quotStatus,
    this.introduceId,
    this.appvFlag,
    this.contactnameShip,
    this.pkgStatus,
    this.jobId,
    this.refeflag,
    this.postdocutype,
    this.appvid,
    this.clearDate,
    this.alertFlag,
    this.clearflag,
    this.isTransfer,
  });

  int soid;
  int saleAreaId;
  int vatgroupId;
  int empId;
  dynamic currTypeId;
  dynamic creditId;
  int brchId;
  dynamic currId;
  dynamic transpAreaId;
  int transpId;
  int custId;
  dynamic deptId;
  String docuNo;
  int docuType;
  DateTime docuDate;
  int validDays;
  dynamic expireDate;
  String onHold;
  int vatRate;
  String vatType;
  String goodType;
  String shipToAddr1;
  dynamic shipToAddr2;
  dynamic district;
  dynamic amphur;
  dynamic province;
  dynamic tel;
  dynamic postCode;
  dynamic fax;
  String contactName;
  dynamic condition;
  dynamic shipDays;
  int creditDays;
  dynamic creditTermType;
  dynamic fixedRate;
  int exchRate;
  dynamic exchDate;
  DateTime shipDate;
  dynamic printTime;
  int sumIncludeAmnt;
  int sumExcludeAmnt;
  double sumGoodAmnt;
  double baseDiscAmnt;
  String billDiscFormula;
  double billDiscAmnt;
  double billAftrDiscAmnt;
  int totaExcludeAmnt;
  double totaBaseAmnt;
  double vatamnt;
  double netAmnt;
  dynamic attach;
  dynamic organName;
  dynamic remark;
  DateTime custPodate;
  dynamic statusRemark;
  String custPono;
  dynamic vateffc;
  dynamic refSoid;
  dynamic commission;
  dynamic refNo;
  dynamic refDate;
  int commissionAmnt;
  String clearSo;
  dynamic fob;
  dynamic discVateffc;
  dynamic endCreditDate;
  dynamic miscChargFormula;
  int miscChargAmnt;
  dynamic miscChargRemark;
  String multiCurrency;
  dynamic exchType;
  dynamic fromFlag;
  String custName;
  dynamic resvStr1;
  dynamic resvStr2;
  dynamic resvStr3;
  dynamic resvStr4;
  dynamic resvStr5;
  dynamic resvStr6;
  dynamic resvStr7;
  int resvAmnt1;
  int resvAmnt2;
  int resvAmnt3;
  dynamic resvDate1;
  String docuStatus;
  int resvAmnt4;
  dynamic sotitle;
  String shipToCode;
  String quotStatus;
  dynamic introduceId;
  String appvFlag;
  dynamic contactnameShip;
  String pkgStatus;
  dynamic jobId;
  String refeflag;
  dynamic postdocutype;
  dynamic appvid;
  dynamic clearDate;
  String alertFlag;
  String clearflag;
  String isTransfer;

  factory SaleOrderHeader.fromJson(Map<String, dynamic> json) => SaleOrderHeader(
    soid: json["soid"] == null ? null : json["soid"],
    saleAreaId: json["saleAreaId"] == null ? null : json["saleAreaId"],
    vatgroupId: json["vatgroupId"] == null ? null : json["vatgroupId"],
    empId: json["empId"] == null ? null : json["empId"],
    currTypeId: json["currTypeId"],
    creditId: json["creditId"],
    brchId: json["brchId"] == null ? null : json["brchId"],
    currId: json["currId"],
    transpAreaId: json["transpAreaId"],
    transpId: json["transpId"] == null ? null : json["transpId"],
    custId: json["custId"] == null ? null : json["custId"],
    deptId: json["deptId"],
    docuNo: json["docuNo"] == null ? null : json["docuNo"],
    docuType: json["docuType"] == null ? null : json["docuType"],
    docuDate: json["docuDate"] == null ? null : DateTime.parse(json["docuDate"]),
    validDays: json["validDays"] == null ? null : json["validDays"],
    expireDate: json["expireDate"],
    onHold: json["onHold"] == null ? null : json["onHold"],
    vatRate: json["vatRate"] == null ? null : json["vatRate"],
    vatType: json["vatType"] == null ? null : json["vatType"],
    goodType: json["goodType"] == null ? null : json["goodType"],
    shipToAddr1: json["shipToAddr1"] == null ? null : json["shipToAddr1"],
    shipToAddr2: json["shipToAddr2"],
    district: json["district"],
    amphur: json["amphur"],
    province: json["province"],
    tel: json["tel"],
    postCode: json["postCode"],
    fax: json["fax"],
    contactName: json["contactName"] == null ? null : json["contactName"],
    condition: json["condition"],
    shipDays: json["shipDays"],
    creditDays: json["creditDays"] == null ? null : json["creditDays"],
    creditTermType: json["creditTermType"],
    fixedRate: json["fixedRate"],
    exchRate: json["exchRate"] == null ? null : json["exchRate"],
    exchDate: json["exchDate"],
    shipDate: json["shipDate"] == null ? null : DateTime.parse(json["shipDate"]),
    printTime: json["printTime"],
    sumIncludeAmnt: json["sumIncludeAmnt"] == null ? null : json["sumIncludeAmnt"],
    sumExcludeAmnt: json["sumExcludeAmnt"] == null ? null : json["sumExcludeAmnt"],
    sumGoodAmnt: json["sumGoodAmnt"] == null ? null : json["sumGoodAmnt"].toDouble(),
    baseDiscAmnt: json["baseDiscAmnt"] == null ? null : json["baseDiscAmnt"],
    billDiscFormula: json["billDiscFormula"] == null ? null : json["billDiscFormula"],
    billDiscAmnt: json["billDiscAmnt"] == null ? null : json["billDiscAmnt"],
    billAftrDiscAmnt: json["billAftrDiscAmnt"] == null ? null : json["billAftrDiscAmnt"].toDouble(),
    totaExcludeAmnt: json["totaExcludeAmnt"] == null ? null : json["totaExcludeAmnt"],
    totaBaseAmnt: json["totaBaseAmnt"] == null ? null : json["totaBaseAmnt"].toDouble(),
    vatamnt: json["vatamnt"] == null ? null : json["vatamnt"].toDouble(),
    netAmnt: json["netAmnt"] == null ? null : json["netAmnt"].toDouble(),
    attach: json["attach"],
    organName: json["organName"],
    remark: json["remark"],
    custPodate: json["custPodate"] == null ? null : DateTime.parse(json["custPodate"]),
    statusRemark: json["statusRemark"],
    custPono: json["custPono"] == null ? null : json["custPono"],
    vateffc: json["vateffc"],
    refSoid: json["refSoid"],
    commission: json["commission"],
    refNo: json["refNo"],
    refDate: json["refDate"],
    commissionAmnt: json["commissionAmnt"] == null ? null : json["commissionAmnt"],
    clearSo: json["clearSo"] == null ? null : json["clearSo"],
    fob: json["fob"],
    discVateffc: json["discVateffc"],
    endCreditDate: json["endCreditDate"],
    miscChargFormula: json["miscChargFormula"],
    miscChargAmnt: json["miscChargAmnt"] == null ? null : json["miscChargAmnt"],
    miscChargRemark: json["miscChargRemark"],
    multiCurrency: json["multiCurrency"] == null ? null : json["multiCurrency"],
    exchType: json["exchType"],
    fromFlag: json["fromFlag"],
    custName: json["custName"] == null ? null : json["custName"],
    resvStr1: json["resvStr1"],
    resvStr2: json["resvStr2"],
    resvStr3: json["resvStr3"],
    resvStr4: json["resvStr4"],
    resvStr5: json["resvStr5"],
    resvStr6: json["resvStr6"],
    resvStr7: json["resvStr7"],
    resvAmnt1: json["resvAmnt1"] == null ? null : json["resvAmnt1"],
    resvAmnt2: json["resvAmnt2"] == null ? null : json["resvAmnt2"],
    resvAmnt3: json["resvAmnt3"] == null ? null : json["resvAmnt3"],
    resvDate1: json["resvDate1"],
    docuStatus: json["docuStatus"] == null ? null : json["docuStatus"],
    resvAmnt4: json["resvAmnt4"] == null ? null : json["resvAmnt4"],
    sotitle: json["sotitle"],
    shipToCode: json["shipToCode"] == null ? null : json["shipToCode"],
    quotStatus: json["quotStatus"] == null ? null : json["quotStatus"],
    introduceId: json["introduceId"],
    appvFlag: json["appvFlag"] == null ? null : json["appvFlag"],
    contactnameShip: json["contactnameShip"],
    pkgStatus: json["pkgStatus"] == null ? null : json["pkgStatus"],
    jobId: json["jobId"],
    refeflag: json["refeflag"] == null ? null : json["refeflag"],
    postdocutype: json["postdocutype"],
    appvid: json["appvid"],
    clearDate: json["clearDate"],
    alertFlag: json["alertFlag"] == null ? null : json["alertFlag"],
    clearflag: json["clearflag"] == null ? null : json["clearflag"],
    isTransfer: json["isTransfer"] == null ? null : json["isTransfer"],
  );

  Map<String, dynamic> toJson() => {
    "soid": soid == null ? null : soid,
    "saleAreaId": saleAreaId == null ? null : saleAreaId,
    "vatgroupId": vatgroupId == null ? null : vatgroupId,
    "empId": empId == null ? null : empId,
    "currTypeId": currTypeId,
    "creditId": creditId,
    "brchId": brchId == null ? null : brchId,
    "currId": currId,
    "transpAreaId": transpAreaId,
    "transpId": transpId == null ? null : transpId,
    "custId": custId == null ? null : custId,
    "deptId": deptId,
    "docuNo": docuNo == null ? null : docuNo,
    "docuType": docuType == null ? null : docuType,
    "docuDate": docuDate == null ? null : docuDate.toIso8601String(),
    "validDays": validDays == null ? null : validDays,
    "expireDate": expireDate,
    "onHold": onHold == null ? null : onHold,
    "vatRate": vatRate == null ? null : vatRate,
    "vatType": vatType == null ? null : vatType,
    "goodType": goodType == null ? null : goodType,
    "shipToAddr1": shipToAddr1 == null ? null : shipToAddr1,
    "shipToAddr2": shipToAddr2,
    "district": district,
    "amphur": amphur,
    "province": province,
    "tel": tel,
    "postCode": postCode,
    "fax": fax,
    "contactName": contactName == null ? null : contactName,
    "condition": condition,
    "shipDays": shipDays,
    "creditDays": creditDays == null ? null : creditDays,
    "creditTermType": creditTermType,
    "fixedRate": fixedRate,
    "exchRate": exchRate == null ? null : exchRate,
    "exchDate": exchDate,
    "shipDate": shipDate == null ? null : shipDate.toIso8601String(),
    "printTime": printTime,
    "sumIncludeAmnt": sumIncludeAmnt == null ? null : sumIncludeAmnt,
    "sumExcludeAmnt": sumExcludeAmnt == null ? null : sumExcludeAmnt,
    "sumGoodAmnt": sumGoodAmnt == null ? null : sumGoodAmnt,
    "baseDiscAmnt": baseDiscAmnt == null ? null : baseDiscAmnt,
    "billDiscFormula": billDiscFormula == null ? null : billDiscFormula,
    "billDiscAmnt": billDiscAmnt == null ? null : billDiscAmnt,
    "billAftrDiscAmnt": billAftrDiscAmnt == null ? null : billAftrDiscAmnt,
    "totaExcludeAmnt": totaExcludeAmnt == null ? null : totaExcludeAmnt,
    "totaBaseAmnt": totaBaseAmnt == null ? null : totaBaseAmnt,
    "vatamnt": vatamnt == null ? null : vatamnt,
    "netAmnt": netAmnt == null ? null : netAmnt,
    "attach": attach,
    "organName": organName,
    "remark": remark,
    "custPodate": custPodate == null ? null : custPodate.toIso8601String(),
    "statusRemark": statusRemark,
    "custPono": custPono == null ? null : custPono,
    "vateffc": vateffc,
    "refSoid": refSoid,
    "commission": commission,
    "refNo": refNo,
    "refDate": refDate,
    "commissionAmnt": commissionAmnt == null ? null : commissionAmnt,
    "clearSo": clearSo == null ? null : clearSo,
    "fob": fob,
    "discVateffc": discVateffc,
    "endCreditDate": endCreditDate,
    "miscChargFormula": miscChargFormula,
    "miscChargAmnt": miscChargAmnt == null ? null : miscChargAmnt,
    "miscChargRemark": miscChargRemark,
    "multiCurrency": multiCurrency == null ? null : multiCurrency,
    "exchType": exchType,
    "fromFlag": fromFlag,
    "custName": custName == null ? null : custName,
    "resvStr1": resvStr1,
    "resvStr2": resvStr2,
    "resvStr3": resvStr3,
    "resvStr4": resvStr4,
    "resvStr5": resvStr5,
    "resvStr6": resvStr6,
    "resvStr7": resvStr7,
    "resvAmnt1": resvAmnt1 == null ? null : resvAmnt1,
    "resvAmnt2": resvAmnt2 == null ? null : resvAmnt2,
    "resvAmnt3": resvAmnt3 == null ? null : resvAmnt3,
    "resvDate1": resvDate1,
    "docuStatus": docuStatus == null ? null : docuStatus,
    "resvAmnt4": resvAmnt4 == null ? null : resvAmnt4,
    "sotitle": sotitle,
    "shipToCode": shipToCode == null ? null : shipToCode,
    "quotStatus": quotStatus == null ? null : quotStatus,
    "introduceId": introduceId,
    "appvFlag": appvFlag == null ? null : appvFlag,
    "contactnameShip": contactnameShip,
    "pkgStatus": pkgStatus == null ? null : pkgStatus,
    "jobId": jobId,
    "refeflag": refeflag == null ? null : refeflag,
    "postdocutype": postdocutype,
    "appvid": appvid,
    "clearDate": clearDate,
    "alertFlag": alertFlag == null ? null : alertFlag,
    "clearflag": clearflag == null ? null : clearflag,
    "isTransfer": isTransfer == null ? null : isTransfer,
  };
}
