import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import './bluetooth_serial/select_bonded_device_page.dart';
import './bluetooth_serial/bluetooth_class.dart';

/*
This Page is Only Available on Android
It will Crash on Chrome and not Work on any other platform
*/

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  BluetoothConnector? bl;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      bl = BluetoothConnector();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            if (Platform.isAndroid)
              ElevatedButton(
                onPressed: () async {
                  await handleConnectRequest();
                },
                child: const Text('Connect to Bluetooth Device'),
              ),
            blMessageButton(
              message: 'Hello from Bluetooth',
              buttonText: 'Send Bluetooth Message',
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void connectToBlDevice() async {
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
          child: Text(
            'Bluetooth is not available on this device',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
            ),
          ),
        ),
      );
    }
    return ElevatedButton(
      onPressed: () {
        if (bl != null) {
          bl!.sendBlMessage(message);
        }
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

  Future handleConnectRequest() async {
    await Permission.bluetoothScan.status.then((value) async {
      debugPrint("-------!${value.isGranted}!-------");
      if (value.isGranted) {
        debugPrint('Bluetooth permission granted');
        connectToBlDevice();
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return requestBluetoothDialog(context);
            });
      }
    });
  }

  AlertDialog requestBluetoothDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Bluetooth Permission'),
      content: const Text(
        'This app requires bluetooth permission to connect to the device, please allow location and nearby devices permission to continue.',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 24,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            await openAppSettings().then((value) async {
              Navigator.of(context).pop();
              await Permission.bluetoothScan.status.then((value) {
                if (value.isGranted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                    'Bluetooth permission granted, please try again.',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 24,
                    ),
                  )));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                    'Bluetooth permission is required to connect to the device.',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 24,
                    ),
                  )));
                }
              });
            });
          },
          child: const Text(
            'Open Settings',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }
}
