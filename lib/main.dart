import 'package:flutter/material.dart';
import 'wifi_page.dart';
import 'bluetooth_page.dart';

void main() {
  runApp(const MainApp());
}

/*
This is the Main Page, Two Examples are Provided
One for Wifi Connection and One for Bluetooth Connection
As Explained in the README, the Bluetooth Page will only work on Android and wont work on other Platforms
at worst even crash on them

This App is only a simple example of what you can do with Flutter and Bluetooth/Wifi
for more advanced features like a settings page or persisting data between uses refer to the Flutter Documentation
here a handy tutorial for learning the basics of Flutter: https://flutter.dev/docs/get-started/codelab
*/

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    final ThemeData darkTheme = ThemeData(
      primarySwatch: Colors.indigo,
      brightness: Brightness
          .dark, // change this value if you want to implement light theme
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: const WifiPage(),
      // home: const BluetoothPage(),
    );
  }
}
