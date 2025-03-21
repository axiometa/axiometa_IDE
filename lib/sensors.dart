// sensors.dart
import 'package:flutter/material.dart';

class SensorItem {
  final String name;
  final String imagePath;
  final String subtitle;
  final String secondSubtitle;
  final String? metadata;
  final List<String> allowedPorts;
  final int occupiedWidth; // New field
  final int occupiedHeight; // New field
  final String? link; // New field for the link

  const SensorItem({
    required this.name,
    required this.imagePath,
    required this.subtitle,
    required this.secondSubtitle,
    this.metadata,
    required this.allowedPorts,
    this.occupiedWidth = 1, // Default is 1 port wide
    this.occupiedHeight = 1, // Default is 1 port tall
    this.link, // Optional field for sensor details link
  });
}

// Widget for displaying draggable sensors
class DraggableSensor extends StatelessWidget {
  final SensorItem sensor;

  const DraggableSensor({Key? key, required this.sensor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable<SensorItem>(
      data: sensor,
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
            children: [
              Image.asset(sensor.imagePath, width: 40, height: 40),
              const SizedBox(height: 4),
              Text(sensor.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(sensor.subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(sensor.secondSubtitle,
                  style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ),
      ),
      childWhenDragging: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Image.asset(sensor.imagePath, width: 40, height: 40),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE2F14F)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Image.asset(sensor.imagePath, width: 40, height: 40),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sensor.name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(sensor.subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text(sensor.secondSubtitle,
                    style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<SensorItem> getSensors() {
  return const [
    SensorItem(
        name: 'Rotary Encoder',
        subtitle: 'Position Sensor',
        secondSubtitle: 'AXM0003',
        imagePath: 'assets/sensor_icons/AXM0003.png',
        metadata: 'Steps: 20, Voltage: 3.3V-5V',
        allowedPorts: [
          'Port 1',
          'Port 2',
          'Port 3',
          'Port 4',
          'Port 5',
          'Port 6',
          'Port 7',
          'Port 8',
        ],
        link: 'https://axiometa.ai/'),
    SensorItem(
      name: 'Potentiometer',
      subtitle: 'Analog Sensor',
      secondSubtitle: 'AXM0004',
      imagePath: 'assets/sensor_icons/AXM0004.png',
      metadata: 'Resistance: 10K ohms, Voltage: 3.3V-5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'LDR',
      subtitle: 'Light Sensor',
      secondSubtitle: 'AXM0005',
      imagePath: 'assets/sensor_icons/AXM0005.png',
      metadata: 'Sensitivity: Adjustable, Voltage: 3.3V-5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'LED RGB',
      subtitle: 'RGB LED',
      secondSubtitle: 'AXM0006',
      imagePath: 'assets/sensor_icons/AXM0006.png',
      metadata: 'Colors: Red, Green, Blue, Voltage: 3.3V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'Push Button',
      subtitle: 'Button Input',
      secondSubtitle: 'AXM0007',
      imagePath: 'assets/sensor_icons/AXM0007.png',
      metadata: 'Actuation Force: 180gf, Voltage: 3.3V-5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'Push Button',
      subtitle: 'Button Input',
      secondSubtitle: 'AXM0008',
      imagePath: 'assets/sensor_icons/AXM0008.png',
      metadata: 'Type: SPST, Voltage: 3.3V-5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'MEMS Microphone',
      subtitle: 'Audio Input',
      secondSubtitle: 'AXM0009',
      imagePath: 'assets/sensor_icons/AXM0009.png',
      metadata: 'Sensitivity: -42dB, Voltage: 3.3V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'I2C Display',
      subtitle: 'Visual Output',
      secondSubtitle: 'LCD/AXM0010',
      imagePath: 'assets/sensor_icons/AXM0010.png',
      metadata: 'Size: 128x64, Interface: I2C',
      allowedPorts: ['I2C 1', 'I2C 2', 'I2C 3'],
    ),
    SensorItem(
      name: 'Temp & Humidity',
      subtitle: 'DHT11 Sensor',
      secondSubtitle: 'AXM0011',
      imagePath: 'assets/sensor_icons/AXM0011.png',
      metadata: 'Range: -40°C to 125°C, Voltage: 3.3V-5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'Active Buzzer',
      subtitle: 'Audio Output',
      secondSubtitle: 'AXM0012',
      imagePath: 'assets/sensor_icons/AXM0012.png',
      metadata: 'Type: Active Buzzer, Voltage: 3.3V-5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'Vibration',
      subtitle: 'Haptic Feedback',
      secondSubtitle: 'AXM0013',
      imagePath: 'assets/sensor_icons/AXM0013.png',
      metadata: 'Voltage: 3.3V-5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: '3A Relay',
      subtitle: 'Switching Device',
      secondSubtitle: 'AXM0014',
      imagePath: 'assets/sensor_icons/AXM0014.png',
      metadata: 'Current: 3A, Voltage: 5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'ToF VL53L0CX',
      subtitle: 'Distance Sensor',
      secondSubtitle: 'AXM0015',
      imagePath: 'assets/sensor_icons/AXM0015.png',
      metadata: 'Range: Up to 2m, Voltage: 3.3V',
      allowedPorts: ['I2C 1', 'I2C 2', 'I2C 3'],
    ),
    SensorItem(
      name: 'D-Pad',
      subtitle: 'Direction Input',
      secondSubtitle: 'AXM0016',
      imagePath: 'assets/sensor_icons/AXM0016.png',
      metadata: 'Pins: 5, Voltage: 3.3V-5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'Two-Pad',
      subtitle: 'Input Module',
      secondSubtitle: 'AXM0017',
      imagePath: 'assets/sensor_icons/AXM0017.png',
      metadata: 'Pins: 2, Voltage: 3.3V-5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'JST Breakout',
      subtitle: 'STEMMA QT Connector',
      secondSubtitle: 'AXM0019',
      imagePath: 'assets/sensor_icons/AXM0019.png',
      metadata: 'Connector Type: JST, Voltage: 3.3V-5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'Sliding Potentiometer',
      subtitle: 'Analog Sensor',
      secondSubtitle: 'AXM0020',
      imagePath: 'assets/sensor_icons/AXM0020.png',
      metadata: 'Resistance: 10K ohms, Voltage: 3.3V-5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
      occupiedWidth: 1, // This sensor is 2 ports wide
      occupiedHeight: 2, // This sensor is 1 port tall
    ),
    SensorItem(
      name: 'LED Button',
      subtitle: 'Button with LED',
      secondSubtitle: 'AXM0021',
      imagePath: 'assets/sensor_icons/AXM0021.png',
      metadata: 'Pins: 4, Voltage: 3.3V-5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'Toggle Switch',
      subtitle: 'Switch Input',
      secondSubtitle: 'AXM0022',
      imagePath: 'assets/sensor_icons/AXM0022.png',
      metadata: 'Pins: 2, Voltage: 3.3V-5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'Street Light',
      subtitle: 'Output Indicator',
      secondSubtitle: 'AXM0023',
      imagePath: 'assets/sensor_icons/AXM0023.png',
      metadata: 'LEDs: 3 (Red, Yellow, Green), Voltage: 5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'Traffic Light',
      subtitle: 'Output Indicator',
      secondSubtitle: 'AXM0024',
      imagePath: 'assets/sensor_icons/AXM0024.png',
      metadata: 'LEDs: 3, Voltage: 5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'Vibration Switch',
      subtitle: 'Vibration Sensor',
      secondSubtitle: 'AXM0025',
      imagePath: 'assets/sensor_icons/AXM0025.png',
      metadata: 'Voltage: 3.3V-5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'NeoPixel Matrix',
      subtitle: 'NeoPixel Matrix',
      secondSubtitle: 'AXM0027',
      imagePath: 'assets/sensor_icons/AXM0027.png',
      metadata: 'Voltage: 3.3V-5V',
      allowedPorts: [
        'Port 1',
        'Port 2',
        'Port 3',
        'Port 4',
        'Port 5',
        'Port 6',
        'Port 7',
        'Port 8',
      ],
    ),
    SensorItem(
      name: 'Axiometa Core 1',
      subtitle: '32-Bit Microcontroller',
      secondSubtitle: 'MTA0003',
      imagePath: 'assets/sensor_icons/MTA0003.png',
      metadata: 'Voltage: 3.3V-5V',
      allowedPorts: ['Special Port 1'],
    ),
  ];
}
