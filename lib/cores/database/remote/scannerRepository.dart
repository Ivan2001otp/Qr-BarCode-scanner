import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:qr_scanner/cores/database/remote/firebaseDB.dart';
import 'package:qr_scanner/cores/enum/enums.dart';
import 'package:qr_scanner/cores/utils.dart';
import 'package:qr_scanner/features/model/ScannerCode.dart';
import 'package:qr_scanner/shared/Constants.dart';

class ScannerRepository {
  FirebaseDB firebaseDB = FirebaseDB();

  Future<List<ScannerCode>> fetchAllScanHistory() async {
    EasyLoading.show(status: "Fetching...");
    try {
      List<ScannerCode> finalResult = await firebaseDB.fetchHistory();
      EasyLoading.showSuccess("Success!");
      return finalResult;
    } catch (e) {
      EasyLoading.showError("Could not fetch !");
      return [];
    }
  }

  Future<bool> saveQrHistory(
      String url, DateTime time, ScanType codeType) async {
    ScannerCode model = ScannerCode(
      url: url,
      scannedTime: time,
      scannedCodeType: codeType == ScanType.barcode ? BARCODE : QRCODE,
    );

    try {
      await firebaseDB.saveHistory(model);
      return true;
    } catch (e) {
      return false;
    }
  }
}
