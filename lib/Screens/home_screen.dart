import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speedometer_lite/Services/current_state.dart';
import 'package:speedometer_lite/Services/gps_brain.dart';
import 'package:speedometer_lite/Services/constants.dart';
import 'package:speedometer_lite/Screens/settings_screen.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:speedometer_lite/Services/theme_structure.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget buildBottomSheet(BuildContext context) {
    return SettingsScreen();
  }

  Color themeColor = Colors.red;
  double lat = 0;
  double long = 0;
  double speed = 0;
  double sampleDist = 0;
  double totalDistance = 0.0;
  double maxSpeed = 0;

  String status = 'Not Started';
  bool isWorking = false;

  @override
  Widget build(BuildContext context) {
    String currUnit = Provider.of<CurrentState>(context).unit;
    Color currTheme = Provider.of<CurrentState>(context).theme;
    double conversionFactor;
    if (currUnit == 'm/s') conversionFactor = 1.0;
    if (currUnit == 'kmph') conversionFactor = 3.6;
    if (currUnit == 'mph') conversionFactor = 2.2;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Provider.of<CurrentState>(context).theme,
        onPressed: () {
          return showModalBottomSheet(
            context: context,
            builder: buildBottomSheet,
          );
        },
        child: Icon(Icons.settings),
      ),
      backgroundColor: Provider.of<CurrentState>(context).theme,
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 80, right: 20, left: 20, bottom: 20),
            height: 300,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(
                      '${(speed * conversionFactor).toInt()}',
                      style: speedTxt,
                    ),
                    Text(
                      '  $currUnit',
                      style: defaulttxt,
                    ),
                  ],
                ),
                //Text('Sample distance = $sampleDist')
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    offset: Offset(0.0, 1.5),
                    blurRadius: 16.0,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Text(
                                    'Distance : ',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 25),
                                  ),
                                  Text(
                                    '${totalDistance.toInt()} m',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 30),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: [
                                  Text(
                                    'Max. Speed : ',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 25),
                                  ),
                                  Text(
                                    '${maxSpeed.toInt()} $currUnit',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 30),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Position: lat:$lat , long:$long',
                                style: infoTxt,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              FlatButton(
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    color: Provider.of<CurrentState>(context)
                                        .theme,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Start/Stop',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(10),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    status = 'Processing...';
                                    isWorking = !isWorking;
                                  });

                                  while (isWorking) {
                                    GpsBrain obj = GpsBrain();
                                    Position pos = await obj.getLocation();
                                    speed = await obj.calcSpeed(5);
                                    setState(() {
                                      lat = pos.latitude;
                                      long = pos.longitude;
                                      totalDistance += speed * 5.0;
                                      if (speed * conversionFactor > maxSpeed)
                                        maxSpeed = speed * conversionFactor;
                                    });
                                  }
                                  setState(() {
                                    status = 'Stopped!';
                                  });
                                },
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Status: $status',
                                style: infoTxt,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
