import 'package:flutter/services.dart';
import 'package:qr_scanner/cores/utils.dart';

class VibrationService {
  static Future<void> induceVibration() async {
    try {
      await HapticFeedback.selectionClick();
    } catch (e) {
      LogDetails.Logging("Vibration error " + e.toString());
    }
  }
}
