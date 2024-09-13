import 'package:qr_scanner/cores/utils.dart';
import 'package:qr_scanner/features/model/ScannerCode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_scanner/shared/Constants.dart';

class FirebaseDB {
  final CollectionReference history =
      FirebaseFirestore.instance.collection(HISTORY);

  Future<void> saveHistory(ScannerCode model) async {
    try {
      await history.add(model.toJson());
    } catch (e) {
      LogDetails.Logging(e.toString());
      rethrow;
    }
  }

  Future<List<ScannerCode>> fetchHistory() async {
    try {
      final querySnapshot =
          await history.orderBy("scannedTime", descending: true).get();
      List<ScannerCode> result = [];

      for (final doc in querySnapshot.docs) {
        final map = doc.data() as Map<String, dynamic>;
        Timestamp timeStamp = map['scannedTime'];
        final dateTimeValueFromTimeStamp = timeStamp.toDate();
        
        final model = ScannerCode(
          url: map['url'],
          scannedTime: dateTimeValueFromTimeStamp,
          scannedCodeType: map['scannedCodeType'],
        );

        result.add(model);
      }
      return result;
    } catch (e) {
      LogDetails.Logging(e.toString());
      rethrow;
    }
  }
}
