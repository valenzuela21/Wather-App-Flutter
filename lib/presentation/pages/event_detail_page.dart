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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.type,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            Text(
              event.description,
            ),

            const SizedBox(height: 16),

            Text(
              'Fecha: ${event.dateTime}',
            ),

            if (event.latitude != null)
              Text('Latitud: ${event.latitude}'),

            if (event.longitude != null)
              Text('Longitud: ${event.longitude}'),
          ],
        ),
      ),
    );
  }
}