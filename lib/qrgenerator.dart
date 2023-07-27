//import 'dart:html';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

class qrGen extends StatefulWidget {
  const qrGen({super.key});

  @override
  State<qrGen> createState() => _qrGenState();
}

class _qrGenState extends State<qrGen> {
  String text = "Hello";
  QrImageView _result = QrImageView(data: "Hello");

  void updateimage() {
    setState(() {
      _result = QrImageView(data: text);
    });
  }

  final TextEditingController datacontroller = TextEditingController();

  String? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("QR Generator"),
          backgroundColor: Colors.amber,
        ),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text("Enter Data "),

          TextField(
            controller: datacontroller,
            onChanged: (value) {
              text = value;
              //print(text);
            },
          ),

          // Render an empty SizedBox if result is empty
          Card(
            elevation: 10,
            child: _result,
          ),
          Card(
            elevation: 10,
            child: Text(text, maxLines: 2),
          ),
          ElevatedButton(
            onPressed: () {
              updateimage();
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber)),
            child: const Text(
              "Generate QR",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ]));
  }
}
