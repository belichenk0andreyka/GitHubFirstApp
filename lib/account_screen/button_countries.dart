import 'package:flutter/material.dart';
import 'package:logining/account_screen/countriesList.dart';

class DropDown extends StatefulWidget {
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
  .map(
    (String value) => DropdownMenuItem<String>(
      value:value,
      child:Text(value),
      ),
      ).toList();
String _choiseCountry;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: _choiseCountry,
      hint: Text('Choise your counry'),
      style: TextStyle(color:Color(0xFF448AFF)),
      onChanged: ((String newValue){
        setState(() {
                  _choiseCountry = newValue;
                });
      }),
      items: _dropDownMenuItems,
    );
  }
}