
import 'package:flutter/material.dart';
import 'customer_management.dart';
import 'tailor_management.dart';
import 'package:pie_chart/pie_chart.dart';
import '../models/User.dart' as MyUser;
class AdminPanelScreen extends StatelessWidget {
  AdminPanelScreen(MyUser.User userdata , {Key? key});

  final Map<String, double> dataMap = {
    "Tailors": 40,
    "Customers": 100,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: const Color(0xff26495c),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16.0),
              children: [
                AdminMenuItem(
                  icon: Icons.people,
                  title: 'Tailors',
                  color: const Color(0xffc66b3d),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TailorManagementPage()),
                    );
                  },
                ),
                AdminMenuItem(
                  icon: Icons.person,
                  color: const Color(0xffc4a35a),
                  title: 'Customers',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CustomerManagementPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 400,
            child: PieChart(
              dataMap: dataMap,
              animationDuration: const Duration(milliseconds: 800),
              chartLegendSpacing: 30,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              colorList: const [
                Color(0xffc66b3d),
                Color(0xffc4a35a),
              ],
              initialAngleInDegree: 0,
              chartType: ChartType.ring,
              ringStrokeWidth: 60,
              legendOptions: const LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.bottom,
                showLegends: true,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                decimalPlaces: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class AdminMenuItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final VoidCallback onPressed;

  const AdminMenuItem({super.key,
    required this.color,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(

        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48.0),
            const SizedBox(height: 8.0),
            Text(title),
          ],
        ),
      ),
    );

  }
}
