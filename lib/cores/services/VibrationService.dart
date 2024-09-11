import 'package:flutter/services.dart';
import 'package:qr_scanner/cores/utils.dart';

class VibrationService {
  static Future<void> induceVibration(int duration) async {
    try {
      await HapticFeedback.mediumImpact();
    } catch (e) {
      LogDetails.Logging("Vibration error " + e.toString());
    }
  }
}
