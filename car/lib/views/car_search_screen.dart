import 'package:flutter/material.dart';
import 'package:car/models/car_model.dart';
import 'package:car/views/search_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarSearchScreen extends StatefulWidget {
  const CarSearchScreen({super.key});

  @override
  State<CarSearchScreen> createState() => _CarSearchScreenState();
}

class _CarSearchScreenState extends State<CarSearchScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _carNum;
  CarModel? _carModel;

  Future<CarModel?> searchCar(String carNum) async {
    String url = 'http://127.0.0.1:5000/api/cars?carNum=$carNum';
    // String url = 'http://54.180.109.207:5000/api/cars?carNum=$carNum';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);

        return CarModel.fromJson(jsonResponse);
      } else {
        print('Failed to load car data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('API ERROR: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '차량 검색',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 54, 52, 163),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SearchForm(
                formKey: _formKey,
                onSaved: (value) {
                  _carNum = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '차량 번호를 입력하세요';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.all(7.0),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    _formKey.currentState?.save();

                    searchCar(_carNum!).then((car) {
                      setState(() {
                        _carModel = car;
                      });
                    });
                  }
                },
                child: Text('검색'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 54, 52, 163), // 배경색 설정
                ),
              ),
              SizedBox(height: 30),
              // 차량 정보를 표로 보여주는 부분
              if (_carModel != null) ...[
                DataTable(
                  columns: [
                    DataColumn(
                      label: Container(
                        child: Text(
                          '사고수준',
                          textAlign: TextAlign.center, // 가운데 정렬
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        child: Text(
                          '사고날짜',
                          textAlign: TextAlign.center, // 가운데 정렬
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Container(
                        child: Text(
                          '차량번호',
                          textAlign: TextAlign.center, // 가운데 정렬
                        ),
                      ),
                    ),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(
                        Container(
                          alignment: Alignment.center, // 가운데 정렬
                          child: Text(_carModel!.acdnKindNm),
                        ),
                      ),
                      DataCell(
                        Container(
                          alignment: Alignment.center, // 가운데 정렬
                          child: Text(_carModel!.acdnOccrDtm),
                        ),
                      ),
                      DataCell(
                        Container(
                          alignment: Alignment.center, // 가운데 정렬
                          child: Text(_carModel!.nowVhclNo),
                        ),
                      ),
                    ]),
                  ],
                ),
                // 추가적인 아이콘 또는 메시지 표시
                Container(padding: EdgeInsets.all(16),),
                Icon(Icons.car_crash, color: Color.fromARGB(255, 0, 122, 255), size: 150,),
                Text("침 수 차 량", style: TextStyle(color: Color.fromARGB(255, 0, 122, 255), fontSize: 20),),
              ] else if (_carModel == null && _carNum != null) ...[
                Icon(Icons.gpp_good, color: Color.fromARGB(255, 0, 122, 255), size: 150,),
                Text("침수 이력이 없습니다.", style: TextStyle(color: Color.fromARGB(255, 0, 122, 255), fontSize: 20),),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class SearchForm extends StatelessWidget {
  const SearchForm({
    super.key,
    this.formKey,
    this.isEnabled = true,
    this.onSaved,
    this.validator,
    this.onChanged, // 여기에 추가
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus = false,
  });

  final GlobalKey<FormState>? formKey;
  final bool isEnabled;
  final ValueChanged<String?>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged; // 여기에 추가
  final onFieldSubmitted;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      onSaved: onSaved,
      validator: validator,
      onChanged: onChanged, // 여기에 추가
      focusNode: focusNode,
      autofocus: autofocus,
      decoration: InputDecoration(
        labelText: '차량 번호 입력',
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 54, 52, 163), // 포커스 시 색상
          ),
        ),
      ),
    );
  }
}
