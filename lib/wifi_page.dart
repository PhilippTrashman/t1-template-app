import 'package:flutter/material.dart';
import './wifi_connection/http_service.dart';

class WifiPage extends StatefulWidget {
  const WifiPage({super.key});

  @override
  State<WifiPage> createState() => _WifiPageState();
}

class _WifiPageState extends State<WifiPage> {
  final HttpService httpService = HttpService();

  Widget wifiMessageButton(
      {required String route, required String buttonText}) {
    return ElevatedButton(
      onPressed: () {
        httpService.post(route);
      },
      child: Text(
        buttonText,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wifi Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            wifiMessageButton(route: 'hello', buttonText: 'Send Hello'),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
