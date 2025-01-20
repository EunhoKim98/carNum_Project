import 'package:flutter/material.dart';
import 'package:car/models/car_model.dart';

class SearchResult extends StatelessWidget {
  final CarModel carModel;
  final String carNum;

  const SearchResult({Key? key, required this.carModel, required this.carNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    // 스크롤 변경
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            child: Divider(color: Colors.grey, thickness: 2.0),
          ),
          SizedBox(height: 15),
          Container(
            width: double.infinity,

            child: DataTable(
                columns: [
                  DataColumn(
                    label: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '사고수준',
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '사고날짜',
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '차량번호',
                      ),
                    ),
                  ),
                ],
                  rows: [
                    DataRow(cells: [
                      DataCell(
                        Container(
                          child: Text(carModel.acdnKindNm),
                        ),
                      ),
                      DataCell(
                        Container(
                          child: Text(carModel.acdnOccrDtm),
                        ),
                      ),
                      DataCell(
                        Container(
                          child: Text(carModel.nowVhclNo),
                        ),
                      ),
                    ]),
                  ],
                ),
          ),

          Container(padding: EdgeInsets.all(8)),
          Icon(Icons.car_crash, color: Color.fromARGB(255, 0, 122, 255), size: 100),
          Text("침 수 차 량", style: TextStyle(color: Color.fromARGB(255, 0, 122, 255), fontSize: 20)),
        ],
      ),
    );
  }
}
