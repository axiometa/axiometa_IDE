import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  // State variables to track hover for each menu button
  bool isFileHovering = false;
  bool isToolsHovering = false;
  bool isOptionsHovering = false;
  bool isHelpHovering = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0, // Reduce title spacing for a cleaner look
      toolbarHeight: 40, // Adjust AppBar height to make it smaller
      backgroundColor: const Color(0xFF3A3C3D),
      title: Row(
        children: [
          _buildPopupMenuButton(
            'File',
            [
              const PopupMenuItem(value: "New File", child: Text("New File")),
              const PopupMenuItem(value: "Open", child: Text("Open")),
              const PopupMenuItem(value: "Save", child: Text("Save")),
              const PopupMenuItem(value: "Exit", child: Text("Exit")),
            ],
            isFileHovering, // Track hover state for the File button
            (hovering) {
              setState(() {
                isFileHovering = hovering;
              });
            },
          ),
          _buildPopupMenuButton(
            'Tools',
            [
              const PopupMenuItem(value: "Tool 1", child: Text("Tool 1")),
              const PopupMenuItem(value: "Tool 2", child: Text("Tool 2")),
            ],
            isToolsHovering, // Track hover state for the Tools button
            (hovering) {
              setState(() {
                isToolsHovering = hovering;
              });
            },
          ),
          _buildPopupMenuButton(
            'Options',
            [
              const PopupMenuItem(value: "Option 1", child: Text("Option 1")),
              const PopupMenuItem(value: "Option 2", child: Text("Option 2")),
            ],
            isOptionsHovering, // Track hover state for the Options button
            (hovering) {
              setState(() {
                isOptionsHovering = hovering;
              });
            },
          ),
          _buildPopupMenuButton(
            'Help',
            [
              const PopupMenuItem(value: "Help", child: Text("Help")),
              const PopupMenuItem(value: "About", child: Text("About")),
            ],
            isHelpHovering, // Track hover state for the Help button
            (hovering) {
              setState(() {
                isHelpHovering = hovering;
              });
            },
          ),
        ],
      ),
      bottom: TabBar(
        indicatorColor: const Color(0xFFECECEC), // Custom tab indicator color
        indicatorWeight: 5.0, // Thickness of the indicator
        labelColor:
            const Color.fromARGB(255, 255, 255, 255), // Active tab label color
        unselectedLabelColor:
            const Color(0xFF9E9E9E), // Inactive tab label color
        labelStyle: const TextStyle(
          fontFamily: 'DMSANS',
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color.fromARGB(
                  30, 225, 241, 79); // Remove ripple on press
            } else if (states.contains(MaterialState.hovered)) {
              return const Color(0x000000); // Remove hover effect
            }
            return null; // Default state
          },
        ),
        tabs: const [
          Tab(text: "Workspace"),
          Tab(text: "Code"),
          Tab(text: "Tutorials"),
        ],
      ),
    );
  }

  // Method to build a PopupMenuButton with hover support
  Widget _buildPopupMenuButton(String title, List<PopupMenuItem<String>> items,
      bool isHovering, ValueChanged<bool> onHover) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: PopupMenuButton<String>(
        onSelected: (value) {},
        itemBuilder: (BuildContext context) => items,
        color: const Color(0xFFFFFFFF), // Background color for the popup
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            title,
            style: TextStyle(
              color: isHovering
                  ? const Color(0xFFE2F14F) // Hover color
                  : Colors.white, // Default color
              fontFamily: 'DMSANS',
              fontWeight: FontWeight.w100,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
