import 'package:flutter/material.dart';
import './wifi_connection/http_service.dart';
import 'bluetooth_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BluetoothPage(),
    );
  }

  Widget wifiMessageButton({required String url, required String buttonText}) {
    return ElevatedButton(
      onPressed: () {
        httpService.post(url);
      },
      child: Text(buttonText),
    );
  }
}
