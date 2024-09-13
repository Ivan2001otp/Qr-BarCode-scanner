class ScannerCode {
  final String url;
  final DateTime scannedTime;
  final String scannedCodeType;

  ScannerCode({
    required this.url,
    required this.scannedTime,
    required this.scannedCodeType,
  });

  static ScannerCode fromSnapshot(Map<String, dynamic> map) {
    return ScannerCode(
      url: map['url'],
      scannedTime: map['scannedTime'],
      scannedCodeType: map['scannedCodeType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      "scannedTime": scannedTime,
      "scannedCodeType": scannedCodeType
    };
  }
}
