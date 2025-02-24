import 'package:flutter/material.dart';

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
    {
      'date': '2024-03-13',
      'from': 'Mall',
      'to': 'Home',
      'amount': '₹220',
    },
  ];

  bool _isRideHistoryExpanded = false;

  void _showEditProfileDialog(BuildContext context) {
    final nameController = TextEditingController(text: 'John Doe');
    final mobileController = TextEditingController(text: '+91 98765 43210');
    final aadharController = TextEditingController(text: '1234 5678 9012');
    String selectedGender = 'Male';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: mobileController,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: aadharController,
                decoration: const InputDecoration(
                  labelText: 'Aadhar Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                onChanged: (value) {
                  selectedGender = value!;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement profile update
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff4f46e5),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = const Color(0xff4f46e5);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profile',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Profile Picture
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: primaryColor,
                        width: 2,
                      ),
                      color: primaryColor.withOpacity(0.1),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Color(0xff4f46e5),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'John Doe',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Color(0xff4f46e5),
                        ),
                        onPressed: () => _showEditProfileDialog(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Phone Number
                  Text(
                    '+91 98765 43210',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Stats Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(
                    context,
                    '43',
                    'Total Rides',
                    Icons.directions_car,
                  ),
                  _buildStatItem(
                    context,
                    '4.8',
                    'Rating',
                    Icons.star,
                  ),
                  _buildStatItem(
                    context,
                    '₹2,450',
                    'Saved',
                    Icons.savings,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Menu Items
            ExpansionTile(
              title: const Text(
                'Your Rides',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(
                Icons.history,
                color: Colors.grey[700],
              ),
              children: _rideHistory.map((ride) {
                return ListTile(
                  leading: const Icon(Icons.directions_car),
                  title: Text('${ride['from']} → ${ride['to']}'),
                  subtitle: Text(ride['date']!),
                  trailing: Text(
                    ride['amount']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4f46e5),
                    ),
                  ),
                );
              }).toList(),
            ),
            _buildMenuItem(
              context,
              'Payment Methods',
              Icons.payment,
              onTap: () {},
            ),
            _buildMenuItem(
              context,
              'Notifications',
              Icons.notifications_none,
              onTap: () {},
            ),
            _buildMenuItem(
              context,
              'Privacy Settings',
              Icons.privacy_tip_outlined,
              onTap: () {},
            ),
            _buildMenuItem(
              context,
              'Help & Support',
              Icons.help_outline,
              onTap: () {},
            ),
            _buildMenuItem(
              context,
              'About Us',
              Icons.info_outline,
              onTap: () {},
            ),
            const SizedBox(height: 24),
            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[50],
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xff4f46e5).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: const Color(0xff4f46e5),
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon, {
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Colors.grey[700],
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
    );
  }
}