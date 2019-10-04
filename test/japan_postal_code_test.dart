// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:japan_postal_code/japan_postal_code.dart';


void main(){

  group('$JapanPostCode', (){
    test('reading', () async {
      final japanPostCode = await JapanPostCode.getInstance();
      final data = await japanPostCode.getJapanPostalCode("0640941");
      expect(data.length, greaterThan(0));
    });
  });
}