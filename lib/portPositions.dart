// port_positions.dart
class PortPosition {
  final String name;
  final double xPos;
  final double yPos;

  PortPosition(this.name, this.xPos, this.yPos);
}

// List of all port positions
List<PortPosition> getPortPositions(double pcbWidth, double pcbHeight) {
  return [
    PortPosition('Port 1', 890 / pcbWidth, 30 / pcbHeight),
    PortPosition('Port 2', 1201 / pcbWidth, 30 / pcbHeight),
    PortPosition('Port 3', 1512 / pcbWidth, 30 / pcbHeight),
    PortPosition('Port 4', 1823 / pcbWidth, 30 / pcbHeight),
    PortPosition('Port 5', 890 / pcbWidth, 774 / pcbHeight),
    PortPosition('Port 6', 1201 / pcbWidth, 774 / pcbHeight),
    PortPosition('Port 7', 1512 / pcbWidth, 774 / pcbHeight),
    PortPosition('Port 8', 1823 / pcbWidth, 774 / pcbHeight),
    PortPosition('Special Port 1', 2615 / pcbWidth, 60 / pcbHeight),
  ];
}
