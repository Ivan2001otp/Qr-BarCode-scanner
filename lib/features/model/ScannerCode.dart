class ScannerCode {
  final String url;
  final DateTime scannedTime;
  final String scannedCodeType;

  ScannerCode({
    required this.url,
    required this.scannedTime,
    required this.scannedCodeType,
  });

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      "scannedTime": scannedTime,
      "scannedCodeType": scannedCodeType
    };
  }

  
}
