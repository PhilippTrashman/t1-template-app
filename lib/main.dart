import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import './wifi_connection/http_service.dart';
import './bluetooth_serial/select_bonded_device_page.dart';
import './bluetooth_serial/bluetooth_class.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  BluetoothConnector? bl;
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      bl = BluetoothConnector();
    }
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            if (Platform.isAndroid)
              ElevatedButton(
                onPressed: () {
                  connectToBlDevice(context);
                },
                child: const Text('Connect to Bluetooth Device'),
              ),
            blMessageButton(
              message: 'Hello from Bluetooth',
              buttonText: 'Send Bluetooth Message',
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                httpService.handleHelloRequest();
              },
              child: const Text('Connect to WiFi Device'),
            ),
            wifiMessageButton(
              url: 'hello',
              buttonText: 'Send WiFi Message',
            ),
            Spacer()
          ],
        ),
      )),
    );
  }

  void connectToBlDevice(BuildContext context) async {
    if (!Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Bluetooth is not available on this device'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
    if (bl != null && !bl!.isConnected && Platform.isAndroid) {
      final BluetoothDevice? device = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return const SelectBondedDevicePage(checkAvailability: false);
          },
        ),
      );

      if (device == null) {
        debugPrint('No device selected');
        return;
      } else {
        bl!.connectToDevice(device);
      }
    }
  }

  Widget blMessageButton(
      {required String message, required String buttonText}) {
    // Bluetooth Connection is only available on Android
    if (!Platform.isAndroid) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Bluetooth is not available on this device'),
        ),
      );
    }
    return ElevatedButton(
      onPressed: () {
        if (bl != null) {
          bl!.sendBlMessage(message);
        }
      },
      child: Text(buttonText),
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
