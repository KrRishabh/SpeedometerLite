import 'dart:io';

import 'dart:async';
import 'package:geolocator/geolocator.dart';

class GpsBrain {
  Future<Position> getLocation() async {
    print('getLocation() called.');
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      timeLimit: Duration(seconds: 10),
    );
    print(position);
    return position;
  }

  Future<double> calcSpeed(int timegap) async {
    Duration timeout = Duration(seconds: timegap);
    Position pos1 = await getLocation();
    sleep(timeout);
    Position pos2 = await getLocation();
    double distance = Geolocator.distanceBetween(
        pos1.latitude, pos1.longitude, pos2.latitude, pos2.longitude);
    double speed = distance / timegap;
    print('speed = $speed');
    return speed;
  }
}
