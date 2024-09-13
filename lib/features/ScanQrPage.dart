import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/cores/services/VibrationService.dart';
import 'package:qr_scanner/cores/utils.dart';
import 'package:rxdart/rxdart.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  late MobileScannerController _cameraController;
  bool scanned = false;
  final _debounceSubject = BehaviorSubject<Barcode>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _cameraController = MobileScannerController();
    _debounceSubject
        .debounceTime(const Duration(seconds: 5))
        .listen((event) async {
      LogDetails.Logging(event.rawValue ?? "****nothing****");
      LogDetails.Logging(GenerateTimeDependentUrl());
      ToastUtils.showToast("Qr scanned successfully");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12),),),
          backgroundColor: Colors.green,
          content: Text('QR scanned successfully!'),
          duration: Duration(seconds: 3),
        ),
      );
      await VibrationService.induceVibration();
      scanned = true;
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _debounceSubject.close();
    super.dispose();
  }

  String GenerateTimeDependentUrl() {
    return "URL${DateTime.now()}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 150, 106, 227),
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
                        color: Colors.black87,
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
          IconButton(
              color: Colors.red,
              iconSize: 32,
              onPressed: () {
                // _cameraController.switchCamera();
              },
              icon: ValueListenableBuilder<CameraFacing>(
                valueListenable: _cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state) {
                    case CameraFacing.back:
                      LogDetails.Logging("Facing camera back!");
                      return const Icon(
                        Icons.camera_rear,
                        color: Colors.black87,
                      );

                    case CameraFacing.front:
                      LogDetails.Logging("Facing camera front!");
                      return const Icon(
                        Icons.camera_front,
                        color: Colors.black87,
                      );
                  }
                },
              ))
        ],
      ),
      body: SafeArea(
        child: MobileScanner(
          allowDuplicates: true,
          controller: _cameraController,
          onDetect: _captureCode,
        ),
      ),
    );
  }

  void _captureCode(Barcode code, MobileScannerArguments? args) async {
    LogDetails.Logging("Captured!");

    if (!scanned) {
      _debounceSubject.add(code);

      // scanned = true;
    }
  }
}
