import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/cores/services/VibrationService.dart';
import 'package:qr_scanner/cores/utils.dart';
import 'package:qr_scanner/features/provider/ScannedCodeProvider.dart';
import 'package:qr_scanner/shared/Constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  late MobileScannerController _cameraController;
  bool scanned = false;
  late ScannedCodeProvider scannedCodeProvider;

  final _debounceSubject = BehaviorSubject<Barcode>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _cameraController = MobileScannerController();
    _debounceSubject
        .debounceTime(const Duration(milliseconds: 500))
        .listen((event) async {
      String codeValue = event.rawValue ?? NOTHING;
      scannedCodeProvider.value = codeValue;

      if (event.format == BarcodeFormat.qrCode) {
        scannedCodeProvider.scannedCodeType = QRCODE;
      } else {
        scannedCodeProvider.scannedCodeType = BARCODE;
      }

      debugPrint(scannedCodeProvider.value);

      LogDetails.Logging(event.rawValue ?? "****nothing****");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          backgroundColor: Colors.green,
          content: Text(
            'QR scanned successfully!',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          duration: Duration(seconds: 3),
        ),
      );
      await VibrationService.induceVibration();
      scanned = true;

      

      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _debounceSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scannedCodeProvider =
        Provider.of<ScannedCodeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 185, 154, 238),
        actions: [
          IconButton(
            color: Colors.red,
            iconSize: 32,
            onPressed: () {
              _cameraController.toggleTorch();
            },
            icon: ValueListenableBuilder<TorchState>(
                valueListenable: _cameraController.torchState,
                builder: (context, state, child) {
                  switch (state) {
                    case TorchState.off:
                      LogDetails.Logging("Turning off torch!");
                      return const Icon(
                        Icons.flash_off,
                        color: Colors.white,
                      );

                    case TorchState.on:
                      LogDetails.Logging("Turning on torch!");
                      return const Icon(
                        Icons.flash_on_outlined,
                        color: Colors.orange,
                      );
                  }
                }),
          ),
          const SizedBox( 
            width: 30,
          ),
        ],
      ),
      body: SafeArea(
        child: MobileScanner(
          allowDuplicates: false,
          controller: _cameraController,
          onDetect: _captureCode,
        ),
      ),
    );
  }

  void _captureCode(Barcode code, MobileScannerArguments? args) async {
    if (!scanned) {
      LogDetails.Logging("Captured!");

      _debounceSubject.add(code);
    }
  }
}