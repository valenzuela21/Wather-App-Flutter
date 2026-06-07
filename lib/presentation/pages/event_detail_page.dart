import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wheaterapp/presentation/widgets/app_drawer.dart';
import '../../domain/entities/weather_event.dart';

class EventDetailPage extends StatelessWidget {

  const EventDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final WeatherEvent event = Get.arguments as WeatherEvent;
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _DetailCard(event: event),
            ),
          ),
        ],
      ),
    );
  }
}


class _DetailCard extends StatelessWidget {
  final WeatherEvent event;

  const _DetailCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            event.description,
            style: TextStyle(
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 20),

          const Divider(),

          const SizedBox(height: 20),

          _InfoRow(
            icon: Icons.calendar_today,
            label: 'Date',
            value: event.dateTime.toString(),
          ),

          if (event.latitude != null)
            _InfoRow(
              icon: Icons.place,
              label: 'Latitude',
              value: event.latitude.toString(),
            ),

          if (event.longitude != null)
            _InfoRow(
              icon: Icons.place_outlined,
              label: 'Longitude',
              value: event.longitude.toString(),
            ),
        ],
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String type;

  const _TypeChip({required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        type,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}


class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),

          Text(
            value,
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}