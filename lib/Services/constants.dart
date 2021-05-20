import 'package:flutter/material.dart';
import 'package:speedometer_lite/Services/current_state.dart';
import 'theme_structure.dart';

TextStyle defaulttxt = TextStyle(color: Colors.white70, fontSize: 20);
TextStyle infoTxt = TextStyle(color: Colors.black54, fontSize: 15);
Color kthemeColor = Colors.cyan;
TextStyle speedTxt = TextStyle(color: Colors.white, fontSize: 120);

// List<DropdownMenuItem<Color>> ddThemeItems = [
//   DropdownMenuItem(
//     child: Text('Red'),
//     value: Colors.red,
//   ),
//   DropdownMenuItem(
//     child: Text('Teal'),
//     value: Colors.teal,
//   ),
//   DropdownMenuItem(
//     child: Text('pink'),
//     value: Colors.pink,
//   ),
//   DropdownMenuItem(
//     child: Text(
//       'black',
//       //style: TextStyle(color: Colors.white),
//     ),
//     value: Colors.black54,
//   ),
// ];
// List<DropdownMenuItem<Color>> getThemeItems() {
//   return ddThemeItems;
// }

List<Color> allThemesList = [
  Colors.black54,
  Colors.blueGrey,
  Colors.teal,
  Color.fromARGB(180, 80, 10, 10),
  Colors.grey,
];

List<DropdownMenuItem<String>> ddUnitItems = [
  DropdownMenuItem(
    child: Text('meter/second'),
    value: 'm/s',
  ),
  DropdownMenuItem(
    child: Text('kilometer/hour'),
    value: 'kmph',
  ),
  DropdownMenuItem(
    child: Text('miles/hour'),
    value: 'mph',
  )
];
List<DropdownMenuItem<String>> getUnitItems() {
  return ddUnitItems;
}
