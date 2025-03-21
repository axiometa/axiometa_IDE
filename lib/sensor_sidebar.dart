// sensor_sidebar.dart
import 'package:flutter/material.dart';
import 'sensors.dart';

class SensorSidebar extends StatelessWidget {
  final Function onDragStarted;
  final Function onDragEnd;

  const SensorSidebar({
    Key? key,
    required this.onDragStarted,
    required this.onDragEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Add BoxDecoration with a left border
      decoration: BoxDecoration(
        color: const Color(0xff3ececec), // Background color
        border: Border(
          left: BorderSide(
            color: const Color(0xff3A3C3D), // Color of the thin line
            width: 1.5, // Thickness of the thin line
          ),
        ),
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Sensors',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w400,
              color: Color(0xFF121618),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: getSensors().map((sensor) {
                return Draggable<SensorItem>(
                  data: sensor,
                  onDragStarted: () => onDragStarted(sensor),
                  onDragEnd: (_) => onDragEnd(),
                  feedback: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 236, 236, 236),
                        border: Border.all(color: const Color(0xFF3A3C3D)),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(sensor.imagePath, width: 60, height: 60),
                          const SizedBox(height: 4),
                          Text(sensor.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading:
                        Image.asset(sensor.imagePath, width: 40, height: 40),
                    title: Text(sensor.name),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
