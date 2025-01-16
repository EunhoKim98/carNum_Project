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
    // String url = 'http://127.0.0.1:5000/api/cars?carNum=
    String url = 'http://54.180.109.207:500'
        '0/api/cars?carNum=$carNum';

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
        title: Text('차량 검색'),
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
                onChanged: (value) {
                  // 차량 번호가 변경될 때 수행할 작업 (필요시)
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

                      if (_carModel != null) {
                        print('차량 정보: ${_carModel!.acdnKindNm}');
                      } else {
                        print('차량을 찾을 수 없습니다.');
                        // 화면상에 띄어줘야함
                      }
                    });
                  }
                },
                child: Text('검색'),
              ),
              if (_carModel != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SearchResult(),
                    // Text 말고 다른걸로 띄어주고 싶음
                  ),
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
      ),
    );
  }
}
