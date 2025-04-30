import 'dart:async';

import 'package:flutter/material.dart';
import 'cpu_usage_page.dart';
import 'antivirus_check_page.dart';
import 'cleaner_page.dart';
import 'data_page.dart';
import 'device_condition_page.dart';
import 'storage_page.dart';
import 'connected_devices_page.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _bottomSheetController;
  double _optimizationPercentage = 65.0;
  late Timer _percentageTimer;
  final Random _random = Random();
  bool _isIncreasing = true;

  @override
  void initState() {
    super.initState();
    _bottomSheetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _bottomSheetController.forward();

    // Initialize timer to update percentage
    _percentageTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        if (_isIncreasing) {
          _optimizationPercentage += _random.nextDouble() * 2;
          if (_optimizationPercentage >= 95) {
            _isIncreasing = false;
          }
        } else {
          _optimizationPercentage -= _random.nextDouble() * 2;
          if (_optimizationPercentage <= 60) {
            _isIncreasing = true;
          }
        }
        // Ensure percentage stays within bounds
        _optimizationPercentage = _optimizationPercentage.clamp(60.0, 95.0);
      });
    });
  }

  @override
  void dispose() {
    _bottomSheetController.dispose();
    _percentageTimer.cancel();
    super.dispose();
  }

  void _showGridBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Color(0xFF1a237e),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Quick Actions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // Grid
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: [
                      _buildGridItem('CPU Usage', Icons.memory),
                      _buildGridItem('Device Condition', Icons.health_and_safety),
                      _buildGridItem('Antivirus Check', Icons.security),
                      _buildGridItem('Cleaner', Icons.cleaning_services),
                      _buildGridItem('Data', Icons.data_usage),
                      _buildGridItem('Storage', Icons.storage),
                      _buildGridItem('Connected Devices', Icons.devices),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1a237e), // Deep blue
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    // Handle menu button press
                  },
                ),
                title: const Text(
                  'Antivirus Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Optimization Percentage
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Background circle
                            Container(
                              width: 300,
                              height:200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                            // Progress indicator
                            SizedBox(
                              width: 300,
                              height: 300,
                              child: CircularProgressIndicator(
                                value: _optimizationPercentage / 100,
                                strokeWidth: 30,
                                backgroundColor: Colors.transparent,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  _getColorForPercentage(_optimizationPercentage),
                                ),
                              ),
                            ),
                            // Percentage text
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${_optimizationPercentage.round()}%',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 64,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _getStatusText(_optimizationPercentage),
                                  style: TextStyle(
                                    color: _getColorForPercentage(_optimizationPercentage),
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'System Optimization Status',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showGridBottomSheet,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.apps, color: Colors.white),
      ),
    );
  }

  Color _getColorForPercentage(double percentage) {
    if (percentage >= 90) {
      return Colors.green;
    } else if (percentage >= 75) {
      return Colors.blue;
    } else if (percentage >= 60) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String _getStatusText(double percentage) {
    if (percentage >= 90) {
      return 'Excellent';
    } else if (percentage >= 75) {
      return 'Good';
    } else if (percentage >= 60) {
      return 'Fair';
    } else {
      return 'Poor';
    }
  }

  Widget _buildGridItem(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Close the bottom sheet
        if (title == 'CPU Usage') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CpuUsagePage()),
          );
        } else if (title == 'Antivirus Check') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AntivirusCheckPage()),
          );
        } else if (title == 'Cleaner') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CleanerPage()),
          );
        } else if (title == 'Data') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DataPage()),
          );
        } else if (title == 'Device Condition') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DeviceConditionPage()),
          );
        } else if (title == 'Storage') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StoragePage()),
          );
        } else if (title == 'Connected Devices') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ConnectedDevicesPage()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blue, size: 24),
            const SizedBox(height: 4),
            Flexible(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 