import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/shared/widgets/QRCode.dart';

class GenerateQRcodePage extends StatefulWidget {
  const GenerateQRcodePage({super.key});

  @override
  State<GenerateQRcodePage> createState() => _GenerateQRcodePageState();
}

class _GenerateQRcodePageState extends State<GenerateQRcodePage> {
  String generateTimeDependentUrl() {
    return "URL${DateTime.now()}";
  }

  String code = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    // });
  }

  @override
  Widget build(BuildContext context) {
      code = generateTimeDependentUrl();

    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'QR-Generation',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.center,
            child: QRCode(
              qrData: code,
              qrSize: 300,
              qrPadding: 16,
              qrBackgroundColor: Colors.black,
              qrForegroundColor: Colors.amber[50],
              qrBorderRadius: 8,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            code,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Back',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
