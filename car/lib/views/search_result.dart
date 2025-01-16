import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: double.infinity,
            child: Divider(color: Colors.grey, thickness: 2.0)),
        Text(
          "검색결과",
          style: TextStyle(
              fontWeight: FontWeight.bold,
          ),
        ),
        Container(width: double.infinity,
            child: Divider(color: Colors.grey, thickness: 2.0)),
      ],
    );
  }
}
