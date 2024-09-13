import 'package:flutter/material.dart';

class ScannedCodeProvider extends ChangeNotifier {
  String _value = '';
  String get value => _value;

  String _scannedCodeType = '';
  String get scannedCodeType => _scannedCodeType;

  
  set value(String newValue) {
    _value = newValue;

    notifyListeners();
  }

  set scannedCodeType(String newCodeType) {
    _scannedCodeType = newCodeType;
    notifyListeners();
  }

  
}
