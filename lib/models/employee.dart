import 'package:meta/meta.dart';

// To parse this JSON data, do
//
//     final employees = employeesFromJson(jsonString);

import 'dart:convert';

Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

String employeeToJson(List<Employee> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {
  Employee({
    this.rowId,
    this.empId,
    this.deptId,
    this.postId,
    this.empCode,
    this.namePrefix,
    this.empName,
    this.nickname,
    this.createBy,
    this.createDate,
    this.updateBy,
    this.updateDate,
    this.address,
    this.contact,
    this.email,
    this.leaderId,
    this.teamId,
    this.dummyCode,
    this.remark,
    this.username,
  });

  int rowId;
  int empId;
  int deptId;
  int postId;
  String empCode;
  dynamic namePrefix;
  String empName;
  dynamic nickname;
  dynamic createBy;
  dynamic createDate;
  dynamic updateBy;
  dynamic updateDate;
  dynamic address;
  dynamic contact;
  dynamic email;
  dynamic leaderId;
  dynamic teamId;
  dynamic dummyCode;
  String remark;
  String username;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    rowId: json["rowId"] == null ? null : json["rowId"],
    empId: json["empId"] == null ? null : json["empId"],
    deptId: json["deptId"] == null ? null : json["deptId"],
    postId: json["postId"] == null ? null : json["postId"],
    empCode: json["empCode"] == null ? null : json["empCode"],
    namePrefix: json["namePrefix"],
    empName: json["empName"] == null ? null : json["empName"],
    nickname: json["nickname"],
    createBy: json["createBy"],
    createDate: json["createDate"],
    updateBy: json["updateBy"],
    updateDate: json["updateDate"],
    address: json["address"],
    contact: json["contact"],
    email: json["email"],
    leaderId: json["leaderId"],
    teamId: json["teamId"],
    dummyCode: json["dummyCode"],
    remark: json["remark"] == null ? null : json["remark"],
    username: json["username"] == null ? null : json["username"],
  );

  Map<String, dynamic> toJson() => {
    "rowId": rowId == null ? null : rowId,
    "empId": empId == null ? null : empId,
    "deptId": deptId == null ? null : deptId,
    "postId": postId == null ? null : postId,
    "empCode": empCode == null ? null : empCode,
    "namePrefix": namePrefix,
    "empName": empName == null ? null : empName,
    "nickname": nickname,
    "createBy": createBy,
    "createDate": createDate,
    "updateBy": updateBy,
    "updateDate": updateDate,
    "address": address,
    "contact": contact,
    "email": email,
    "leaderId": leaderId,
    "teamId": teamId,
    "dummyCode": dummyCode,
    "remark": remark == null ? null : remark,
    "username": username == null ? null : username,
  };
}
