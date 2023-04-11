import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';
import 'package:quitsmoke/main.dart';
import 'package:quitsmoke/patrol_keys.dart';

void main() {
  patrolTest(
    'demo',
    (PatrolTester $) async {
      await prepare();
      await $.pumpWidgetAndSettle(MyApp());
      await $(K.quittingReasonTextField).enterText('quitting reason');
      await $(K.addReasonButton).tap();
      await $.native.pressBack();
      await $(K.nextButton).tap();

      await $(TextFormField).at(0).enterText('5');
      await $(TextFormField).at(1).enterText('1');
      await $(DropdownButton<String>).tap();
      await $(DropdownMenuItem<String>).$(RegExp(r'Euro')).tap();
      await $(K.nextButton).tap(andSettle: false);

      await $(K.startNowButton).waitUntilVisible().tap(andSettle: false);

      await $(#text).waitUntilVisible();
    },
    nativeAutomation: true,
  );
}
