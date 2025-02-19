import 'package:flutter/material.dart';

class DriverMatchingScreen extends StatefulWidget {
  const DriverMatchingScreen({super.key});

  @override
  State<DriverMatchingScreen> createState() => _DriverMatchingScreenState();
}

class _DriverMatchingScreenState extends State<DriverMatchingScreen> {
  final List<Map<String, dynamic>> _dummyDrivers = [
    {
      'name': 'John Doe',
      'rating': 4.8,
      'car': 'Toyota Camry',
      'plate': 'DL 01 AB 1234',
      'eta': '3 mins',
    },
    {
      'name': 'Jane Smith',
      'rating': 4.9,
      'car': 'Honda City',
      'plate': 'DL 02 CD 5678',
      'eta': '5 mins',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finding Driver'),
      ),
      body: Column(
        children: [
          // Driver search animation
          Container(
            padding: const EdgeInsets.all(20),
            child: const Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'Matching you with nearby drivers...',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          // Available drivers list
          Expanded(
            child: ListView.builder(
              itemCount: _dummyDrivers.length,
              itemBuilder: (context, index) {
                final driver = _dummyDrivers[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(driver['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${driver['car']} - ${driver['plate']}'),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber[700],
                            ),
                            Text(' ${driver['rating']}'),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.access_time,
                              size: 16,
                            ),
                            Text(' ${driver['eta']}'),
                          ],
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/ride-progress');
                      },
                      child: const Text('Accept'),
                    ),
                  ),
                );
              },
            ),
          ),
          // Bottom actions
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel Ride'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Change Pickup'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 