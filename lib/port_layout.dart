import 'package:flutter/material.dart';
import 'portPositions.dart';
import 'sensors.dart';

class PortLayout extends StatelessWidget {
  final Map<String, SensorItem> sensorPositions;
  final Map<String, String> sensorActions;
  final List<String> highlightedPorts;
  final List<PortPosition> portPositions; // Pass port positions here
  final Function onSensorAccepted;
  final Function onRightClick;
  final Function(String, SensorItem) onEditSensor;

  const PortLayout({
    Key? key,
    required this.sensorPositions,
    required this.sensorActions,
    required this.highlightedPorts,
    required this.portPositions, // Pass the port positions to the widget
    required this.onSensorAccepted,
    required this.onRightClick,
    required this.onEditSensor, // Handle sensor edit (icon click)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double pcbWidth = 3014.0;
        const double pcbHeight = 1095.0;
        const double borderPadding = 36.0;

        final double effectiveWidth =
            constraints.maxWidth - (borderPadding * 2);
        final double effectiveHeight = effectiveWidth / (pcbWidth / pcbHeight);
        final double scale = effectiveWidth / pcbWidth;
        final double defaultPortSize = 300 * scale;

        return Center(
          child: Container(
            padding: const EdgeInsets.all(borderPadding),
            child: SizedBox(
              width: effectiveWidth,
              height: effectiveHeight,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/pcb_image.png',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  // Add drag targets for all ports
                  ...portPositions.map((port) {
                    final bool isHighlighted =
                        highlightedPorts.contains(port.name);
                    final sensor = sensorPositions[port.name];
                    final bool isConfigured =
                        sensorActions.containsKey(port.name);

                    // Determine the port size dynamically based on occupancy
                    final double currentPortWidth =
                        (port.name == 'Special Port 1')
                            ? 300.0 * scale // Constant width for Special Port 1
                            : (sensor != null)
                                ? defaultPortSize * sensor.occupiedWidth
                                : defaultPortSize;

                    final double currentPortHeight = (port.name ==
                            'Special Port 1')
                        ? 800.0 * scale // Constant height for Special Port 1
                        : (sensor != null)
                            ? defaultPortSize * sensor.occupiedHeight
                            : defaultPortSize;

                    return Positioned(
                      left: port.xPos * effectiveWidth,
                      top: port.yPos * effectiveHeight,
                      child: SizedBox(
                        width: currentPortWidth,
                        height: currentPortHeight,
                        child: GestureDetector(
                          onSecondaryTapDown: (details) {
                            if (sensorPositions.containsKey(port.name)) {
                              onRightClick(port.name, details);
                            }
                          },
                          child: DragTarget<SensorItem>(
                            onAccept: (sensor) {
                              onSensorAccepted(sensor, port.name);
                            },
                            onWillAccept: (sensor) =>
                                sensor != null &&
                                sensor.allowedPorts.contains(port.name),
                            builder: (context, candidateData, rejectedData) {
                              final bool isOccupied =
                                  sensorPositions.containsKey(port.name);

                              // Check if the sensor is AXM0023 or AXM0024
                              final bool isSpecificSensor = (sensor != null &&
                                  (sensor.secondSubtitle == 'AXM0023' ||
                                      sensor.secondSubtitle == 'AXM0024'));

                              return Stack(
                                children: [
                                  // Port area with or without sensor
                                  Container(
                                    decoration: BoxDecoration(
                                      color: isOccupied && isSpecificSensor
                                          ? const Color(0xFF7a7c7c)
                                          : (isHighlighted
                                              ? const Color(0xFFe2f14f)
                                                  .withOpacity(0.5)
                                              : Colors.transparent),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: const Color.fromARGB(
                                            0, 225, 241, 79),
                                      ),
                                    ),
                                    child: Center(
                                      child: isOccupied
                                          ? Image.asset(
                                              sensor!.imagePath,
                                              fit: BoxFit.contain,
                                            )
                                          : const SizedBox
                                              .shrink(), // No sensor present
                                    ),
                                  ),
                                  // Display warning icon if sensor is not configured
                                  if (!isConfigured && sensor != null)
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          onEditSensor(port.name, sensor);
                                        },
                                        child: Icon(
                                          Icons.warning_amber_rounded,
                                          color: Colors.red,
                                          size: 120.0 *
                                              scale, // Scale the icon size
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
