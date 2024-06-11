import 'package:flutter/material.dart';
import 'package:t1_template/widget/steering_wheel.dart';
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

  Future<void> sendMessage(int message) async {
    await httpService.post('steering?angle=$message');
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
            Expanded(child: SteeringWheel(sendMessage: sendMessage)),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
