import 'package:flutter/material.dart';

class SteeringWheel extends StatefulWidget {
  const SteeringWheel(
      {super.key,
      required this.sendMessage,
      this.steeringWheelPicture = 'assets/images/steering_wheel.png'});

  final Function sendMessage;
  final String steeringWheelPicture;

  @override
  State<SteeringWheel> createState() => _SteeringWheelState();
}

class _SteeringWheelState extends State<SteeringWheel> {
  double rotation = 0.0;
  int? lastSentStep;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    double newRotation = rotation + details.delta.dx / 100;
                    if (newRotation < -0.75) {
                      newRotation = -0.75;
                    } else if (newRotation > 0.75) {
                      newRotation = 0.75;
                    }
                    rotation = newRotation;

                    // Map the rotation to the range -100 to 100

                    int mappedRotation = (rotation * 133.33).round();

                    // Calculate the current step
                    int currentStep = (mappedRotation / 10).round() * 10;

                    // If the current step is at least 10 steps away from the last sent step, send a new message
                    if ((lastSentStep == null) ||
                        (currentStep - lastSentStep!).abs() >= 10) {
                      lastSentStep = currentStep;
                      widget.sendMessage(currentStep);
                      debugPrint('Sending message: $currentStep');
                    }
                  });
                },
              ),
            ),
          ],
        ),
        IgnorePointer(
          child: Center(
            child: Transform.rotate(
              angle: rotation,
              child: Image.asset(
                widget.steeringWheelPicture,
                fit: BoxFit.contain,
              ),
            ),
          ),
        )
      ],
    );
  }
}
