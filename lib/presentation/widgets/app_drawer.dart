import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF1565C0),
            ),
            child: Text(
              'Weather App',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.event),
            title: const Text('Events'),
            onTap: () {
              Get.toNamed(Routes.events);
            },
          ),

          ListTile(
            leading: const Icon(Icons.cloud),
            title: const Text('Weather'),
            onTap: () {
              Get.toNamed(Routes.weather);
            },
          ),
        ],
      ),
    );
  }
}