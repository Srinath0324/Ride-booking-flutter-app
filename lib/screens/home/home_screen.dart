import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_booking_app/providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  // Add dummy location suggestions
  final List<String> _locationSuggestions = [
    'Home - 123 Main Street',
    'Office - Business Park',
    'Mall - City Center',
    'Airport - Terminal 1',
    'Railway Station - Central',
    'Hospital - Medical Complex',
  ];

  bool _showPickupSuggestions = false;
  bool _showDestinationSuggestions = false;

  // Add filtered suggestions lists
  List<String> _filteredPickupSuggestions = [];
  List<String> _filteredDestinationSuggestions = [];

  @override
  void dispose() {
    _pickupController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Ride'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              if (!mounted) return;
              final navigator = Navigator.of(context);

              await Provider.of<AuthProvider>(context, listen: false).logout();
              if (!mounted) return;
              navigator.pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bars with suggestions
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Pickup location with filtered suggestions
                Column(
                  children: [
                    TextField(
                      controller: _pickupController,
                      decoration: const InputDecoration(
                        labelText: 'Pickup Location',
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _showPickupSuggestions = value.isNotEmpty;
                          _showDestinationSuggestions = false;
                          // Filter suggestions based on input
                          _filteredPickupSuggestions =
                              _locationSuggestions
                                  .where(
                                    (location) => location
                                        .toLowerCase()
                                        .contains(value.toLowerCase()),
                                  )
                                  .toList();
                        });
                      },
                    ),
                    if (_showPickupSuggestions &&
                        _filteredPickupSuggestions.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha(77),
                              spreadRadius: 1,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: _filteredPickupSuggestions.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              dense: true,
                              title: Text(_filteredPickupSuggestions[index]),
                              onTap: () {
                                setState(() {
                                  _pickupController.text =
                                      _filteredPickupSuggestions[index];
                                  _showPickupSuggestions = false;
                                });
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                // Destination with filtered suggestions
                Column(
                  children: [
                    TextField(
                      controller: _destinationController,
                      decoration: const InputDecoration(
                        labelText: 'Destination',
                        prefixIcon: Icon(Icons.location_on),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _showDestinationSuggestions = value.isNotEmpty;
                          _showPickupSuggestions = false;
                          // Filter suggestions based on input
                          _filteredDestinationSuggestions =
                              _locationSuggestions
                                  .where(
                                    (location) => location
                                        .toLowerCase()
                                        .contains(value.toLowerCase()),
                                  )
                                  .toList();
                        });
                      },
                    ),
                    if (_showDestinationSuggestions &&
                        _filteredDestinationSuggestions.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha(77),
                              spreadRadius: 1,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: _filteredDestinationSuggestions.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              dense: true,
                              title: Text(
                                _filteredDestinationSuggestions[index],
                              ),
                              onTap: () {
                                setState(() {
                                  _destinationController.text =
                                      _filteredDestinationSuggestions[index];
                                  _showDestinationSuggestions = false;
                                });
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          // Improved static map placeholder
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: Stack(
                children: [
                  // Grid pattern for map-like appearance
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 15,
                        ),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 0.5,
                          ),
                        ),
                      );
                    },
                  ),
                  // Map markers and route
                  CustomPaint(size: Size.infinite, painter: RoutePathPainter()),
                  // Center location indicator
                  const Center(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                  // Zoom controls
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Column(
                      children: [
                        FloatingActionButton.small(
                          onPressed: () {},
                          child: const Icon(Icons.add),
                        ),
                        const SizedBox(height: 8),
                        FloatingActionButton.small(
                          onPressed: () {},
                          child: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Ride options
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(77),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Available Rides',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/booking');
                        },
                        child: const Text('Drive Now'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (!mounted) return;
                          final messenger = ScaffoldMessenger.of(context);

                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 7),
                            ),
                          );

                          if (date != null && mounted) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            if (time != null && mounted) {
                              final timeStr = time.format(context);
                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Ride scheduled for ${date.toString().split(' ')[0]} at $timeStr',
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text('Schedule'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for route path
class RoutePathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.blue.withAlpha(128)
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;

    final path =
        Path()
          ..moveTo(size.width * 0.2, size.height * 0.3)
          ..quadraticBezierTo(
            size.width * 0.5,
            size.height * 0.5,
            size.width * 0.8,
            size.height * 0.7,
          );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
