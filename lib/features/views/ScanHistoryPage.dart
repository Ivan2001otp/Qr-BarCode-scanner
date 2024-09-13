import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner/cores/database/remote/scannerRepository.dart';
import 'package:qr_scanner/cores/utils.dart';

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
        title: Text('Scan History'),
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
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    if (data.isEmpty) {
                      return Center(
                        child: Text(
                          "No Scans History!",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      );
                    }

                    String scanTime =
                        DateTimeUtils.dateTimeToString(data[index].scannedTime);

                    return ListTile(
                      
                      title: Text("Url : ${data[index].url}"),
                      leading: ,
                      subtitle: Column(
                        children: [
                          Text("CodeType : ${data[index].scannedCodeType}"),
                          const SizedBox(height: 4,),
                          Text(scanTime),
                        ],
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
