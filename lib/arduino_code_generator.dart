// arduino_code_generator.dart
import 'package:flutter/material.dart';
import 'sensors.dart';

String generateArduinoCode(Map<String, SensorItem> sensorPositions,
    Map<String, String> sensorActions) {
  String code = '';
  sensorPositions.forEach((portName, sensor) {
    String action = sensorActions[portName] ?? 'No action defined';
    code += '// ${sensor.name} on $portName\n';
    code += '// Action: $action\n';
    code += 'void setup() {\n  // Setup for ${sensor.name} on $portName\n}\n\n';
    code += 'void loop() {\n  // Action for ${sensor.name}: $action\n}\n\n';
  });
  return code;
}

// Widget for the Generate Code button
class GenerateCodeButton extends StatelessWidget {
  final Map<String, SensorItem> sensorPositions;
  final Map<String, String> sensorActions;

  const GenerateCodeButton({
    Key? key,
    required this.sensorPositions,
    required this.sensorActions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          String code = generateArduinoCode(sensorPositions, sensorActions);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Generated Code'),
                content: SingleChildScrollView(child: Text(code)),
                actions: [
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              const Color(0xFFE2F14F), // Lime color from brand book
          foregroundColor:
              const Color(0xFF121618), // Dark gray text color from brand book
          padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 16), // Padding for the button
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8.0), // Rounded corners for the button
          ),
        ),
        child: const Text('Generate Code'),
      ),
    );
  }
}
