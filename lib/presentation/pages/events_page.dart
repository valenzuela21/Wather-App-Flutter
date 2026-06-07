import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wheaterapp/presentation/widgets/app_drawer.dart';
import '../controllers/weather_controller.dart';
import '../routes/app_routes.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final controller = Get.find<WeatherController>();


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadEvents('Bogotá');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Events Weather'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.loading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.events.isEmpty) {
                return const Center(
                  child: Text(
                    'No events found',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: controller.events.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, index) {
                  final event = controller.events[index];

                  return _EventCard(
                    title: event.title,
                    type: event.type,
                    onTap: () {
                      Get.toNamed(
                        Routes.eventDetail,
                        arguments: event,
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}


class _EventCard extends StatelessWidget {
  final String title;
  final String type;
  final VoidCallback onTap;

  const _EventCard({
    required this.title,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          children: [
            _IconBadge(type: type),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  final String type;

  const _IconBadge({required this.type});

  IconData _getIcon() {
    switch (type.toLowerCase()) {
      case 'storm':
        return Icons.thunderstorm;
      case 'rain':
        return Icons.grain;
      case 'sun':
        return Icons.wb_sunny;
      default:
        return Icons.cloud;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        _getIcon(),
        color: Colors.blue,
      ),
    );
  }
}