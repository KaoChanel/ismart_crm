import 'package:flutter/material.dart';
import 'containerOrderTracking.dart';
import 'containerStock.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

Widget createCard(context, String title, String imagePath, String routeName){
  return Card(
      color: Colors.white,
      child: InkWell(
        onTap: (){
          if(routeName == 'ContainerOrderTracking'){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContainerOrderTracking()));
          }
          else if(routeName == 'ContainerStock'){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContainerStock()));
          }
        },
        child: Column(
          children: [
            new Container(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(imagePath)
            ),
            new Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text(title, style: Theme.of(context).textTheme.title)),
                  // Text(choice.date,
                  //     style: TextStyle(color: Colors.black.withOpacity(0.5))),
                  // Text(choice.description),
                ],
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ));
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children:[
        Row(
        children: [
          //Container(),
          Expanded(child: createCard(context, 'สถานะเอกสาร', 'https://digify.com/wp-content/uploads/2019/11/pdf-document-tracking.jpg', 'ContainerOrderTracking')),
          Expanded(child:createCard(context, 'สต๊อคสินค้า', 'https://www.skunexus.com/hubfs/choosing-inventory-management-software.png', 'ContainerStock')),
          Expanded(child:createCard(context, '', 'https://nostrahomes.com.au/uploads/cms/unknown.jpg', '')),
          Expanded(child:createCard(context, '', 'https://nostrahomes.com.au/uploads/cms/unknown.jpg', '')),
        ],
      ),
    ]
    );
  }
}
