import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/cores/utils.dart';
import 'package:qr_scanner/features/provider/ScannedCodeProvider.dart';
import 'package:qr_scanner/features/views/DynamicQrGeneratePage.dart';
import 'package:qr_scanner/features/views/ScanHistoryPage.dart';
import 'package:qr_scanner/features/views/ScanQrPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ValueNotifier<String> scannedResultCode = ValueNotifier("");
  PermissionUtils permissionUtils = PermissionUtils();
  late ScannedCodeProvider scannedCodeProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scannedCodeProvider =
          Provider.of<ScannedCodeProvider>(context, listen: false);
    });
    permissionUtils.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    // scannedCodeProvider =
    //     Provider.of<ScannedCodeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Scanner",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Consumer<ScannedCodeProvider>(
          builder: (context, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Scan Result',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ScanQrPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Scan Qr/Bar Code',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const GenerateQRcodePage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Dynamic QR',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const ScanHistoryPage()),
                    );
                  },
                  child: const Text(
                    'Scan History',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
