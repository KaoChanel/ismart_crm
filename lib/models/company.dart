import 'package:meta/meta.dart';

class Company{
  Company({
    this.compCode,
    this.compName,
  });

  String compCode;
  String compName;
}

final companys = <Company>[
  Company(
    compCode: 'BIO',
    compName: 'BIO SCIENCE',
  ),
  Company(
    compCode: 'NIC',
    compName: 'NUTRITION IMPROVEMENT',
  ),
  Company(
    compCode: 'SIS',
    compName: 'SPECIAL INGREDIENT SERVICE',
  ),
  Company(
    compCode: 'FAITH',
    compName: 'FAITH',
  ),
  Company(
    compCode: 'PEDEX',
    compName: 'PEDEX',
  ),
  Company(
    compCode: 'PTK',
    compName: 'PROTESTKIT',
  ),
];