import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';
import 'package:quitsmoke/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  patrolTest(
    'demo',
    nativeAutomation: true,
    (PatrolTester $) async {
      await prepare();
      await SharedPreferences.getInstance().then((value) {
        value.clear();
      });
      await $.pumpWidgetAndSettle(MyApp());

      await $(TextField).enterText('quitting reason');
      await $('Add to list').tap();
      await $.native.pressBack();
      await $(IconButton).at(1).tap();
      //await $(#nextButton).tap();

      await $(TextFormField).at(0).enterText('5');
      await $(TextFormField).at(1).enterText('1');
      await $(DropdownButton<String>).tap();
      await $(DropdownMenuItem<String>).$(RegExp(r'Euro')).tap();
      await $(#nextButton).tap(andSettle: false);

      await $(#startNowButton).waitUntilVisible().tap(andSettle: false);

      await $(#text).waitUntilVisible();
    },
  );
}
