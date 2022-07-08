// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
 
  const SearchBar({
    Key? key, 
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        shadowColor: Color.fromARGB(66, 158, 158, 158),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Color.fromARGB(29, 212, 212, 212),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                  border: InputBorder.none),
            )));
  }
}