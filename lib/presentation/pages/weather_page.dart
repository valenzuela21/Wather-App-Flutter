import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wheaterapp/presentation/widgets/app_drawer.dart';

import '../controllers/weather_controller.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final controller = Get.find<WeatherController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadWeather('Bogotá');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Lats 5 days'),
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final weather = controller.weather.value;

        if (weather == null) {
          return const Center(
            child: Text('Not Found'),
          );
        }

        return Column(
          children: [
            Card(
              child: ListTile(
                title: Text(weather.city),
                subtitle: Text(weather.condition),
                trailing: Text(
                  '${weather.currentTemp}°C',
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: weather.forecast.length,
                itemBuilder: (_, index) {
                  final day = weather.forecast[index];

                  return ListTile(
                    title: Text(day.conditions),
                    subtitle: Text(
                      day.date.toString().split(' ').first,
                    ),
                    trailing: Text(
                      '${day.tempMin}° / ${day.tempMax}°',
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}