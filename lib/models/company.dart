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
    compName: 'BioScience Animal Health Co., Ltd.',
  ),
  Company(
    compCode: 'NIC',
    compName: 'Nutrition',
  ),
  Company(
    compCode: 'PEDEX',
    compName: 'Pet',
  ),
];