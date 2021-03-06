import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ismart_crm/models/employee.dart';
import 'package:ismart_crm/globals.dart' as globals;
import 'package:ismart_crm/api_service.dart';
import 'package:ismart_crm/charts/lineChart.dart';
import 'package:fl_chart/fl_chart.dart';

class EmployeeProfile extends StatefulWidget {
  @override
  _EmployeeProfileState createState() => _EmployeeProfileState();
}

class _EmployeeProfileState extends State<EmployeeProfile> with TickerProviderStateMixin {
  static const routeName = '/employee_profile';
  Employee _employees;
  TabController _controller;
  ApiService _apiService = ApiService();

  Future<void> getEmployee(String empId) async {
    String strUrl = '${globals.publicAddress}/api/employees/$empId';
    var response = await http.get(strUrl);

    setState(() {
      _employees = employeeFromJson(response.body);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    if(globals.allCustomer == null || globals.allProduct == null || globals.allGoodsUnit == null || globals.allShipto == null || globals.allStock == null || globals.allRemark == null){
      //_apiService.getCompany();
      _apiService.getAllCustomer();
      _apiService.getProduct();
      _apiService.getUnit();
      _apiService.getShipto();
      _apiService.getStock();
      _apiService.getRemark();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: SafeArea(
            child: Row(
              children:[
                Expanded(
                  flex: 2,
                  child: ListView(
                  children:[
                    Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/bg_04.jpg"),
                                fit: BoxFit.fitWidth
                            )
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          child: Container(
                            alignment: Alignment(0.0, 5.0),
                            child: CircleAvatar(
                              backgroundImage: AssetImage("assets/avatar_01.png"),
                              radius: 60.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Text(
                        "${globals.employee?.empTitle}${globals.employee?.empName}"
                        ,style: TextStyle(
                          fontSize: 20.0,
                          color:Colors.blueGrey,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w400
                      ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        globals.employee?.postName ?? 'Technicial & Product Advisor'
                        ,style: TextStyle(
                          fontSize: 18.0,
                          color:Colors.black45,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300
                      ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        globals.allCompany?.first?.compNameEng ?? ''
                        ,style: TextStyle(
                          fontSize: 15.0,
                          color:Colors.black45,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300
                      ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Card(
                      //     margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                      //     elevation: 2.0,
                      //     child: Padding(
                      //         padding: EdgeInsets.symmetric(vertical: 12,horizontal: 30),
                      //         child: Text("Skill Sets",style: TextStyle(
                      //             letterSpacing: 2.0,
                      //             fontWeight: FontWeight.w300
                      //         ),))
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Text(
                      //   "App Developer || Digital Marketer"
                      //   ,style: TextStyle(
                      //     fontSize: 18.0,
                      //     color:Colors.black45,
                      //     letterSpacing: 2.0,
                      //     fontWeight: FontWeight.w300
                      // ),
                      // ),
                      // Card(
                      //   margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       children: [
                      //         Expanded(
                      //           child: Column(
                      //             children: [
                      //               Text("Project",
                      //                 style: TextStyle(
                      //                     color: Colors.blueAccent,
                      //                     fontSize: 22.0,
                      //                     fontWeight: FontWeight.w600
                      //                 ),),
                      //               SizedBox(
                      //                 height: 7,
                      //               ),
                      //               Text("15",
                      //                 style: TextStyle(
                      //                     color: Colors.black,
                      //                     fontSize: 22.0,
                      //                     fontWeight: FontWeight.w300
                      //                 ),)
                      //             ],
                      //           ),
                      //         ),
                      //         Expanded(
                      //           child:
                      //           Column(
                      //             children: [
                      //               Text("Followers",
                      //                 style: TextStyle(
                      //                     color: Colors.blueAccent,
                      //                     fontSize: 22.0,
                      //                     fontWeight: FontWeight.w600
                      //                 ),),
                      //               SizedBox(
                      //                 height: 7,
                      //               ),
                      //               Text("2000",
                      //                 style: TextStyle(
                      //                     color: Colors.black,
                      //                     fontSize: 22.0,
                      //                     fontWeight: FontWeight.w300
                      //                 ),)
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 50,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     RaisedButton(
                      //       onPressed: (){
                      //       },
                      //       shape:  RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(80.0),
                      //       ),
                      //       child: Ink(
                      //         decoration: BoxDecoration(
                      //           gradient: LinearGradient(
                      //               begin: Alignment.centerLeft,
                      //               end: Alignment.centerRight,
                      //               colors: [Colors.pink,Colors.redAccent]
                      //           ),
                      //           borderRadius: BorderRadius.circular(30.0),
                      //         ),
                      //         child: Container(
                      //           constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
                      //           alignment: Alignment.center,
                      //           child: Text(
                      //             "Contact me",
                      //             style: TextStyle(
                      //                 color: Colors.white,
                      //                 fontSize: 12.0,
                      //                 letterSpacing: 2.0,
                      //                 fontWeight: FontWeight.w300
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     RaisedButton(
                      //       onPressed: (){
                      //       },
                      //       shape:  RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(80.0),
                      //       ),
                      //       child: Ink(
                      //         decoration: BoxDecoration(
                      //           gradient: LinearGradient(
                      //               begin: Alignment.centerLeft,
                      //               end: Alignment.centerRight,
                      //               colors: [Colors.pink,Colors.redAccent]
                      //           ),
                      //           borderRadius: BorderRadius.circular(80.0),
                      //         ),
                      //         child: Container(
                      //           constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
                      //           alignment: Alignment.center,
                      //           child: Text(
                      //             "Portfolio",
                      //             style: TextStyle(
                      //                 color: Colors.white,
                      //                 fontSize: 12.0,
                      //                 letterSpacing: 2.0,
                      //                 fontWeight: FontWeight.w300
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     )
                      //  ],
                      //)
                    ],
                  )],
              ),
                ),
                Expanded(
                  flex: 4,
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            LineChart(
                              sampleData1() ,
                              swapAnimationDuration: const Duration(milliseconds: 250),
                            ),
                            LineChart(
                              sampleData2() ,
                              swapAnimationDuration: const Duration(milliseconds: 250),
                            ),
                          ],
                        )
                      ],
                    )
                )
            ]),
          )
      ),
    );
  }
}
