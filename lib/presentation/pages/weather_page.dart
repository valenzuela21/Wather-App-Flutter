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
        title: const Text('Weather'),
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final weather = controller.weather.value;

        if (weather == null) {
          return const Center(
            child: Text(
              'No weather data found',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return Column(
          children: [
            _WeatherHeader(
              city: weather.city,
              condition: weather.condition,
              temp: weather.currentTemp,
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: weather.forecast.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, index) {
                  final day = weather.forecast[index];

                  return _ForecastCard(
                    date: day.date,
                    condition: day.conditions,
                    min: day.tempMin,
                    max: day.tempMax,
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

class _WeatherHeader extends StatelessWidget {
  final String city;
  final String condition;
  final double temp;

  const _WeatherHeader({
    required this.city,
    required this.condition,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 70,
        left: 20,
        right: 20,
        bottom: 30,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            city,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            condition,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${temp.toStringAsFixed(0)}°',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ForecastCard extends StatelessWidget {
  final DateTime date;
  final String condition;
  final double min;
  final double max;

  const _ForecastCard({
    required this.date,
    required this.condition,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date.toString().split(' ').first,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                condition,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),

          Text(
            '${min.toStringAsFixed(0)}° / ${max.toStringAsFixed(0)}°',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}