import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_booking_app/providers/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<Map<String, String>> _rideHistory = [
    {
      'date': '2024-03-15',
      'from': 'Home',
      'to': 'Office',
      'amount': '₹250',
    },
    {
      'date': '2024-03-14',
      'from': 'Office',
      'to': 'Mall',
      'amount': '₹180',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Theme.of(context).primaryColor.withAlpha(30),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 50),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('+91 98765 43210'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _showEditProfileDialog(context);
                    },
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
            ),
            // Settings List
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notifications'),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {
                      // TODO: Implement notifications toggle
                    },
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.security),
                  title: const Text('Privacy Settings'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: Navigate to privacy settings
                  },
                ),
                const Divider(),
                // Ride History Section
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Recent Rides',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _rideHistory.length,
                  itemBuilder: (context, index) {
                    final ride = _rideHistory[index];
                    return ListTile(
                      leading: const Icon(Icons.directions_car),
                      title: Text('${ride['from']} → ${ride['to']}'),
                      subtitle: Text(ride['date']!),
                      trailing: Text(
                        ride['amount']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () async {
                    if (!mounted) return;
                    final navigator = Navigator.of(context);
                    
                    await Provider.of<AuthProvider>(context, listen: false)
                        .logout();
                    if (!mounted) return;
                    navigator.pushReplacementNamed('/login');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement profile update
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
} 