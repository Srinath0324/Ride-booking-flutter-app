import 'package:flutter/material.dart';

class RideProgressScreen extends StatefulWidget {
  const RideProgressScreen({super.key});

  @override
  State<RideProgressScreen> createState() => _RideProgressScreenState();
}

class _RideProgressScreenState extends State<RideProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ride in Progress')),
      body: Stack(
        children: [
          // Map View
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Map View',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          // Driver Info Card
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(child: Icon(Icons.person)),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Doe',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('Toyota Camry - DL 01 AB 1234'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.access_time, color: Colors.blue[700]),
                            const Text('15 mins'),
                            const Text('ETA'),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.route, color: Colors.blue[700]),
                            const Text('5.2 km'),
                            const Text('Distance'),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.currency_rupee, color: Colors.blue[700]),
                            const Text('₹250'),
                            const Text('Fare'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom Actions
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement call functionality
                      },
                      icon: const Icon(Icons.phone),
                      label: const Text('Call Driver'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/ride-complete',
                        );
                      },
                      icon: const Icon(Icons.cancel),
                      label: const Text('End Ride'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
