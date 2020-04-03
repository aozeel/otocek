import 'dart:async' show Future;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart' show rootBundle;

class Markamodel{
  
  static Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/markamodel.json');
  }

}