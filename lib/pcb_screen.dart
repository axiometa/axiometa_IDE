import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'menu_bar.dart'; // Import the menu bar
import 'port_layout.dart'; // Import the port layout
import 'sensor_sidebar.dart'; // Import the sensor sidebar
import 'sensors.dart';
import 'portPositions.dart';
import 'tutorial_data.dart'; // Import the tutorial data

class PCBScreen extends StatefulWidget {
  const PCBScreen({Key? key}) : super(key: key);

  @override
  _PCBScreenState createState() => _PCBScreenState();
}

class _PCBScreenState extends State<PCBScreen> {
  Map<String, SensorItem> sensorPositions = {};
  List<String> highlightedPorts = []; // Track allowed ports for highlighting
  TextEditingController _codeController = TextEditingController();
  TextEditingController _goalController =
      TextEditingController(); // Controller for global goal
  Map<String, String> sensorActions = {}; // Ensure this is defined
  String? _selectedPort; // Variable to hold the selected COM port
  List<String> _comPorts = []; // List of available COM ports

  // Handle sensor drag start
  void _onSensorDragStarted(SensorItem sensor) {
    setState(() {
      highlightedPorts = sensor.allowedPorts; // Highlight allowed ports
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // You can handle the error here, such as showing a Snackbar
      throw 'Could not launch $url';
    }
  }

  // Handle sensor drag end
  void _onSensorDragEnded() {
    setState(() {
      highlightedPorts = []; // Clear highlighted ports
    });
  }

  // Handle sensor acceptance and placement
  void _onSensorAccepted(SensorItem sensor, String portName) {
    if (sensor.allowedPorts.contains(portName)) {
      setState(() {
        sensorPositions[portName] = sensor;
      });
    }
  }

  // New method to clear all sensor positions
  void clearAllSensorPositions() {
    setState(() {
      sensorPositions.clear();
      _codeController.clear();
      sensorActions.clear(); // Clear all occupied ports
    });
  }

  // New method to clear sensor position
  void clearSensorPosition(String portName) {
    sensorPositions.remove(portName); // Remove only the specific port
    sensorActions.remove(portName); // Reset the configuration
  }

  Widget buildTutorialBox({
    required String title,
    required String description,
    required String imagePath,
    required VoidCallback onBoxTap, // Callback for the box tap
    required VoidCallback onStartTap, // Callback for the "Start" button
    required String buyKitUrl, // URL for the "Buy Kit" button
  }) {
    return GestureDetector(
      onTap: onBoxTap, // Handle the box tap
      child: Container(
        width: 300,
        height: 300,
        margin: const EdgeInsets.all(12), // Margin around the container
        decoration: BoxDecoration(
          color: const Color(0xA03a3c3d), // Background color
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Adjust size based on content
          crossAxisAlignment: CrossAxisAlignment.center, // Center-align content
          children: [
            const SizedBox(
                height: 32), // Added space at the top to move content down

            // Image Section
            Padding(
              padding: const EdgeInsets.all(8.0), // Padding around the image
              child: Image.asset(
                imagePath, // Provided image path
                width: 1270 / 14, // Adjust width as needed
                height: 1011 / 14, // Adjust height as needed
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 8), // Space between image and title

            // Title Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  color: Color.fromARGB(255, 255, 255, 255), // Text color
                  fontFamily: 'DMSANS', // Custom font
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 8), // Space between title and description

            // Description Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                description,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color.fromARGB(
                      255, 255, 255, 255), // Description text color
                  fontFamily: 'DMSANS', // Custom font
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(
                height: 24), // Increased space between description and buttons

            // Row for Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the buttons
                children: [
                  // "Start" Button
                  ElevatedButton(
                    onPressed: onStartTap, // "Start" button action
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Oval shape
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical:
                              16), // Reduced vertical padding for smaller size
                      minimumSize:
                          Size.zero, // Makes the button size based on content
                      tapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // Reduces tap target size
                      backgroundColor:
                          const Color(0xFFE2F14F), // Button background color
                      foregroundColor:
                          const Color(0xFF121618), // Button text color
                      textStyle: const TextStyle(
                        fontFamily: 'DMSANS',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    child: const Text('Start'), // Button label
                  ),

                  const SizedBox(width: 16), // Space between buttons

                  // "Buy Kit" Button
                  ElevatedButton(
                    onPressed: () =>
                        _launchURL(buyKitUrl), // "Buy Kit" button action
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Oval shape
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical:
                              16), // Reduced vertical padding for smaller size
                      minimumSize:
                          Size.zero, // Makes the button size based on content
                      tapTargetSize: MaterialTapTargetSize
                          .shrinkWrap, // Reduces tap target size
                      backgroundColor:
                          const Color(0xFFE2F14F), // Button background color
                      foregroundColor:
                          const Color(0xFF121618), // Button text color
                      textStyle: const TextStyle(
                        fontFamily: 'DMSANS',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    child: const Text('View Kit'), // Button label
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8), // Optional: Space below the buttons
          ],
        ),
      ),
    );
  }

// Unified method to configure or edit sensor behavior
  void _configureOrEditSensor(String portName, SensorItem sensor,
      {bool isEditing = false}) {
    // Retrieve the sensor's current configuration if editing
    String? configuration = isEditing ? sensorActions[portName] : null;

    // Create a TextEditingController to manage the input or editing
    TextEditingController configController = TextEditingController(
      text:
          configuration ?? '', // Pre-fill the current configuration if editing
    );

    // Show dialog for configuration or editing
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff3a3c3d), // Brand background color
          title: Text(
            isEditing
                ? 'Edit Configuration for ${sensor.name}'
                : 'Configure ${sensor.name} on $portName',
            style: const TextStyle(
              color: Color.fromARGB(
                  255, 255, 255, 255), // Title text color (brand color)
              fontFamily: 'DMSANS',
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 26.0, vertical: 8.0), // Custom padding
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align content to the start
            children: [
              TextField(
                controller: configController,
                decoration: InputDecoration(
                  labelText: isEditing ? 'Edit action...' : 'Enter action...',
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(
                        255, 255, 255, 255), // Label color (brand color)
                    fontFamily: 'DMSANS',
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(
                          0xFFE2F14F), // Input field border color (brand color)
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(
                          0xFFE2F14F), // Input field border color when focused
                    ),
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white, // Input text color
                ),
              ),
              const SizedBox(height: 16),
              if (sensor.metadata != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Metadata:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Metadata title color
                      ),
                    ),
                    Text(
                      sensor.metadata!,
                      style: const TextStyle(
                        color: Colors.white, // Metadata text color
                      ),
                    ),
                  ],
                ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor:
                    const Color(0xFFE2F14F), // Button text color (brand color)
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'DMSANS', // Custom font
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  sensorActions[portName] =
                      configController.text; // Save the configuration
                });
                Navigator.of(context).pop(); // Close the dialog after saving
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Oval shape
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16, // Reduced vertical padding for smaller size
                ),
                minimumSize:
                    Size.zero, // Makes the button size based on content
                tapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // Reduces tap target size
                backgroundColor:
                    const Color(0xFFE2F14F), // Button background color
                foregroundColor: const Color(0xFF121618), // Button text color
                textStyle: const TextStyle(
                  fontFamily: 'DMSANS',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              child: const Text('Save'), // Button label
            )
          ],
        );
      },
    );
  }

  void _showBuildDialog() {
    TextEditingController buildController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF3A3C3D), // Brand background color
          title: const Text(
            'What would you like to build?',
            style: TextStyle(
              color: Color(0xFFE2F14F), // Title text color (brand color)
              fontFamily: 'DMSANS', // Custom font
            ),
          ),
          content: TextField(
            controller: buildController,
            decoration: InputDecoration(
              hintText: "Enter your project idea",
              hintStyle: const TextStyle(
                color: Colors.grey, // Hint text color
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(
                      0xFFE2F14F), // Input field border color (brand color)
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(
                      0xFFE2F14F), // Input field border when focused (brand color)
                ),
              ),
            ),
            style: const TextStyle(
              color: Colors.white, // Input text color
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _processBuildRequest(buildController.text);
              },
              style: TextButton.styleFrom(
                foregroundColor:
                    const Color(0xFFE2F14F), // Button text color (brand color)
                textStyle: const TextStyle(
                  fontFamily: 'DMSANS', // Custom font
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Generate'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor:
                    const Color(0xFFE2F14F), // Button text color (brand color)
                textStyle: const TextStyle(
                  fontFamily: 'DMSANS', // Custom font
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _processBuildRequest(String input) {
    // Define keywords for different projects
    final Map<String, String> projects = {
      'dice': 'Electronic Dice: Random number generator using LEDs.',
      'game':
          'Space Thrash Game: Develop a game where players shoot obstacles.',
      // Add more keywords and project descriptions as needed
    };

    // Check for keywords in the input
    String projectDescription = 'Project not recognized.';
    projects.forEach((keyword, description) {
      if (input.toLowerCase().contains(keyword)) {
        _loadTutorial('Electronic Dice');
      }
    });

    // Show the result in a SnackBar or dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(projectDescription),
        duration: const Duration(seconds: 2),
      ),
    );
  }

// Handle right-click (secondary tap) in the workspace
  void _onRightClick(String portName, TapDownDetails details) {
    // Get the sensor for the right-clicked port
    SensorItem? sensorToEdit =
        sensorPositions[portName]; // Ensure sensor exists

    if (sensorToEdit == null) {
      // If no sensor is present, you might want to avoid showing the menu
      return; // Or handle it with a message/snackbar if needed
    }

    // Show the context menu
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      color: const Color(
          0xFF3A3C3D), // Background color for the popup menu (brand color)
      items: [
        PopupMenuItem(
          value: 'Details',
          child: Text(
            'Details',
            style: TextStyle(
              color: const Color(
                  0xFFE2F14F), // Text color for Delete option (brand color)
              fontFamily: 'DMSANS', // Custom font
            ),
          ),
        ),
        PopupMenuItem(
          value: 'Edit',
          child: Text(
            'Edit',
            style: TextStyle(
              color: const Color(
                  0xFFE2F14F), // Text color for Edit option (brand color)
              fontFamily: 'DMSANS', // Custom font
            ),
          ),
        ),
        PopupMenuItem(
          value: 'Delete',
          child: Text(
            'Delete',
            style: TextStyle(
              color: const Color(
                  0xFFE2F14F), // Text color for View Details option (brand color)
              fontFamily: 'DMSANS', // Custom font
            ),
          ),
        ),
      ],
    ).then((value) {
      if (value == 'Delete') {
        setState(() {
          clearSensorPosition(portName); // Remove the sensor from the port
        });
      } else if (value == 'Edit') {
        _configureOrEditSensor(portName, sensorToEdit,
            isEditing: true); // Edit the sensor configuration
      } else if (value == 'Details') {
        _openSensorDetails(sensorToEdit); // Open the sensor's details URL
      }
    });
  }

  // Add a map to hold the goals for each tutorial
  final Map<String, String> tutorialGoals = {
    'Electronic Dice':
        'Random number generator using 7 LEDs and one Vibration sensor to make an electronic dice.',
    'Space Thrash Game':
        'Develop a simple game where players shoot incoming obstacles.',
    'LED Light Mixer': 'Adjust light intensity of RGB using 3 potentiometers ',
  };

  void _openSensorDetails(SensorItem sensor) {
    String? url = sensor.link; // Use the link field from the sensor

    if (url != null) {
      launch(url); // Open the URL using the launch function from url_launcher
    } else {
      print("No link available for this sensor.");
    }
  }

  // Generate Arduino code for sensors
  String _generateArduinoCode() {
    String code = '// Arduino code for placed sensors:\n';
    sensorPositions.forEach((portName, sensor) {
      code += '// ${sensor.name} on $portName\n';
      code +=
          'void setup() {\n  // Setup for ${sensor.name} on $portName\n}\n\n';
      code += 'void loop() {\n  // Action for ${sensor.name}\n}\n\n';
    });
    return code;
  }

