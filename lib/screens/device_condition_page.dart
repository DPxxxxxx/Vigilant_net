import 'package:flutter/material.dart';

class DeviceConditionPage extends StatefulWidget {
  const DeviceConditionPage({super.key});

  @override
  State<DeviceConditionPage> createState() => _DeviceConditionPageState();
}

class _DeviceConditionPageState extends State<DeviceConditionPage> {
  final Map<String, Map<String, dynamic>> _healthMetrics = {
    'Battery Health': {
      'icon': Icons.battery_charging_full,
      'value': 92,
      'status': 'Good',
      'color': Colors.green,
    },
    'RAM Usage': {
      'icon': Icons.memory,
      'value': 65,
      'status': 'Moderate',
      'color': Colors.orange,
    },
    'Storage Health': {
      'icon': Icons.storage,
      'value': 88,
      'status': 'Good',
      'color': Colors.green,
    },
    'System Temp': {
      'icon': Icons.thermostat,
      'value': 75,
      'status': 'Normal',
      'color': Colors.blue,
    },
  };

  final List<Map<String, dynamic>> _optimizationTips = [
    {
      'title': 'High RAM Usage',
      'description': 'Close unused applications to improve performance',
      'icon': Icons.memory,
      'severity': 'Warning',
    },
    {
      'title': 'Background Apps',
      'description': '6 apps running in background consuming resources',
      'icon': Icons.apps,
      'severity': 'Info',
    },
    {
      'title': 'System Update',
      'description': 'New security update available',
      'icon': Icons.system_update,
      'severity': 'Critical',
    },
  ];

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
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text(
                  'Device Condition',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Overall Health Score
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Overall Health',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '85%',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            LinearProgressIndicator(
                              value: 0.85,
                              backgroundColor: Colors.white24,
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                              minHeight: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Health Metrics Grid
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Health Metrics',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                childAspectRatio: 1.5,
                              ),
                              itemCount: _healthMetrics.length,
                              itemBuilder: (context, index) {
                                String key = _healthMetrics.keys.elementAt(index);
                                Map<String, dynamic> metric = _healthMetrics[key]!;
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            metric['icon'] as IconData,
                                            color: metric['color'] as Color,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            key,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${metric['value']}%',
                                        style: TextStyle(
                                          color: metric['color'] as Color,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        metric['status'] as String,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Optimization Tips
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Optimization Tips',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: _optimizationTips.length,
                                  itemBuilder: (context, index) {
                                    final tip = _optimizationTips[index];
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: _getSeverityColor(tip['severity']).withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              tip['icon'] as IconData,
                                              color: _getSeverityColor(tip['severity']),
                                              size: 24,
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  tip['title'] as String,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  tip['description'] as String,
                                                  style: const TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
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
            ],
          ),
        ),
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity) {
      case 'Critical':
        return Colors.red;
      case 'Warning':
        return Colors.orange;
      case 'Info':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
} 