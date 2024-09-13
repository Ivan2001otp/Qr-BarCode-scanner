import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/cores/utils.dart';
import 'package:qr_scanner/features/ScanQrPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<String> scannedResultCode = ValueNotifier("");
  PermissionUtils permissionUtils = PermissionUtils();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permissionUtils.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(
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
            ValueListenableBuilder(
              valueListenable: scannedResultCode,
              builder: ((context, value, child) {
                return Text(
                  value,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }),
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
                'Scan QR',
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
              onPressed: () {},
              child: const Text(
                'Scan BarCode',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
