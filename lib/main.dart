import 'package:flutter/material.dart';
import 'package:qrscangen/qrgenerator.dart';
import 'package:qrscangen/scanner.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("QR Scan & Gen"),
      ),
      body: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Card(
            child: Column(children: [
              IconButton(
                  iconSize: 100,
                  icon: const Icon(Icons.qr_code_scanner_rounded),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Scann()));
                  }),
              const Text("Scan QR")
            ]),
          ),
          Card(
            child: Column(children: [
              IconButton(
                  iconSize: 100,
                  icon: const Icon(Icons.qr_code_2),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const qrGen()));
                  }),
              const Text("Generate QR")
            ]),
          )
        ]),
      ]),
      drawer: AboutDialog(
        applicationIcon:
            Image.asset('asset/images/logo.png', width: 100, height: 100),
        applicationName: "QR Scan & Gen",
        applicationVersion: "1.0.0",
      ),
    );
  }
}
