import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrentState extends ChangeNotifier {
  Color theme = Colors.blueGrey;
  String unit = 'm/s';

  void changeTheme(Color colour) {
    theme = colour;
    notifyListeners();
  }

  void setUnit(String newUnit) {
    unit = newUnit;
    notifyListeners();
  }
}