// Method to load sensors for tutorial and pre-fill configurations
  void _loadTutorial(String tutorial) {
    setState(() {
      sensorPositions.clear(); // Clear existing sensors
      sensorActions.clear(); // Clear existing sensor configurations

      // Populate the sensor positions and configurations based on the selected tutorial
      if (tutorialPorts.containsKey(tutorial)) {
        tutorialPorts[tutorial]!.forEach((port, sensorData) {
          String sensorId = sensorData['sensor']!;
          String action = sensorData['action']!;

          SensorItem sensor = _cloneSensor(getSensorByName(sensorId));
          sensorPositions[port] = sensor;

          // Pre-fill the sensor actions (specific action for each sensor)
          sensorActions[port] = action;
        });
      }

      // Load prewritten code if available for the selected tutorial
      if (tutorialCodes.containsKey(tutorial)) {
        _codeController.text = tutorialCodes[tutorial]!;
      } else {
        _codeController
            .clear(); // Clear code if no prewritten code is available
        _codeController.text =
            _generateArduinoCode(); // Generate Arduino code if no prewritten code
      }
      // Set the goal for the selected tutorial
      _goalController.text = tutorialGoals[tutorial] ?? ''; // Set the goal text
    });

    // Show a SnackBar with the "PROJECT LOADED" message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Project Loaded, Return to Workspace'),
        duration: Duration(
            seconds: 1), // Duration for which the SnackBar is displayed
      ),
    );
  }

  // Method to clone a sensor item to ensure uniqueness
  SensorItem _cloneSensor(SensorItem original) {
    return SensorItem(
      name: original.name,
      subtitle: original.subtitle,
      secondSubtitle: original.secondSubtitle,
      imagePath: original.imagePath,
      metadata: original.metadata,
      allowedPorts:
          List.from(original.allowedPorts), // Clone allowed ports list
    );
  }

  SensorItem getSensorByName(String axmNumber) {
    return getSensors()
        .firstWhere((sensor) => sensor.secondSubtitle == axmNumber);
  }

  @override
  Widget build(BuildContext context) {
    final List<PortPosition> portPositions =
        getPortPositions(3014.0, 1095.0); // Get port positions

    return DefaultTabController(
      length: 3, // Three tabs: design mode, programming mode, and tutorial mode
      child: Scaffold(
        appBar: CustomAppBar(), // Custom AppBar with tabs and menu
        body: Container(
          color: const Color(
              0xFFECECEC), // Set the background color of the workspace here
          child: TabBarView(
            children: [
              // Design Mode
              Column(
                children: [
                  // Expanded section for PortLayout and SensorSidebar
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: PortLayout(
                            sensorPositions: sensorPositions,
                            highlightedPorts: highlightedPorts,
                            onSensorAccepted: _onSensorAccepted,
                            sensorActions: sensorActions,
                            onRightClick: _onRightClick,
                            portPositions: portPositions,
                            onEditSensor: _configureOrEditSensor,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SensorSidebar(
                            onDragStarted: _onSensorDragStarted,
                            onDragEnd: _onSensorDragEnded,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding containing the buttons at the bottom left
                  Padding(
                    padding: const EdgeInsets.all(16.0), // Add some padding
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.start, // Align to left
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE2F14F),
                            foregroundColor: const Color(0xFF121618),
                            textStyle: const TextStyle(
                              fontFamily: 'DMSANS',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPressed: () {
                            _showBuildDialog(); // Open dialog to ask what the user would like to build
                          },
                          child: const Text('Generate Matrix'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE2F14F),
                            foregroundColor: const Color(0xFF121618),
                            textStyle: const TextStyle(
                              fontFamily: 'DMSANS',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPressed: () {
                            clearAllSensorPositions();
                          },
                          child: const Text('Clear All'),
                        ),
                        const SizedBox(width: 8),
                        // Space between text field and button (if needed for future additions)
                      ],
                    ),
                  ),
                ],
              ),
              // Programming Mode
// Programming Mode
              Row(
                children: [
                  // Left side: Code editor
                  Expanded(
                    flex:
                        3, // Adjust the flex ratio to control the space distribution
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Code editor label
                          Text(
                            'Generated Code:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Customize color as needed
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Code editor
                          Expanded(
                            child: TextField(
                              controller: _codeController,
                              maxLines: null,
                              expands: true,
                              cursorColor: const Color.fromARGB(255, 0, 0, 0),
                              textAlign: TextAlign.start,
                              textAlignVertical: TextAlignVertical.top,
                              selectionControls: DesktopTextSelectionControls(),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color(
                                        0xFFE2F14F), // Change border color
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color(
                                        0xFF7a7c7c), // Change focused border color
                                    width:
                                        2.0, // Increase border thickness when focused
                                  ),
                                ),
                                labelText: 'Generated Code',
                                labelStyle: const TextStyle(
                                  color:
                                      Color(0xFF7a7c7c), // Set label text color
                                  fontFamily: 'DMSANS',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Buttons for code generation
                          Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE2F14F),
                                  foregroundColor: const Color(0xFF121618),
                                  textStyle: const TextStyle(
                                    fontFamily: 'DMSANS',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onPressed: () {
                                  // Handle upload action
                                  print("Uploading...");
                                },
                                child: const Text('Upload'),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE2F14F),
                                  foregroundColor: const Color(0xFF121618),
                                  textStyle: const TextStyle(
                                    fontFamily: 'DMSANS',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onPressed: () {
                                  // Handle debug action
                                  print("Debugging...");
                                },
                                child: const Text('Debug'),
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE2F14F),
                                  foregroundColor: const Color(0xFF121618),
                                  textStyle: const TextStyle(
                                    fontFamily: 'DMSANS',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onPressed: () {
                                  // Generate Arduino code and display it in the TextField
                                  setState(() {
                                    _codeController.text =
                                        _generateArduinoCode();
                                  });
                                  print("Generating...");
                                },
                                child:
                                    const Text('Generate Code From Workspace'),
                              ),
                              const SizedBox(width: 16),
                              DropdownButton<String>(
                                hint: const Text('Select COM Port'),
                                value: _selectedPort,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedPort = newValue;
                                  });
                                },
                                items: _comPorts.map<DropdownMenuItem<String>>(
                                    (String port) {
                                  return DropdownMenuItem<String>(
                                    value: port,
                                    child: Text(port),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 1, // Adjust flex ratio for space distribution
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Added Sensors label
                          Text(
                            'Added Sensors:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Customize color as needed
                            ),
                          ),
                          const SizedBox(height: 8),
                          // List of all added sensors (configured and unconfigured)
                          sensorPositions.isNotEmpty
                              ? Expanded(
                                  child: ListView.builder(
                                    itemCount: sensorPositions.length,
                                    itemBuilder: (context, index) {
                                      String portName =
                                          sensorPositions.keys.elementAt(index);
                                      SensorItem? sensor =
                                          sensorPositions[portName];

                                      // Check if the sensor has been configured (exists in sensorActions)
                                      bool isConfigured =
                                          sensorActions.containsKey(portName);

                                      return ListTile(
                                        leading: Image.asset(
                                          sensor!
                                              .imagePath, // Display sensor image
                                          width: 40, // Customize the image size
                                          height:
                                              40, // Customize the image size
                                          fit: BoxFit
                                              .contain, // Adjust the image fit
                                        ),
                                        title: Text(
                                          sensor.name,
                                          style: const TextStyle(
                                            color: Colors
                                                .black, // Customize color as needed
                                          ),
                                        ),
                                        subtitle: Text(
                                          'Port: $portName', // Display port name below the sensor name
                                          style: const TextStyle(
                                            color: Colors
                                                .grey, // Customize subtitle color as needed
                                          ),
                                        ),
                                        // Add a warning icon if the sensor is not configured
                                        trailing: isConfigured
                                            ? IconButton(
                                                icon: const Icon(
                                                  Icons.build,
                                                  color: Colors
                                                      .grey, // Wrench icon for configured sensors
                                                ),
                                                onPressed: () {
                                                  // Show configuration dialog for configured sensor
                                                  _configureOrEditSensor(
                                                      portName, sensor,
                                                      isEditing: true);
                                                },
                                              )
                                            : Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(
                                                    Icons.warning_amber_rounded,
                                                    color: Colors
                                                        .red, // Warning icon for unconfigured sensors
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.build,
                                                      color: Colors
                                                          .grey, // Wrench icon for unconfigured sensors
                                                    ),
                                                    onPressed: () {
                                                      // Show configuration dialog for unconfigured sensor
                                                      _configureOrEditSensor(
                                                          portName,
                                                          sensor); // Opens the configuration dialog
                                                    },
                                                  ),
                                                ],
                                              ),
                                      );
                                    },
                                  ),
                                )
                              : const Text(
                                  'No sensors added yet.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors
                                        .black54, // Greyed out text for no sensors
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Tutorial Mode
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Axiometa Genesis ESP32',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Use LayoutBuilder to make the GridView responsive
                    LayoutBuilder(
                      builder: (context, constraints) {
                        // Define the fixed box width
                        const double boxWidth = 270.0;
                        const double spacing = 16.0;

                        // Calculate how many boxes can fit in the current screen width
                        int crossAxisCount =
                            (constraints.maxWidth / (boxWidth + spacing))
                                .floor();

                        // Define a list of tutorial data
                        final tutorials = [
                          {
                            'title': 'Electronic Dice',
                            'description': 'Level: Beginner',
                            'imagePath': 'assets/images/pcb_dice.png',
                            'onBoxTap': () => _loadTutorial('Electronic Dice'),
                            'onStartTap': () =>
                                _loadTutorial('Electronic Dice'),
                            'buyKitUrl': 'https://axiometa.ai/',
                          },
                          {
                            'title': 'RGB Mixer',
                            'description': 'Level: Beginner',
                            'imagePath': 'assets/images/pcb_dice.png',
                            'onBoxTap': () => _loadTutorial('RGB Mixer'),
                            'onStartTap': () => _loadTutorial('RGB Mixer'),
                            'buyKitUrl': 'https://axiometa.ai/',
                          },
                        ];

                        return GridView.builder(
                          shrinkWrap:
                              true, // Ensures the GridView doesn't expand infinitely
                          physics:
                              const NeverScrollableScrollPhysics(), // Disable scrolling inside GridView
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                crossAxisCount, // Number of boxes per row based on screen size
                            crossAxisSpacing:
                                spacing, // Horizontal space between boxes
                            mainAxisSpacing:
                                spacing, // Vertical space between boxes
                            childAspectRatio:
                                1, // Aspect ratio to make boxes square
                          ),
                          itemCount:
                              tutorials.length, // Total number of tutorials
                          itemBuilder: (context, index) {
                            // Dynamically build the tutorial boxes using the list data
                            final tutorial = tutorials[index];
                            return buildTutorialBox(
                              title: tutorial['title'] as String,
                              description: tutorial['description'] as String,
                              imagePath: tutorial['imagePath'] as String,
                              onBoxTap: tutorial['onBoxTap'] as VoidCallback,
                              onStartTap:
                                  tutorial['onStartTap'] as VoidCallback,
                              buyKitUrl: tutorial['buyKitUrl'] as String,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
