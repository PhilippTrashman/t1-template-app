import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class JoystickWidget extends StatefulWidget {
  const JoystickWidget({
    super.key,
    required this.sendMessage,
  });

  final Function sendMessage;

  @override
  State<JoystickWidget> createState() => _JoystickWidgetState();
}

class _JoystickWidgetState extends State<JoystickWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: const Alignment(0, 0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Joystick(
            listener: (details) {
              int x = (details.x * 100).round();
              int y = (details.y * 100).round();
              debugPrint('Sending message: $x, $y');
              widget.sendMessage(x, y);
            },
          ),
        ),
      ),
    );
  }
}
