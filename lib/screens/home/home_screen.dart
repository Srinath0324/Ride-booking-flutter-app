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
    final theme = Theme.of(context);
    final primaryColor = const Color(0xff4f46e5);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Gradient Header
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  primaryColor,
                  primaryColor.withOpacity(0.9),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with profile
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hey, ${Provider.of<AuthProvider>(context).userName ?? 'User'} 👋',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/profile'),
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            child: const Icon(Icons.person, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Search inputs
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: _pickupController,
                            decoration: InputDecoration(
                              hintText: 'Pick up ',
                              prefixIcon: Icon(Icons.location_on_outlined, color: primaryColor),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _showPickupSuggestions = value.isNotEmpty;
                                _filteredPickupSuggestions = _locationSuggestions
                                    .where((location) => location.toLowerCase().contains(value.toLowerCase()))
                                    .toList();
                              });
                            },
                          ),
                          Divider(height: 1, color: Colors.grey[200]),
                          TextField(
                            controller: _destinationController,
                            decoration: InputDecoration(
                              hintText: 'Destination',
                              prefixIcon: Icon(Icons.location_on, color: primaryColor),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _showDestinationSuggestions = value.isNotEmpty;
                                _filteredDestinationSuggestions = _locationSuggestions
                                    .where((location) => location.toLowerCase().contains(value.toLowerCase()))
                                    .toList();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
          // Location suggestions if any
          if (_showPickupSuggestions && _filteredPickupSuggestions.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: _filteredPickupSuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    dense: true,
                    title: Text(_filteredPickupSuggestions[index]),
                    onTap: () {
                      setState(() {
                        _pickupController.text = _filteredPickupSuggestions[index];
                        _showPickupSuggestions = false;
                      });
                    },
                  );
                },
              ),
            ),
          if (_showDestinationSuggestions && _filteredDestinationSuggestions.isNotEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: _filteredDestinationSuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    dense: true,
                    title: Text(_filteredDestinationSuggestions[index]),
                    onTap: () {
                      setState(() {
                        _destinationController.text = _filteredDestinationSuggestions[index];
                        _showDestinationSuggestions = false;
                      });
                    },
                  );
                },
              ),
            ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Map placeholder
                if (!_showPickupSuggestions && !_showDestinationSuggestions)
                  Container(
                    height: 200,
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        ),
                        CustomPaint(
                          size: Size.infinite,
                          painter: RoutePathPainter(),
                        ),
                        Center(
                          child: Icon(
                            Icons.location_on,
                            color: primaryColor,
                            size: 40,
                          ),
                        ),
                        Positioned(
                          right: 16,
                          bottom: 16,
                          child: Column(
                            children: [
                              FloatingActionButton.small(
                                heroTag: 'zoom_in',
                                backgroundColor: Colors.white,
                                elevation: 2,
                                onPressed: () {},
                                child: Icon(Icons.add, color: primaryColor),
                              ),
                              const SizedBox(height: 8),
                              FloatingActionButton.small(
                                heroTag: 'zoom_out',
                                backgroundColor: Colors.white,
                                elevation: 2,
                                onPressed: () {},
                                child: Icon(Icons.remove, color: primaryColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                Text(
                  'Choose your ride',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildRideOption(
                        context,
                        icon: Icons.directions_car,
                        title: 'Drive Now',
                        subtitle: 'From ₹250',
                        onTap: () => Navigator.pushNamed(context, '/booking'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildRideOption(
                        context,
                        icon: Icons.schedule,
                        title: 'Schedule',
                        subtitle: 'Book ahead',
                        onTap: () async {
                          if (!mounted) return;
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 7)),
                          );

                          if (date != null && mounted) {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            if (time != null && mounted) {
                              final timeStr = time.format(context);
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Ride scheduled for ${date.toString().split(' ')[0]} at $timeStr',
                                  ),
                                ),
                              );
                              Navigator.pushNamed(context, '/booking');
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Recent Rides',
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                _buildRecentRide(
                  context,
                  icon: Icons.home,
                  title: 'Home → Office',
                  subtitle: '5.2 km • 15 mins',
                  date: 'March 15, 2024',
                  price: '₹250',
                  rating: 4.8,
                ),
                const SizedBox(height: 12),
                _buildRecentRide(
                  context,
                  icon: Icons.business,
                  title: 'Office → Mall',
                  subtitle: '3.8 km • 12 mins',
                  date: 'March 14, 2024',
                  price: '₹180',
                  rating: 4.9,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRideOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final primaryColor = const Color(0xff4f46e5);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: primaryColor.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: primaryColor),
            const SizedBox(height: 12),
            Text(title, style: theme.textTheme.titleLarge?.copyWith(fontSize: 16)),
            const SizedBox(height: 4),
            Text(subtitle, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentRide(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String date,
    required String price,
    required double rating,
  }) {
    final theme = Theme.of(context);
    final primaryColor = const Color(0xff4f46e5);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: primaryColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(subtitle, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 4),
                Text(date, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price, style: theme.textTheme.titleMedium),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(rating.toString(), style: theme.textTheme.bodyMedium),
                ],
              ),
            ],
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
    final paint = Paint()
      ..color = const Color(0xff4f46e5).withAlpha(128)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path()
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
