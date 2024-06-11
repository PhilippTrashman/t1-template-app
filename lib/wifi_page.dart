import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:t1_template/widget/steering_wheel.dart';
import './wifi_connection/http_service.dart';
import './widget/joystick.dart';

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

  Future<void> sendSteeringMessage(int message) async {
    await httpService.post('steering?angle=$message');
  }

  Future<void> sendJoystickMessage(int x, int y) async {
    await httpService.post('joystick?x=$x&y=$y');
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
            Expanded(
                child: Row(
              children: [
                Expanded(
                    child: SteeringWheel(sendMessage: sendSteeringMessage)),
                Expanded(
                  child: JoystickWidget(sendMessage: sendJoystickMessage),
                )
              ],
            )),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
