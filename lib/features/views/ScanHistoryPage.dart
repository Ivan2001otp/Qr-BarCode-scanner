import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/cores/database/remote/scannerRepository.dart';
import 'package:qr_scanner/cores/utils.dart';
import 'package:qr_scanner/shared/Constants.dart';
import 'package:qr_scanner/shared/widgets/QRCode.dart';

class ScanHistoryPage extends StatefulWidget {
  const ScanHistoryPage({super.key});

  @override
  State<ScanHistoryPage> createState() => _ScanHistoryPageState();
}

class _ScanHistoryPageState extends State<ScanHistoryPage> {
  late ScannerRepository repository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    repository = ScannerRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scan History',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Expanded(
        child: Padding(
          padding: EdgeInsets.all(2),
          child: FutureBuilder(
            future: repository.fetchAllScanHistory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                );
              } else if (snapshot.hasError) {
                LogDetails.Logging(snapshot.error.toString());
                return const Center(
                  child: Text("Something went wrong,see the logs."),
                );
              }
              final data = snapshot.data ?? [];
              return ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 2,
                      indent: 4,
                      endIndent: 4,
                    );
                  },
                  itemBuilder: (context, index) {
                    if (data.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Scans History!",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      );
                    }

                    String scanTime =
                        DateTimeUtils.dateTimeToString(data[index].scannedTime);

                    return ListTile(
                      title: Text(
                        "Url : ${data[index].url}",
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: data[index].scannedCodeType == QRCODE
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/qr_code_img.png",
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.fill,
                                ),
                                const Text(
                                  'QR-Code',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.blueGrey),
                                )
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/bar_code_img.png",
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.fill,
                                ),
                                const Text(
                                  'Bar-Code',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.blueGrey),
                                )
                              ],
                            ),
                      subtitle: Text(
                        scanTime,
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w800),
                      ),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
