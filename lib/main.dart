import 'package:flutter/material.dart';
import 'package:speedometer_lite/Screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:speedometer_lite/Services/current_state.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CurrentState>(
      create: (BuildContext context) => CurrentState(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
