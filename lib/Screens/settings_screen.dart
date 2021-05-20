import 'package:flutter/material.dart';
import 'package:speedometer_lite/Screens/home_screen.dart';
import 'package:speedometer_lite/Services/constants.dart';
import 'package:provider/provider.dart';
import 'package:speedometer_lite/Services/current_state.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen();

  @override
  Widget build(BuildContext context) {
    List<FlatButton> getThemeButttons() {
      List<FlatButton> buttonList = [];
      for (Color colour in allThemesList) {
        buttonList.add(FlatButton(
          minWidth: 5,
          onPressed: () {
            Provider.of<CurrentState>(context).changeTheme(colour);
          },
          child: CircleAvatar(
            radius: 10,
            backgroundColor: colour,
          ),
        ));
      }
      return buttonList;
    }

    return Container(
      color: Color(0xFF757575),
      child: Container(
        height: 350,
        padding: EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Unit',
              style: infoTxt,
            ),
            DropdownButton<String>(
                items: getUnitItems(),
                value: Provider.of<CurrentState>(context).unit,
                onChanged: (value) {
                  Provider.of<CurrentState>(context).setUnit(value);
                }),
            SizedBox(
              height: 20,
            ),
            Text(
              'Select Theme',
              style: infoTxt,
            ),
            Container(
              width: 400,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: getThemeButttons(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 30,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  color: Provider.of<CurrentState>(context).theme,
                ),
                child: Center(
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
