import 'package:meta/meta.dart';

class Company{
  Company({
    @required this.compCode,
    @required this.compName,
  });

  final String compCode;
  final String compName;
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