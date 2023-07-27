import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/services.dart';

class Scann extends StatefulWidget {
  const Scann({super.key});

  @override
  State<Scann> createState() => _ScanState();
}

class _ScanState extends State<Scann> {
  MobileScannerController cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal, detectionTimeoutMs: 1000);
  String scanresult = "not scanned";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('QR Scanner'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.orange);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            fit: BoxFit.fitWidth,
            scanWindow: Rect.largest,
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              // final Uint8List? image = capture.image;
              List<String?> values = List.empty(growable: true);
              for (final barcode in barcodes) {
                values.add(barcode.rawValue);
              }
              scanresult = values.toString();

              _showAlertDialog(context, "Scanned Data", scanresult);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => qrsave(
              //               scannedtext: values.toString(),
              //             )));
              //_showAlertDialog(context, "Scan Complete", values);
            },
          ),
        ],
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            // Add any actions or buttons you want here
            Column(children: [
              TextButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: content)).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Copied to your clipboard !')));
                    });
                  },
                  child: const Text("Copy"))
            ]),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                // Close the dialog
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
